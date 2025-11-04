import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String title;
  final String hintText;
  final bool isObscure;
  final Function toggleObscure;

  PasswordInput({
    super.key,
    this.controller,
    this.validator,
    required this.title,
    required this.hintText,
    required this.isObscure,
    required this.toggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: this.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) =>
              this.validator == null ? null : this.validator!(value),
          textAlignVertical: TextAlignVertical.center,
          obscureText: this.isObscure,
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
                this.isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.black,
              ),
              onPressed: () => this.toggleObscure(),
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        )
      ],
    );
  }
}
