import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class GradientButton extends StatelessWidget {
  final String textParameter;
  final Function()? onPressed;

  const GradientButton(
      {super.key, required this.textParameter, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: 70.0,
        width: 384.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.fernGreen, Palette.mint],
          ),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            textParameter,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
