import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/Palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:post_note/splash_logo.dart';
import 'login_field.dart';
import 'gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool invalidCredentials = false;
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
        Navigator.pushNamed(
          context,
          '/home',
        );
      } on FirebaseAuthException catch (e) {
        // TODO: Check specific codes; extend to create acct for credentials that are taken or invalid (too long?)
        if (e.code != "") {
          setState(() {
            invalidCredentials = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 1.3,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: SplashLogo(),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 8.0),
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
                      if (invalidCredentials) {
                        return "Invalid Login Credentials";
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
                      if (invalidCredentials) {
                        return "Invalid Login Credentials";
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
                      debugPrint(email);
                      Navigator.pushNamed(
                        context,
                        '/create-account',
                        arguments: {'email': email},
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      // HACK: change shape to remove background
                      backgroundColor: Colors.transparent,
                      maximumSize: const Size(400.0, double.infinity),
                      minimumSize: const Size(400.0, 0.0),
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: SvgPicture.asset(
                      "svgs/web_neutral_sq_ctn.svg",
                      width: 400.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
