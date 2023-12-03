import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:post_note/create_account_page.dart';
import 'package:post_note/home_page.dart';
import 'package:post_note/login_page.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/class_view.dart';
import 'package:post_note/enrolled_classes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PostNote());
}

class PostNote extends StatefulWidget {
  const PostNote({super.key});

  @override
  State<PostNote> createState() => _PostNoteState();
}

class _PostNoteState extends State<PostNote> {
  final Future<FirebaseApp> initFirebaseApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "login",
      routes: {
        '/': (context) => FutureBuilder(
              future: initFirebaseApp,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  FirebaseAuth.instance.authStateChanges().listen(
                    (user) {
                      if (user != null) {
                        Navigator.of(context).pushNamed('/enrolled-classes');
                      }
                    },
                  );
                }
                return const LoginPage();
              },
            ),
        '/create-account': (context) => const CreateAccountPage(),
        '/enrolled-classes': (context) => const HomePage(
              bodyContent: EnrolledClassView(),
            ),
        '/class-search': (context) => const HomePage(
              bodyContent: ClassView(),
            ),
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
