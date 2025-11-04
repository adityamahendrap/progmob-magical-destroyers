import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:lelang_app/widgets/full_width_button.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool _rememberMe = true;
  bool _faceId = true;
  bool _touchId = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(
        title: 'Security',
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _tile(
              title: 'Remember me',
              value: _rememberMe,
              onChanged: (bool value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
            _tile(
              title: 'Face ID',
              value: _faceId,
              onChanged: (bool value) {
                setState(() {
                  _faceId = value;
                });
              },
            ),
            _tile(
              title: 'Touch ID',
              value: _touchId,
              onChanged: (bool value) {
                setState(() {
                  _touchId = value;
                });
              },
            ),
            SizedBox(height: 20),
            FullWidthButton(
              type: FullWidthButtonType.primary,
              text: 'Change Password',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _tile({
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
