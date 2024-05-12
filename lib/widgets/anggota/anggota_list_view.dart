import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/providers/profile_provider.dart';
import 'package:progmob_magical_destroyers/screens/savings_loan/update_anggota_screen.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:progmob_magical_destroyers/widgets/text_label.dart';

class AnggotaListView extends StatelessWidget {
  final List<Anggota> items;
  final Function(Anggota) updateAnggotaCallback;
  final Function(Anggota) deleteAnggotaCallback;

  const AnggotaListView({
    super.key,
    required this.items,
    required this.updateAnggotaCallback,
    required this.deleteAnggotaCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade300,
            indent: 20,
            endIndent: 20,
          ),
          shrinkWrap: true,
          itemCount: items.length > 3 ? 3 : items.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Anggota item = items[index];
            return ListTile(
              leading: GestureDetector(
                onTap: () {
                  Get.to(
                      () => ShowPhotoView(image: AssetImage(defaultImagePath)));
                },
                child: CircleAvatar(
                  backgroundColor: ColorPlanet.primary,
                  backgroundImage: AssetImage(defaultImagePath),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nama,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      TextLabel(
                          text:
                              '${HelplessUtil.calculateAge(DateTime.parse(item.tglLahir))} years'),
                      SizedBox(width: 5),
                      Text(
                        '| ${item.telepon}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorPlanet.primary,
                      ),
                      SizedBox(width: 5),
                      Text(
                        item.alamat,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              style: ListTileStyle.list,
              trailing: _popUpMenuButton(item),
            );
          },
        ),
      ],
    );
  }

  PopupMenuButton<dynamic> _popUpMenuButton(Anggota anggota) {
    return PopupMenuButton(
      onSelected: (item) {
        switch (item) {
          case 'edit':
            Get.to(
                () =>
                    UpdateAnggota(updateAnggotaCallback: updateAnggotaCallback),
                arguments: {'anggota': anggota});
            break;
          case 'delete':
            deleteAnggotaCallback(anggota);
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      position: PopupMenuPosition.under,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(2),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}