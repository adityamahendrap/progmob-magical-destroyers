import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/screens/account/address/add_new_address_screen.dart';
import 'package:lelang_app/screens/main/home_screen.dart';
import 'package:lelang_app/widgets/address_card.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:lelang_app/widgets/full_width_button_bottom_bar.dart';
import 'package:lelang_app/widgets/text_label.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: 'Address',
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return AddressCard(index: index, onTap: () {});
              },
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: 'Add New Adress',
            onPressed: () {
              Get.to(() => AddNewAddress());
            },
          )
        ],
      ),
    );
  }
}
