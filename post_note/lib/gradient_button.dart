import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class GradientButton extends StatelessWidget {
  final String textParameter;
  final Function()? onPressedFunction;

  const GradientButton(
      {super.key, required this.textParameter, this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Palette.celadon,
            Palette.outerSpace,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onPressedFunction,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          textParameter,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
