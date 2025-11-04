import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';

class Notification_ extends StatefulWidget {
  Notification_({super.key});

  @override
  State<Notification_> createState() => _Notification_State();
}

class _Notification_State extends State<Notification_> {
  bool _generalNotification = true;
  bool _sound = true;
  bool _vibration = true;
  bool _specialOffers = true;
  bool _promoAndDscount = false;
  bool _payment = true;
  bool _cashback = false;
  bool _appUpdates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(title: 'Notification', centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _notificationTile(
                title: 'General Notification',
                value: _generalNotification,
                onChanged: (value) {
                  setState(() {
                    _generalNotification = value;
                  });
                },
              ),
              _notificationTile(
                title: 'Sound',
                value: _sound,
                onChanged: (value) {
                  setState(() {
                    _sound = value;
                  });
                },
              ),
              _notificationTile(
                title: 'Vibration',
                value: _vibration,
                onChanged: (value) {
                  setState(() {
                    _vibration = value;
                  });
                },
              ),
              _notificationTile(
                title: 'Special Offers',
                value: _specialOffers,
                onChanged: (value) {
                  setState(() {
                    _specialOffers = value;
                  });
                },
              ),
              _notificationTile(
                title: 'Promo and Discount',
                value: _promoAndDscount,
                onChanged: (value) {
                  setState(() {
                    _promoAndDscount = value;
                  });
                },
              ),
              _notificationTile(
                title: 'Payment',
                value: _payment,
                onChanged: (value) {
                  setState(() {
                    _payment = value;
                  });
                },
              ),
              _notificationTile(
                title: 'Cashback',
                value: _cashback,
                onChanged: (value) {
                  setState(() {
                    _cashback = value;
                  });
                },
              ),
              _notificationTile(
                title: 'App Updates',
                value: _appUpdates,
                onChanged: (value) {
                  setState(() {
                    _appUpdates = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      contentPadding: EdgeInsets.zero,
      trailing: Switch(
        value: value,
        activeColor: ColorPlanet.primary,
        onChanged: (bool newValue) {
          onChanged(newValue);
        },
      ),
    );
  }
}
