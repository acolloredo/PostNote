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
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
          heightFactor: 1.2,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Tooltip(
                  waitDuration: Duration(seconds: 1),
                  verticalOffset: 80.0,
                  message: "share, manage, and view notes!",
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('images/Post-Note-Logo.png'),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 4.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Palette.outerSpace,
                      fontSize: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LoginField(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LoginField(
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
                  child: GradientButton(
                      textParameter: "Sign in",
                      onPressedFunction: () async {
                        await signInEmailPassword(email, password);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientButton(
                    textParameter: "Create account",
                    onPressedFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontSize: 20,
                      color: Palette.outerSpace,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SocialButton(iconPath: 'svgs/g_logo.svg', label: 'Continue with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
