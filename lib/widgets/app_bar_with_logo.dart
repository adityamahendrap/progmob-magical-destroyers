import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class AppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  AppBarWithLogo({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Container(
          height: 24,
          width: 24,
          child: Image.asset("assets/logo.png", color: ColorPlanet.primary),
        ),
        onPressed: null,
      ),
      centerTitle: true,
      title: Text(
        this.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
