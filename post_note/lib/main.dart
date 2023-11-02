import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:post_note/palette.dart';
//import 'home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Post Note Search', textDirection: TextDirection.ltr),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ],
    ));
  }
}

@override
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'CSE 20',
    'CSE 101',
    'CSE 30',
    'CSE 115A',
    'CSE 103',
    'CSE 102',
    'CSE 13s',
    'CSE Math 19A/B'
  ];

  //this section is to clear the query
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        //leave and close the search bar
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var classInfo in searchTerms) {
      if (classInfo.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(classInfo);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            //result is the name of the class
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var classInfo in searchTerms) {
      if (classInfo.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(classInfo);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            //result is the name of the class
            title: Text(result),
          );
        });
  }
}


/*
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
*/


