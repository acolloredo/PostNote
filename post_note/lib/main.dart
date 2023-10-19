import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            // For text banner at the top
            backgroundColor: Colors.green,
            title: const Text("CSE XXX"),
          ),
          body: Container(
            child: const Text("Study Groups"),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.green,
            ),
          )),
    );
  }
}
