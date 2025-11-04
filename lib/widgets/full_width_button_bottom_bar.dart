import 'package:flutter/material.dart';
import 'package:lelang_app/widgets/full_width_button.dart';

class FullWidthButtonBottomBar extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const FullWidthButtonBottomBar(
      {super.key,
      required this.context,
      required this.text,
      required this.onPressed});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Divider(
              height: 0,
              thickness: 0.5,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: FullWidthButton(
                type: FullWidthButtonType.primary,
                text: this.text,
                onPressed: this.onPressed,
              ),
            ),
          ],
        ),
      ),
      bottom: 0,
    );
  }
}
