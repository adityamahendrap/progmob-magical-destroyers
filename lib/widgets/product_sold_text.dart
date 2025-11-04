import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class ProductSoldText extends StatelessWidget {
  const ProductSoldText({
    super.key,
    required this.sold,
  });

  final int sold;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorPlanet.secondary,
      ),
      child: Text('${this.sold} sold'),
    );
  }
}
