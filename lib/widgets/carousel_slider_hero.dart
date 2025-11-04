import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class CarouselSliderHero extends StatelessWidget {
  final List items;

  CarouselSliderHero({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 200.0,
        showIndicator: true,
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: ColorPlanet.primary,
          padding: EdgeInsets.only(bottom: 10),
          indicatorBackgroundColor: Colors.grey.shade300,
        ),
        floatingIndicator: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        reverse: false,
        padEnds: true,
      ),
      items: items.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: ColorPlanet.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Image $i',
                  style: TextStyle(fontSize: 16.0, color: ColorPlanet.primary),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
