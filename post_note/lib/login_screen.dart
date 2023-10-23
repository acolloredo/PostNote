import 'package:flutter/material.dart';
import 'package:post_note/Pallete.dart';
import 'package:post_note/social_button.dart';
import 'login_field.dart';
import 'gradient_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Image(
              image: AssetImage('assets/images/Post-Note-Logo.png'),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const Text(
              'Sign in.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Pallete.black,
                fontSize: 90,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'A central hub to upload, view, and share your notes!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Pallete.black,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 50),
            const SocialButton(
                iconPath: 'assets/svgs/g_logo.svg',
                label: 'Continue with Google'),
            const SizedBox(height: 15),
            const Text(
              'or',
              style: TextStyle(
                fontSize: 15,
                color: Pallete.black,
              ),
            ),
            const SizedBox(height: 15),
            const LoginField(hintText: 'Email'),
            const SizedBox(height: 15),
            const LoginField(hintText: 'Password'),
            const SizedBox(height: 20),
            const GradientButton(),
            const SizedBox(height: 100)
          ]),
        ),
      ),
    );
  }
}
