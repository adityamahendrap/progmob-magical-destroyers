import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class TextLabel extends StatelessWidget {
  final String text;

  TextLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ColorPlanet.secondary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(this.text),
    );
  }
}
