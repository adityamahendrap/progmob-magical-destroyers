import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class CarouselSliderProduct extends StatelessWidget {
  final List items;

  CarouselSliderProduct({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width,
        showIndicator: true,
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: ColorPlanet.primary,
          padding: EdgeInsets.only(bottom: 10),
          indicatorBackgroundColor: Colors.grey.shade300,
        ),
        viewportFraction: 1.0,
        floatingIndicator: true,
      ),
      items: this.items.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              color: ColorPlanet.secondary,
              child: Container(),
            );
          },
        );
      }).toList(),
    );
  }
}
