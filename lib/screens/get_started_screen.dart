import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lelang_app/screens/sign_in_screen.dart';
import 'package:lelang_app/screens/sign_up_screen.dart';
import 'package:lelang_app/widgets/full_width_button.dart';
import 'package:lelang_app/widgets/oauth_button.dart';
import 'package:lelang_app/widgets/text_title.dart';
import 'package:lelang_app/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class GetStarted extends StatelessWidget {
  GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Image(
                      image: AssetImage("assets/logo.png"),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextTitle(title: "Let's Get Started"),
                  SizedBox(height: 10),
                  Text("Let's dive into your account"),
                  SizedBox(height: 50),
                  OauthButton(
                    iconPath: "assets/google_icon.png",
                    text: "Continue with Google",
                  ),
                  SizedBox(height: 15),
                  OauthButton(
                    iconPath: "assets/facebook_icon.png",
                    text: "Continue with Facebook",
                  ),
                  SizedBox(height: 15),
                  OauthButton(
                    iconPath: "assets/github_icon.png",
                    text: "Continue with GitHub",
                  ),
                  SizedBox(height: 50),
                  FullWidthButton(
                    type: FullWidthButtonType.primary,
                    text: "Sign Up",
                    onPressed: () => Get.to(
                      () => SignUp(),
                    ),
                  ),
                  SizedBox(height: 15),
                  FullWidthButton(
                    type: FullWidthButtonType.secondary,
                    text: "Sign In",
                    onPressed: () => Get.to(
                      () => SignIn(),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
              Positioned(child: _termsAndPolicy(context), bottom: 20)
            ],
          ),
        ),
      ),
    );
  }

  Row _termsAndPolicy(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => bottomSheetFitContentWrapper(
            context: context,
            content: _pricaxyPolicyContent(),
          ),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
          ),
          child: Text("Privacy Policy", style: TextStyle(color: Colors.grey)),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () => bottomSheetFitContentWrapper(
            context: context,
            content: _termOfServiceContent(),
          ),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
          ),
          child: Text("Term of Service", style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _termOfServiceContent() {
    return Column(
      children: [
        TextTitle(title: 'Term of Service'),
        SizedBox(height: 15),
        Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        ),
      ],
    );
  }

  Widget _pricaxyPolicyContent() {
    return Column(
      children: [
        TextTitle(title: 'Privacy Policy'),
        SizedBox(height: 15),
        Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        ),
      ],
    );
  }
}
