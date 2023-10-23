import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_note/palette.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomePage(),
      theme: ThemeData(
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
