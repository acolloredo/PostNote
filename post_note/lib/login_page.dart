import 'package:flutter/material.dart';
import 'sign_in_with_google_button.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:post_note/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:post_note/splash_logo.dart';
import 'login_field.dart';
import 'gradient_button.dart';

Future<UserCredential> signInWithGoogle() async {
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  return await FirebaseAuth.instance.signInWithPopup(googleProvider);
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool invalidLoginCredentials = false;
  final formKey = GlobalKey<FormState>();

  Future signInEmailPassword(email, password) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: email, //emailController.text
              password: password, //passwordController.text
            )
            .timeout(const Duration(seconds: 4));

        final user = userCredential.user;
        debugPrint("Signed in user: $user");

        invalidLoginCredentials = false;
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-login-credentials") {
          setState(() {
            invalidLoginCredentials = true;
          });
        }
      } catch (e) {
        invalidLoginCredentials = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              onChanged: () {
                invalidLoginCredentials = false;
              },
              autovalidateMode: invalidLoginCredentials
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              key: formKey,
              child: AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: SplashLogo(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
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
                        autofillHints: const [AutofillHints.username],
                        hintText: 'Email',
                        onSubmit: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter an Email Address";
                          }
                          if (invalidLoginCredentials) {
                            return "Invalid Login Credentials";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoginField(
                        autofillHints: const [AutofillHints.password],
                        hintText: 'Password',
                        onSubmit: (value) {
                          password = value;
                        },
                        obscured: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter a Password";
                          }
                          if (invalidLoginCredentials) {
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
                        onPressed: () {
                          debugPrint("Sign in button pressed");
                          TextInput.finishAutofillContext();
                          signInEmailPassword(email, password).timeout(
                              const Duration(seconds: 4), onTimeout: () {
                            debugPrint("Sign in timed out");
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GradientButton(
                        textParameter: "Create account",
                        onPressed: () {
                          TextInput.finishAutofillContext();
                          Navigator.pushNamed(
                            context,
                            '/create-account',
                            arguments: {'email': email},
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 350,
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Palette.outerSpace.withAlpha(200),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Or",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Palette.outerSpace.withAlpha(200)),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Palette.outerSpace.withAlpha(200),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 384.0,
                        height: 70.0,
                        child: SignInWithGoogleButton(
                          onPressed: () async {
                            await signInWithGoogle();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
