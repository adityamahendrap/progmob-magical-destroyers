import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class QuantityCounter extends StatelessWidget {
  final int qty;
  final Function onPlusButtonPressed;
  final Function onMinusButtonPressed;

  QuantityCounter({
    super.key,
    required this.qty,
    required this.onPlusButtonPressed,
    required this.onMinusButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // fit width with child
      decoration: BoxDecoration(
        color: ColorPlanet.secondary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: this.onMinusButtonPressed(),
            color: ColorPlanet.primary,
          ),
          Text(
            ' ${this.qty} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: this.onPlusButtonPressed(),
            color: ColorPlanet.primary,
          ),
        ],
      ),
    );
  }
}
