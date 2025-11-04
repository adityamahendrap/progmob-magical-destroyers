import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/screens/main/main_screen.dart';
import 'package:lelang_app/widgets/app_bar_with_logo.dart';
import 'package:lelang_app/widgets/quantity_counter.dart';
import 'package:lelang_app/widgets/text_title.dart';
import 'package:lelang_app/widgets/twin_buttons.dart';
import 'package:lelang_app/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

final bgColor = Color(0xFDFDFD);

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          Container(
            color: bgColor,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 20),
                CartItem(),
                SizedBox(height: 20),
                CartItem(),
                SizedBox(height: 20),
                CartItem(),
                SizedBox(height: 20),
                CartItem(),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(bottom: 0, child: _checkoutButton(context)),
        ],
      ),
    );
  }

  Widget _checkoutButton(BuildContext context) {
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
                '\$9998',
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
                    'Checkout',
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

  AppBar _appBar() {
    return AppBar(
      surfaceTintColor: bgColor,
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
        'Cart',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {},
          color: Colors.black,
        ),
        SizedBox(width: 5)
      ],
    );
  }
}

class CartItem extends StatelessWidget {
  bool? forDeleteConfirmation;

  CartItem({
    super.key,
    this.forDeleteConfirmation = false,
  });

  void _onDeleteButtonPressed(BuildContext context) {
    bottomSheetFitContentWrapper(
        context: context, content: _removeConfirmation());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.forDeleteConfirmation!
          ? null
          : EdgeInsets.symmetric(horizontal: 20),
      padding: this.forDeleteConfirmation! ? null : EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: this.forDeleteConfirmation!
            ? null
            : [
                BoxShadow(
                  color: ColorPlanet.primary.withOpacity(0.2),
                  offset: Offset(0, 6),
                  blurRadius: 21,
                  spreadRadius: -3,
                )
              ],
      ),
      // color: Colors.red,
      child: Row(
        children: [
          _itemImage(),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              // color: Colors.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        this.forDeleteConfirmation!
                            ? Container()
                            : Container(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  icon: Icon(CupertinoIcons.delete),
                                  onPressed: () =>
                                      _onDeleteButtonPressed(context),
                                  color: Colors.black,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _colorCircle(),
                      SizedBox(width: 10),
                      Text('Blue | Size 44',
                          maxLines: 1, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$999',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      QuantityCounter(
                        qty: 1,
                        onMinusButtonPressed: () {},
                        onPlusButtonPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _removeConfirmation() {
    return Column(
      children: [
        Text(
          'Remove From Cart?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Divider(color: Colors.grey.shade300),
        SizedBox(height: 20),
        CartItem(forDeleteConfirmation: true),
        SizedBox(height: 20),
        Divider(color: Colors.grey.shade300),
        SizedBox(height: 20),
        TwinButtons(
          textOkButton: 'Yes, Remove',
          textCancelButton: 'Cancel',
          onPressedOkButton: () {},
          onPressedCancelButton: () => Get.back(),
        )
      ],
    );
  }

  Container _colorCircle() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: ColorPlanet.primary,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Container _itemImage() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: ColorPlanet.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          'Image 1',
          style: TextStyle(
            color: ColorPlanet.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
