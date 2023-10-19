import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CSE XXX'),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              // Left column with 3 text boxes
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align column to the left
                children: <Widget>[
                  // Stack for overlay effect
                  Stack(
                    children: <Widget>[
                      // "Study Groups" box
                      Container(
                        width: 300,
                        height: 800,
                        color: Colors.grey,
                      ),
                      // "Study Group:" box
                      Positioned(
                        top: 100, // vertical
                        left: 50, // horizontal
                        child: Container(
                          width: 200,
                          height: 60,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Study Groups',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // "Currently in:" box
                      Positioned(
                        top: 300, // vertical
                        left: 50, // horizontal
                        child: Container(
                          width: 200,
                          height: 60,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Currently in:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // "Request to join others:" box
                      Positioned(
                        top: 470, // vertical
                        left: 50, // horizontal
                        child: Container(
                          width: 200,
                          height: 60,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Request to join others:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
