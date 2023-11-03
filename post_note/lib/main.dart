
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_note/palette.dart';
import 'home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CupertinoScrollBehavior().copyWith(
        dragDevices: {},
        overscroll: true,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomePage(),
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all(true),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: const ColorScheme(
          primary: Palette.fernGreen,
          brightness: Brightness.light,
          onPrimary: Palette.mintCream,
          secondary: Palette.celadon,
          onSecondary: Palette.mintCream,
          error: Colors.yellow,
          onError: Colors.red,
          background: Palette.mintCream,
          onBackground: Palette.outerSpace,
          surface: Palette.fernGreen,
          onSurface: Palette.mintCream,
        ),
        primaryColor: Colors.green,
        splashFactory: NoSplash.splashFactory,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Palette.mintCream,
          ),
        ),
      ),
    );
  }
}

// TO BE MOVED TO LOGIN WIDGET DART FILE
// Will take input from text controllers in the Flutter UI
// We have one registered user with:
// email: acollore@ucsc.edu
// password: 12345678

Future signInEmailPassword() async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: "acollore@ucsc.edu", //emailController.text
      password: "12345678" //passwordController.text
      );
}
