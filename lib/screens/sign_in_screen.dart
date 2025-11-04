import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/screens/main/main_screen.dart';
import 'package:lelang_app/screens/send_forgot_password_email_screen.dart';
import 'package:lelang_app/screens/sign_up_screen.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:lelang_app/widgets/app_snack_bar.dart';
import 'package:lelang_app/widgets/full_width_button_bottom_bar.dart';
import 'package:lelang_app/widgets/horizontal_divider.dart';
import 'package:lelang_app/widgets/icon_button_circ;e.dart';
import 'package:lelang_app/widgets/input/password_input.dart';
import 'package:lelang_app/widgets/input/text_input.dart';
import 'package:lelang_app/widgets/text_title.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isRememberMe = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _toggleRememberMe() {
    setState(() {
      _isRememberMe = !_isRememberMe;
    });
  }

  bool _validateInput() {
    return _checkEmail(_emailController.text) == null &&
        _checkPassword(_passwordController.text) == null;
  }

  void _signIn() async {
    if (!_validateInput()) {
      AppSnackBar.error("Failed", "Please fill the form correctly");
      return;
    }

    Get.offAll(() => Main());
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

  String? _checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWithBackButton(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle(title: "Welcome Back 👋"),
                SizedBox(height: 10),
                Text(
                    "Sign in to your account to continue your journey towards lorem ipsum dolor sit amet."),
                SizedBox(height: 25),
                Form(
                  key: _signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        title: 'Email',
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        controller: _emailController,
                        validator: _checkEmail,
                      ),
                      SizedBox(height: 20),
                      PasswordInput(
                        title: 'Password',
                        hintText: 'Password',
                        controller: _passwordController,
                        validator: _checkPassword,
                        isObscure: _isPasswordHidden,
                        toggleObscure: _togglePasswordVisibility,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rememberMe(),
                    _forgotPassword(),
                  ],
                ),
                SizedBox(height: 10),
                _signInButton(),
                SizedBox(height: 10),
                HorizontalDivider(text: "or continue with"),
                SizedBox(height: 25),
                _oauthButtons(),
                SizedBox(height: 100),
              ],
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: "Sign In",
            onPressed: () {
              _signIn();
            },
          )
        ],
      ),
    );
  }

  Row _signInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Doesn't have an account? "),
        TextButton(
          onPressed: () {
            Get.off(() => SignUp());
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: ColorPlanet.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Row _oauthButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonCircle(
          icon: Image.asset('assets/google_icon.png'),
        ),
        SizedBox(width: 20),
        IconButtonCircle(
          icon: Image.asset('assets/facebook_icon.png'),
        ),
        SizedBox(width: 20),
        IconButtonCircle(
          icon: Image.asset('assets/github_icon.png'),
        ),
      ],
    );
  }

  TextButton _forgotPassword() {
    return TextButton(
      onPressed: () => Get.off(() => SendForgotPasswordEmail()),
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorPlanet.primary,
        ),
      ),
    );
  }

  Row _rememberMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _isRememberMe,
            onChanged: (value) => _toggleRememberMe(),
            activeColor: ColorPlanet.primary,
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => _toggleRememberMe(),
          child: Text("Remember me"),
        ),
      ],
    );
  }
}
