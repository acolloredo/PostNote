import 'package:flutter/material.dart';
import 'package:post_note/Palette.dart';
import 'package:post_note/social_button.dart';
import 'login_field.dart';
import 'gradient_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Image(
              image: AssetImage('images/Post-Note-Logo.png'),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              'Sign in.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Palette.outerSpace,
                fontSize: 80,
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
                iconPath: 'svgs/g_logo.svg', label: 'Continue with Google'),
            SizedBox(height: 15),
            Text(
              'or',
              style: TextStyle(
                fontSize: 20,
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
