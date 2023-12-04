import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final Function()? onPressed;

  const SignInWithGoogleButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: 50.0,
        width: 400.0,
        decoration: const BoxDecoration(
          color: Color(0xffF2F2F2),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Ink.image(
              image: const AssetImage("images/web_neutral_sq_ctn@4x.png")),
        ),
      ),
    );
  }
}
