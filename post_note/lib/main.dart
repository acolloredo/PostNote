import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'CSE XXX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: FractionalOffset.topLeft, // make box be on the left
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: 300.0,
          height: 1000.0,
          color: Color.fromARGB(217, 185, 185, 191),
          child: const Center(
            child: Text("Study Groups",
                style: TextStyle(color: Color(0xff023047), fontSize: 30.0)),
          ),
        ),
      ),
    );
  }
}
