import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/screens/main/home_screen.dart';
import 'package:lelang_app/screens/main/main_screen.dart';
import 'package:lelang_app/screens/sign_in_screen.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:lelang_app/widgets/app_snack_bar.dart';
import 'package:lelang_app/widgets/full_width_button_bottom_bar.dart';
import 'package:lelang_app/widgets/horizontal_divider.dart';
import 'package:lelang_app/widgets/icon_button_circ;e.dart';
import 'package:lelang_app/widgets/input/password_input.dart';
import 'package:lelang_app/widgets/input/text_input.dart';
import 'package:lelang_app/widgets/oauth_button.dart';
import 'package:lelang_app/widgets/text_title.dart';
import 'package:lelang_app/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isAgree = false;

  bool _validateInput() {
    return _checkEmail(_emailController.text) == null &&
        _checkPassword(_passwordController.text) == null &&
        _checkConfirmPassword(_confirmPasswordController.text) == null &&
        _isAgree;
  }

  void _signUp() async {
    if (!_validateInput()) {
      AppSnackBar.error("Failed",
          "Please fill the form correctly and agree terms & conditions");
      return;
    }

    Get.offAll(() => Main());
  }

  void _toggleAgree() {
    setState(() {
      _isAgree = !_isAgree;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    });
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

  String? _checkConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (value != _passwordController.text) {
      return 'Password does not match';
    }
    return null;
  }

  String? _checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'This field must be filled';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
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
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle(title: "Join APP_NAME Today!✨"),
                SizedBox(height: 10),
                Text(
                    "Create an account to lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                SizedBox(height: 25),
                Form(
                  key: _signUpFormKey,
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
                        isObscure: _isPasswordHidden,
                        toggleObscure: _togglePasswordVisibility,
                        controller: _passwordController,
                        validator: _checkPassword,
                      ),
                      SizedBox(height: 20),
                      PasswordInput(
                        title: 'Confirm Password',
                        hintText: 'Confirm Password',
                        isObscure: _isConfirmPasswordHidden,
                        toggleObscure: _toggleConfirmPasswordVisibility,
                        controller: _confirmPasswordController,
                        validator: _checkConfirmPassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _agreement(context),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () => Get.off(() => SignIn()),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: ColorPlanet.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
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
            text: "Sign Up",
            onPressed: () {
              _signUp();
            },
          ),
        ],
      ),
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

  Row _agreement(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _isAgree,
            onChanged: (value) => _toggleAgree(),
            activeColor: ColorPlanet.primary,
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => _toggleAgree(),
          child: Text("I agree to APP_NAME "),
        ),
        TextButton(
          onPressed: () => bottomSheetFitContentWrapper(
            context: context,
            content: _termsAndConditionsContent(),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          child: Text(
            "Terms & Conditions.",
            style: TextStyle(
              color: ColorPlanet.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  TextFormField _confirmPasswordInput() {
    return TextFormField(
      controller: _confirmPasswordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _checkConfirmPassword(value),
      textAlignVertical: TextAlignVertical.center,
      obscureText: _isConfirmPasswordHidden,
      cursorErrorColor: ColorPlanet.primary,
      cursorColor: ColorPlanet.primary,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.black,
        ),
        hintText: "Confirm Password",
        hintStyle: TextStyle(color: Color(0xff9E9E9E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Color.fromARGB(101, 241, 241, 241),
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordHidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black,
          ),
          onPressed: () => _toggleConfirmPasswordVisibility(),
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextFormField _passwordInput() {
    return TextFormField(
      controller: _passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _checkPassword(value),
      textAlignVertical: TextAlignVertical.center,
      obscureText: _isPasswordHidden,
      cursorColor: ColorPlanet.primary,
      cursorErrorColor: ColorPlanet.primary,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.black,
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Color(0xff9E9E9E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Color.fromARGB(101, 241, 241, 241),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black,
          ),
          onPressed: () => _togglePasswordVisibility(),
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextFormField _emailInput() {
    return TextFormField(
      controller: _emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _checkEmail(value),
      textAlignVertical: TextAlignVertical.center,
      obscureText: false,
      cursorColor: ColorPlanet.primary,
      cursorErrorColor: ColorPlanet.primary,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Colors.black,
        ),
        hintText: 'Email',
        hintStyle: TextStyle(color: Color(0xff9E9E9E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Color.fromARGB(101, 241, 241, 241),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  Widget _termsAndConditionsContent() {
    return Column(
      children: [
        TextTitle(title: 'Terms & Conditions'),
        SizedBox(height: 15),
        Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        ),
      ],
    );
  }
}
