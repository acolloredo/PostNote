import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      preferBelow: true,
      verticalOffset: 110.0,
      waitDuration: Duration(seconds: 1),
      message: "share, manage, and view notes!",
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage('images/Post-Note-Logo.png'),
          width: 225,
          height: 225,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
