import 'package:flutter/material.dart';
import 'package:post_note/Palette.dart';
import 'login_field.dart';
import 'gradient_button.dart';

class CreateAccountScreen extends StatelessWidget {
  String? email;
  String? password;
  CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 20),
            const Image(
              image: AssetImage('images/Post-Note-Logo.png'),
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const Text(
              'Create a new Account.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Palette.outerSpace,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            LoginField(
              hintText: 'Email',
              onSubmit: (value) {
                email = value;
              },
              obscured: false,
            ),
            const SizedBox(height: 15),
            LoginField(
              hintText: 'Password',
              onSubmit: (value) {
                password = value;
              },
              obscured: true,
            ),
            const SizedBox(height: 25),
            const GradientButton(textParameter: "Create Account"),
            // SizedBox(height: 100)
          ]),
        ),
      ),
    );
  }
}
