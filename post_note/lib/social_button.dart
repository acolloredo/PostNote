import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Palette.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final double horizontalPadding;
  const SocialButton({
    Key? key,
    required this.iconPath,
    required this.label,
    this.horizontalPadding = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(
        iconPath,
        width: 25,
        // Color? : Palette.outerSpace,
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Palette.outerSpace,
          fontSize: 25,
        ),
      ),
      style: TextButton.styleFrom(
        padding:
            EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Palette.outerSpace,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
