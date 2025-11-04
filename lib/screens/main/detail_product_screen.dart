import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/carousel_slider_product.dart';
import 'package:lelang_app/widgets/product_card.dart';
import 'package:lelang_app/widgets/product_sold_text.dart';
import 'package:lelang_app/widgets/quantity_counter.dart';
import 'package:lelang_app/widgets/text_title.dart';
import 'package:readmore/readmore.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CarouselSliderProduct(items: [1, 1, 1]),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextTitle(title: 'Product Name'),
                              Icon(Icons.bookmark_border)
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProductSoldText(sold: 5),
                              SizedBox(width: 10),
                              Icon(
                                Icons.star_half_outlined,
                                color: ColorPlanet.primary,
                              ),
                              Text('4.5 (655 reviews)'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(color: Colors.grey.shade300),
                          SizedBox(height: 10),
                          _productDescription(),
                          SizedBox(height: 20),
                          _productVariants(),
                          SizedBox(height: 20),
                          _quantity(),
                          SizedBox(height: 110),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: _addToCartButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantity() {
    return Row(
      children: [
        Text(
          'Quantity',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(width: 20),
        QuantityCounter(
          qty: 1,
          onMinusButtonPressed: () {},
          onPlusButtonPressed: () {},
        ),
      ],
    );
  }

  Widget _productDescription() {
    final desc = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 5),
        ReadMoreText(
          desc,
          trimMode: TrimMode.Line,
          trimLines: 2,
          colorClickableText: Colors.pink,
          trimCollapsedText: ' Show more',
          trimExpandedText: ' Show less',
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorPlanet.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorPlanet.primary,
          ),
        ),
      ],
    );
  }

  Widget _productVariants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('40', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  ColorPlanet.primary,
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('41'),
            ),
          ],
        )
      ],
    );
  }

  Widget _addToCartButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price'),
              Text(
                '\$99',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(width: 50),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add To Cart',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(CupertinoIcons.shopping_cart, color: Colors.white),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPlanet.primary,
                minimumSize: Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
