import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_note/splash_logo.dart';
import 'login_field.dart';
import 'gradient_button.dart';
import 'class_view.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({
    super.key,
  });

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String? email;
  String? password;
  String? confirmPassword;
  final formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;

  Future createAccount(email, password) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final user = userCredential.user;
        var userData = {
          "uid": user!.uid,
          "email": user.email,
          "enrolled_classes": [],
        };
        firestoreInstance.collection("users").doc(user.uid).set(userData);
        debugPrint("Created account for user: $user");
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
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 1.3,
          child: Form(
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
                    'Create an account',
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
                    initialText: arguments['email'],
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
                  padding: const EdgeInsets.all(8.0),
                  child: LoginField(
                    hintText: 'Confirm Password',
                    onSubmit: (value) {
                      confirmPassword = value;
                    },
                    obscured: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Re-Enter New Password";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters long";
                      } else if (value != confirmPassword) {
                        return "Please enter the same password as above";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientButton(
                    textParameter: "Create Account",
                    onPressed: () async {
                      await createAccount(email, password);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: TextButton.icon(
                      label: const Text(
                        "Back",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(Icons.arrow_back),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Palette.mint,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
