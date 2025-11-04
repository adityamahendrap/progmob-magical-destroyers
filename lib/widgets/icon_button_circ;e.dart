import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class IconButtonCircle extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;

  IconButtonCircle({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: IconButton(
        icon: SizedBox(width: 24, height: 24, child: this.icon),
        onPressed: this.onPressed ?? () {},
        highlightColor: ColorPlanet.secondary,
      ),
    );
  }
}
