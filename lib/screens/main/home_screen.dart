import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:lelang_app/controller/profile_controller.dart';
import 'package:lelang_app/screens/main/detail_product_screen.dart';
import 'package:lelang_app/screens/main/main_screen.dart';
import 'package:lelang_app/screens/main/search_screen.dart';
import 'package:lelang_app/widgets/product_card.dart';
import 'package:lelang_app/widgets/carousel_slider_hero.dart';
import 'package:lelang_app/widgets/profile_picture.dart';

class CategoryItem {
  final String name;
  final IconData icon;

  CategoryItem({required this.name, required this.icon});
}

class Product {
  final String id;
  final String name;
  final double price;
  final double rating;
  final int sold;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.sold,
  });
}

class Home extends StatelessWidget {
  Home({super.key});

  final _profileC = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.only(top: 40),
              sliver: SliverToBoxAdapter(
                child: _mostPopular(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 50),
              sliver: SliverToBoxAdapter(child: Container()), // Spacer
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
              Obx(
                () => CircleAvatar(
                  backgroundImage: _profileC.image.value != null
                      ? FileImage(File(_profileC.image.value!.path))
                      : AssetImage(defaultImagePath) as ImageProvider,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good morning, 👋',
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text(
                      'Aditya Mahendra',
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
      CategoryItem(name: 'Food', icon: Icons.food_bank),
      CategoryItem(name: 'Drink', icon: Icons.local_drink),
      CategoryItem(name: 'Cake', icon: Icons.cake),
      CategoryItem(name: 'Cafe', icon: Icons.local_cafe),
      CategoryItem(name: 'Fastfood', icon: Icons.fastfood),
      CategoryItem(name: 'Food', icon: Icons.food_bank),
      CategoryItem(name: 'Drink', icon: Icons.local_drink),
      CategoryItem(name: 'Cake', icon: Icons.cake),
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
