import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/user_type.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/get_anggota_list_type.dart';
import 'package:progmob_magical_destroyers/providers/profile_provider.dart';
import 'package:progmob_magical_destroyers/screens/main/search_screen.dart';
import 'package:progmob_magical_destroyers/screens/savings_loan/add_anggota_screen.dart';
import 'package:progmob_magical_destroyers/screens/savings_loan/update_anggota_screen.dart';
import 'package:progmob_magical_destroyers/types/category_item_type.dart';
import 'package:progmob_magical_destroyers/types/product_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:progmob_magical_destroyers/widgets/product_card.dart';
import 'package:progmob_magical_destroyers/widgets/carousel_slider_hero.dart';
import 'package:progmob_magical_destroyers/widgets/profile_picture.dart';
import 'package:progmob_magical_destroyers/widgets/text_label.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GetStorage _box = GetStorage();
  final MoblieApiRequester _apiRequester = MoblieApiRequester();

  late User _user;
  late Future<GetAnggotaListData?> _anggotaList;

  Future<void> _getAnggotaList() async {
    try {
      _anggotaList = _apiRequester.getAnggotaList();
      await _anggotaList; // Wait for the Future to complete
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    }
  }

  Future<void> _addAnggota(Anggota anggota) async {
    try {
      await _apiRequester.addAnggota(
        nomorInduk: anggota.nomorInduk,
        nama: anggota.nama,
        tglLahir: anggota.tglLahir,
        telepon: anggota.telepon,
        alamat: anggota.alamat,
      );
      await _getAnggotaList();
      setState(() {}); // Rebuild the widget tree to reflect the updated list
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<void> _updateAnggota(Anggota anggota) async {
    try {
      await _apiRequester.updateAnggota(
        id: anggota.id,
        nomorInduk: anggota.nomorInduk,
        nama: anggota.nama,
        tglLahir: anggota.tglLahir,
        telepon: anggota.telepon,
        alamat: anggota.alamat,
        status: anggota.statusAktif ?? true,
      );
      await _getAnggotaList();
      setState(() {}); // Rebuild the widget tree to reflect the updated list
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<void> _deleteAnggota(Anggota anggota) async {
    try {
      await _apiRequester.deleteAnggota(id: anggota.id);
      await _getAnggotaList();
      setState(() {}); // Rebuild the widget tree to reflect the updated list
      AppSnackBar.success('Success', 'Anggota deleted successfully!');
    } on DioException catch (e) {
      HelplessUtil.handleApiError(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _user = User.fromJson(_box.read('user'));
    _getAnggotaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
          () => AddAnggota(addAnggotaCallback: _addAnggota),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: ColorPlanet.primary,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(bottom: 10),
              sliver: SliverToBoxAdapter(
                child: _header(),
              ),
            ),
            SliverAppBar(
              title: _searchInput(),
              floating: true,
              pinned: true,
              titleSpacing: 0,
              toolbarHeight: 80,
              surfaceTintColor: Colors.white,
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 15, top: 5),
              sliver: SliverToBoxAdapter(
                child: _specialOffers(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 20),
              sliver: SliverToBoxAdapter(
                child: _categories(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 30),
              sliver: SliverToBoxAdapter(
                child: _anggotaListView(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 20),
              sliver: SliverToBoxAdapter(
                child: _mostPopular(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 50),
              sliver: SliverToBoxAdapter(child: Container()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  print('Profile picture pressed');
                  Get.to(() => ShowPhotoView(
                      image: context.watch<ProfileProvider>().imageProvider));
                },
                child: CircleAvatar(
                  backgroundImage:
                      context.watch<ProfileProvider>().imageProvider,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good ${getTimeOfDay()}, 👋',
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text(
                      _user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _notificationButton(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark_border_outlined),
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _anggotaListView() {
    return Column(
      children: [
        _anggotaListViewHeader(),
        FutureBuilder(
          future: _anggotaList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Anggota> items = snapshot.data!.anggotaList;

              if (items.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(image: AssetImage('assets/empty.png'))),
                      SizedBox(height: 10),
                      Text(
                        'Nothing to see here :(',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
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
                        Get.to(() =>
                            ShowPhotoView(image: AssetImage(defaultImagePath)));
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
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
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
                    trailing: _morePopUpAnggota(item),
                  );
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }

            return Container(
              padding: EdgeInsets.only(top: 10),
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

  Padding _anggotaListViewHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Pejuang Progmob',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorPlanet.secondary,
                ),
                padding: EdgeInsets.all(5),
                child: FutureBuilder(
                  future: _anggotaList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data!.anggotaList.length}',
                        style:
                            TextStyle(fontSize: 16, color: ColorPlanet.primary),
                      );
                    } else {
                      return Text(
                        '...',
                        style:
                            TextStyle(fontSize: 16, color: ColorPlanet.primary),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          _seeAllButton()
        ],
      ),
    );
  }

  PopupMenuButton<dynamic> _morePopUpAnggota(Anggota anggota) {
    return PopupMenuButton(
      onSelected: (item) {
        switch (item) {
          case 'edit':
            Get.to(() => UpdateAnggota(updateAnggotaCallback: _updateAnggota),
                arguments: {'anggota': anggota});
            break;
          case 'delete':
            _deleteAnggota(anggota);
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

  String getTimeOfDay() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    } else if (hour < 17) {
      return 'afternoon';
    } else if (hour < 20) {
      return 'evening';
    } else {
      return 'night';
    }
  }

  Stack _notificationButton() {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none_outlined),
          color: Colors.black,
        ),
        Positioned(
          top: 11,
          right: 13,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.black),
            cursorColor: ColorPlanet.primary,
            readOnly: true,
            onTap: () {
              Get.to(() => Search(), transition: Transition.cupertinoDialog);
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'Search products skibidi ...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              fillColor: Colors.grey.shade100,
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              suffixIcon: Icon(
                CupertinoIcons.slider_horizontal_3,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _specialOffers() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Special Offers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _seeAllButton()
            ],
          ),
        ),
        CarouselSliderHero(items: [1, 2, 3, 4, 5]),
      ],
    );
  }

  Widget _categories() {
    final List<CategoryItem> categoryItems = [
      CategoryItem(name: 'Lorem', icon: Icons.food_bank),
      CategoryItem(name: 'Ipsum', icon: Icons.forest),
      CategoryItem(name: 'Dolor', icon: Icons.ac_unit_sharp),
      CategoryItem(name: 'Sit', icon: Icons.airplanemode_active),
      CategoryItem(name: 'Amet', icon: Icons.airport_shuttle),
      CategoryItem(name: 'Sos', icon: Icons.account_tree),
      CategoryItem(name: 'Dapibus', icon: Icons.add_business),
      CategoryItem(name: 'Consectetur', icon: Icons.add_location),
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoryItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 30,
                mainAxisSpacing: 40,
              ),
              itemBuilder: (context, index) {
                final item = categoryItems[index];
                return Center(
                  child: Wrap(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPlanet.secondary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child:
                                  Icon(item.icon, color: ColorPlanet.primary),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _mostPopular() {
    final items = ['Lorem', 'Ipsum', 'Dolor', 'Sit', 'Amet'];
    final activeIndex = 0;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Most Popular',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _seeAllButton()
            ],
          ),
        ),
        _mostPopularButtons(items, activeIndex),
        SizedBox(height: 20),
        _mostPopularCards(),
      ],
    );
  }

  Widget _mostPopularCards() {
    final List<Product> products = [
      Product(
        id: '1',
        name: 'Lorem',
        price: 100,
        rating: 4.5,
        sold: 100,
      ),
      Product(
        id: '2',
        name: 'Ipsum',
        price: 200,
        rating: 4.5,
        sold: 100,
      ),
    ];

    List<ProductCard> cardItems = products
        .map((e) => ProductCard(
              item: e,
              onCardPressed: null,
            ))
        .toList();
    List<TrackSize> rowSizes =
        List.generate((products.length / 2).ceil(), (index) => auto);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: LayoutGrid(
          columnGap: 20,
          rowGap: 20,
          columnSizes: [1.fr, 1.fr],
          rowSizes: rowSizes,
          children: cardItems,
        ),
      ),
    );
  }

  Container _mostPopularButtons(List<String> items, int activeIndex) {
    return Container(
      height: 35,
      child: ListView.separated(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  activeIndex == index ? ColorPlanet.primary : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: ColorPlanet.primary, width: 2),
              ),
            ),
            onPressed: () {},
            child: Text(
              item,
              style: TextStyle(
                color:
                    activeIndex == index ? Colors.white : ColorPlanet.primary,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }

  TextButton _seeAllButton() {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.zero,
        ),
      ),
      child: Text(
        'See all',
        style: TextStyle(
          color: ColorPlanet.primary,
          fontSize: 18,
        ),
      ),
    );
  }
}
