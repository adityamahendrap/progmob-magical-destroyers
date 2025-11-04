import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/screens/account/address/address_screen.dart';
import 'package:lelang_app/screens/account/edit_profile.dart';
import 'package:lelang_app/screens/account/language_screen.dart';
import 'package:lelang_app/screens/account/notification_screen.dart';
import 'package:lelang_app/screens/account/security_screen.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:lelang_app/widgets/app_bar_with_logo.dart';
import 'package:lelang_app/widgets/profile_picture.dart';
import 'package:lelang_app/widgets/text_title.dart';

class AccountItem {
  final String text;
  final IconData icon;
  final Widget? screen;

  AccountItem({required this.text, required this.icon, required this.screen});
}

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isLightMode = true;

  List<AccountItem> _accountItems = [
    AccountItem(
      text: 'Edit Profile',
      icon: Icons.person_outline,
      screen: EditProfile(),
    ),
    AccountItem(
      text: 'Address',
      icon: Icons.location_on_outlined,
      screen: Address(),
    ),
    AccountItem(
      text: 'Notification',
      icon: Icons.notifications_none_outlined,
      screen: Notification_(),
    ),
    AccountItem(
      text: 'Security',
      icon: Icons.security_outlined,
      screen: Security(),
    ),
    AccountItem(
      text: 'Logout',
      icon: Icons.logout,
      screen: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _accountItemTiles =
        _accountItems.map((e) => _mainListTile(e)).toList();
    Widget _languageItemTile = _languageListTile();
    Widget _lightModeItemTile = _lightModeListTile();

    _accountItemTiles.insert(_accountItems.length - 1, _lightModeItemTile);
    _accountItemTiles.insert(_accountItems.length - 1, _languageItemTile);

    return Scaffold(
      appBar: AppBarWithLogo(title: 'Account'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Center(child: ProfilePicture()),
            SizedBox(height: 20),
            TextTitle(title: 'Aditya Mahendra'),
            SizedBox(height: 5),
            Text('+62 812 3456 7890'),
            SizedBox(height: 20),
            Divider(color: Colors.grey.shade300),
            ..._accountItemTiles,
          ]),
        ),
      ),
    );
  }

  Widget _mainListTile(AccountItem item) {
    final trailing =
        item.text == 'Logout' ? null : CupertinoIcons.chevron_right;
    final color = item.text == 'Logout' ? Colors.red : Colors.black;

    return ListTile(
      leading: Icon(item.icon, color: color),
      title: Text(
        item.text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: color,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      trailing: Icon(trailing),
      visualDensity: VisualDensity(vertical: -2),
      onTap: () {
        if (item.screen != null) {
          Get.to(() => item.screen as Widget);
        }
      },
    );
  }

  Widget _languageListTile() {
    return ListTile(
      leading: Icon(Icons.language_outlined),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Language',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            'English (US)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
      trailing: Icon(CupertinoIcons.chevron_right),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -2),
      onTap: () => Get.to(() => Language()),
    );
  }

  Widget _lightModeListTile() {
    return ListTile(
      leading: Icon(Icons.light_mode_outlined),
      title: Text(
        'Light Mode',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      trailing: Switch(
        value: isLightMode,
        activeColor: ColorPlanet.primary,
        onChanged: (bool value) {
          setState(() {
            isLightMode = value;
            print(isLightMode ? 'Light Mode' : 'Dark Mode');
          });
        },
      ),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -2),
      onTap: () => setState(() {
        isLightMode = !isLightMode;
      }),
    );
  }
}
