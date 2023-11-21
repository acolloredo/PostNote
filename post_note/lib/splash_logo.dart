import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: true,
      verticalOffset: 110.0,
      waitDuration: const Duration(seconds: 1),
      message: "share, manage, and view notes!",
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'svgs/Post-Note-Logo-Filled.svg',
          width: 225,
          height: 225,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
