import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lelang_app/configs/themes/theme.dart';
import 'package:lelang_app/controller/profile_controller.dart';
import 'package:lelang_app/screens/account/edit_profile.dart';
import 'package:lelang_app/screens/get_started_screen.dart';
import 'package:lelang_app/screens/introduction_screen.dart';
import 'package:lelang_app/screens/main/main_screen.dart';
import 'package:lelang_app/screens/sign_in_screen.dart';
import 'package:lelang_app/widgets/loading.dart';

void main() async {
  EasyLoading.instance
    ..indicatorWidget = Loading()
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
  Get.put(ProfileController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.light,
      home: Main(),
      builder: EasyLoading.init(),
    );
  }
}
