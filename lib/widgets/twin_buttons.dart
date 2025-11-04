import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelang_app/widgets/full_width_button.dart';

class TwinButtons extends StatelessWidget {
  final Function onPressedOkButton;
  final Function onPressedCancelButton;
  final String textOkButton;
  final String textCancelButton;

  TwinButtons({
    super.key,
    required this.textOkButton,
    required this.textCancelButton,
    required this.onPressedOkButton,
    required this.onPressedCancelButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FullWidthButton(
            type: FullWidthButtonType.secondary,
            text: this.textCancelButton,
            onPressed: () => this.onPressedCancelButton(),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: FullWidthButton(
            type: FullWidthButtonType.primary,
            text: this.textOkButton,
            onPressed: () => this.onPressedCancelButton(),
          ),
        )
      ],
    );
  }
}
