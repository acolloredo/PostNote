import 'package:flutter/material.dart';
import 'package:post_note/Palette.dart';
import 'package:post_note/social_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_field.dart';
import 'gradient_button.dart';
import 'create_account_screen.dart';
import 'class_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final formKey = GlobalKey<FormState>();

  Future signInEmailPassword(email, password) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email, //emailController.text
                password: password //passwordController.text
                );
        final user = userCredential.user;
        debugPrint("Signed in user: $user");
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClassView()),
        );
      } catch (e) {
        // TODO: add error handling
        debugPrint("Error: $e\n");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 20),
              const Image(
                image: AssetImage('images/Post-Note-Logo.png'),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const Text(
                'Sign in.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.outerSpace,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'A central hub to upload, view, and share your notes!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.outerSpace,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 50),
              const SocialButton(
                  iconPath: 'svgs/g_logo.svg', label: 'Continue with Google'),
              const SizedBox(height: 15),
              const Text(
                'or',
                style: TextStyle(
                  fontSize: 20,
                  color: Palette.outerSpace,
                ),
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Email',
                onSubmit: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter an Email Address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Password',
                onSubmit: (value) {
                  password = value;
                },
                obscured: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter a Password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              GradientButton(
                  textParameter: "Sign In",
                  onPressedFunction: () async {
                    await signInEmailPassword(email, password);
                  }),
              const SizedBox(height: 15),
              GradientButton(
                  textParameter: "Create Account",
                  onPressedFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateAccountScreen()),
                    );
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
