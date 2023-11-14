import 'package:flutter/material.dart';
import 'package:post_note/Palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_field.dart';
import 'gradient_button.dart';
import 'class_view.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String? email;
  String? password;
  String? confirmPassword;
  final formKey = GlobalKey<FormState>();

  Future createAccount(email, password, formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final user = userCredential.user;
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
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please Enter New Password";
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
                validator: (String? value) {
                  confirmPassword = value!;
                  if (value.isEmpty) {
                    return "Please Enter New Password";
                  } else if (value.length < 8) {
                    return "Password must be atleast 8 characters long";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Confirm Password',
                onSubmit: (value) {
                  password = value;
                },
                obscured: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Re-Enter New Password";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  } else if (value != confirmPassword) {
                    return "Password must be same as above";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 25),
              GradientButton(
                textParameter: "Create Account",
                onPressedFunction: () async {
                  await createAccount(email, password, formKey);
                },
              ),
              // SizedBox(height: 100)
            ]),
          ),
        ),
      ),
    );
  }
}
