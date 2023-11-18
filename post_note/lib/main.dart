import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:post_note/create_account_screen.dart';
import 'package:post_note/home_page.dart';
import 'package:post_note/login_page.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_note/palette.dart';

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
      routes: {
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/create-account': (context) => const CreateAccountScreen(),
        '/home': (context) => const HomePage(),
      },
      scrollBehavior: const CupertinoScrollBehavior().copyWith(
        dragDevices: {},
        overscroll: true,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all(true),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        searchViewTheme: const SearchViewThemeData()
            .copyWith(backgroundColor: Colors.white, surfaceTintColor: Colors.white),
        searchBarTheme: const SearchBarThemeData(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              color: Palette.outerSpace,
              fontFamily: "Consolas",
              letterSpacing: 0.0,
            ),
          ),
          elevation: MaterialStatePropertyAll(
            5.0,
          ),
        ),
        colorScheme: const ColorScheme(
          primary: Palette.fernGreen,
          brightness: Brightness.light,
          onPrimary: Colors.white,
          secondary: Palette.celadon,
          onSecondary: Colors.white,
          error: Colors.yellow,
          onError: Colors.red,
          background: Colors.white,
          onBackground: Palette.outerSpace,
          surface: Palette.fernGreen,
          onSurface: Colors.white,
        ),
        primaryColor: Colors.green,
        splashFactory: NoSplash.splashFactory,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
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
