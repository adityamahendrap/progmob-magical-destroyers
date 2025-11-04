import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/screens/main/detail_product_screen.dart';
import 'package:lelang_app/screens/main/home_screen.dart';
import 'package:lelang_app/widgets/product_sold_text.dart';

class ProductCard extends StatelessWidget {
  final Product item;
  final Function? onCardPressed;

  ProductCard({
    super.key,
    required this.item,
    required this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPressed == null
          ? () => Get.to(() => DetailProduct())
          : () => onCardPressed!,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorPlanet.secondary,
                  ),
                  child: Center(
                    child: Text(
                      'Image ${this.item.id}',
                      style: TextStyle(
                        color: ColorPlanet.primary,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: EdgeInsets.all(7),
                    child: Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.white,
                      size: 15,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPlanet.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              this.item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: ColorPlanet.primary,
                ),
                SizedBox(width: 5),
                Text('${this.item.rating} | '),
                SizedBox(width: 5),
                ProductSoldText(sold: item.sold)
              ],
            ),
            Text(
              '\$${this.item.price}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
