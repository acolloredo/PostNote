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
                        width: 500,
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
                          height: 200,
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
                        top: 570, // vertical
                        left: 50, // horizontal
                        child: Container(
                          width: 200,
                          height: 200,
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
              // space between study groups box and weeks box
              const Spacer(),
              // add right box for week layout
              Align(
                alignment: FractionalOffset.topRight,
                child: Container(
                  width: 900,
                  height: 800,
                  color: Colors.grey,
                  child: Column(
                      // column with 2 nested rows inside
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 1',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 2',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 3',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 4',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 5',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 6',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 7',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 8',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 9',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  // Add button action
                                },
                                child: Text('Week 10',
                                    style: TextStyle(fontSize: 18)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                          ],
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
