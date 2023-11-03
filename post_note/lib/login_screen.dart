import 'package:flutter/material.dart';
import 'package:post_note/Palette.dart';
import 'package:post_note/social_button.dart';
import 'login_field.dart';
import 'gradient_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Image(
              image: AssetImage('assets/images/Post-Note-Logo.png'),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            Text(
              'Sign in.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Palette.outerSpace,
                fontSize: 90,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'A central hub to upload, view, and share your notes!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Palette.outerSpace,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 50),
            SocialButton(
                iconPath: 'assets/svgs/g_logo.svg',
                label: 'Continue with Google'),
            SizedBox(height: 15),
            Text(
              'or',
              style: TextStyle(
                fontSize: 15,
                color: Palette.outerSpace,
              ),
            ),
            SizedBox(height: 15),
            LoginField(hintText: 'Email'),
            SizedBox(height: 15),
            LoginField(hintText: 'Password'),
            SizedBox(height: 20),
            GradientButton(),
            SizedBox(height: 100)
          ]),
        ),
      ),
    );
  }
}
