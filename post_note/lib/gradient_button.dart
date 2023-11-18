import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class GradientButton extends StatelessWidget {
  final String textParameter;
  final Function()? onPressed;

  const GradientButton({super.key, required this.textParameter, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: 50.0,
        width: 400.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.fernGreen, Palette.mint],
          ),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            textParameter,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
