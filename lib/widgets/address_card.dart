import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/text_label.dart';

class AddressCard extends StatelessWidget {
  final index;
  final Function onTap;

  AddressCard({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorPlanet.primary.withOpacity(0.2),
            offset: Offset(0, 6),
            blurRadius: 21,
            spreadRadius: -3,
          )
        ],
      ),
      child: ListTile(
        onTap: onTap(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _locationIcon(),
        title: Row(
          children: [
            Text(
              'Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            index == 0 ? TextLabel(text: 'Default') : Container()
          ],
        ),
        subtitle: Text('Full address here'),
        trailing: Icon(Icons.edit_outlined),
      ),
    );
  }

  Container _locationIcon() {
    return Container(
      decoration: BoxDecoration(
        color: ColorPlanet.secondary,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPlanet.primary,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(7),
        child: Icon(
          Icons.location_on_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
