import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:lelang_app/widgets/app_snack_bar.dart';
import 'package:lelang_app/widgets/full_width_button_bottom_bar.dart';
import 'package:lelang_app/widgets/input/text_input.dart';
import 'package:lelang_app/widgets/text_title.dart';

class SendForgotPasswordEmail extends StatelessWidget {
  SendForgotPasswordEmail({Key? key}) : super(key: key);

  final _emailController = TextEditingController();

  bool _validateInput() {
    return _checkEmail(_emailController.text) == null;
  }

  void _sendEmail() {
    if (!_validateInput()) {
      AppSnackBar.error("Failed", "Please fill the field correctly");
    }

    AppSnackBar.success("Success", "Email sent");
    _emailController.text = '';
  }

  String? _checkEmail(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWithBackButton(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle(title: "Forgot Your Password? 🔑"),
                SizedBox(height: 10),
                Text(
                    "No worries! Enter your registered email below to reset your password."),
                SizedBox(height: 25),
                TextInput(
                  title: 'Your Registered Email',
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: _checkEmail,
                ),
              ],
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: "Send Email",
            onPressed: () => _sendEmail(),
          ),
        ],
      ),
    );
  }
}
