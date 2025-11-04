import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/text_label.dart';

final bgColor = Color(0xFDFDFD);

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(),
        body: TabBarView(
          children: [
            _activeOrders(),
            _completedOrders(),
          ],
        ),
      ),
    );
  }

  Widget _activeOrders() {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) {
        return Column(
          children: [
            OrderItem(
              textButton: 'Track',
              onButtonPressed: () {},
              status: 'In Delivery',
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _completedOrders() {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) {
        return Column(
          children: [
            OrderItem(
              textButton: 'Buy Again',
              onButtonPressed: () {},
              status: 'Completed',
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Text _tabText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
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
        'Orders',
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
      bottom: TabBar(
        tabs: [
          Tab(child: _tabText('Active')),
          Tab(child: _tabText('Completed')),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String textButton;
  final Function() onButtonPressed;
  final String status;

  OrderItem({
    super.key,
    required this.textButton,
    required this.onButtonPressed,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
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
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _colorCircle(),
                      SizedBox(width: 10),
                      Text('Blue | Size 44 | Qty 2',
                          maxLines: 1, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                  SizedBox(height: 10),
                  TextLabel(text: this.status),
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
                      _itemButton(
                        text: this.textButton,
                        onPressed: onButtonPressed,
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

  Widget _itemButton({required Function() onPressed, required String text}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPlanet.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
