import 'package:flutter/material.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: const Text(
            'CSE XXX',
            style: TextStyle(fontSize: 55),
          )),
      body: Center(
        child: Row(
          // a row for two big containers
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
                      width: 700,
                      height: 895,
                      color: Colors.grey,
                    ),
                    // "Study Groups:" box
                    Positioned(
                      top: 40, // vertical
                      left: 50, // horizontal
                      child: Container(
                        width: 600,
                        height: 110,
                        color: Colors.green,
                        child: const Center(
                          child: Text(
                            'Study Groups:',
                            style: TextStyle(color: Colors.white, fontSize: 45),
                          ),
                        ),
                      ),
                    ),
                    // "Currently in:" box
                    Positioned(
                      top: 200, // vertical
                      left: 50, // horizontal
                      child: Container(
                        width: 600,
                        height: 300,
                        color: Colors.green,
                        child: const Align(
                          alignment: Alignment(-0.85, -0.7),
                          child: Text(
                            'Currently in:',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    // "Request to join others:" box
                    Positioned(
                      top: 550, // vertical
                      left: 50, // horizontal
                      child: Container(
                        width: 600,
                        height: 300,
                        color: Colors.green,
                        child: const Align(
                          alignment: Alignment(-0.75, -0.7),
                          child: Text(
                            'Request to join others:',
                            style: TextStyle(color: Colors.white, fontSize: 30),
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
                width: 1000,
                height: 895,
                color: Colors.grey,
                child: Column(
                    // column with 2 nested rows inside
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 600,
                        height: 110,
                        color: Colors.green,
                        child: const Center(
                          child: Text(
                            'Week Folders for Notes:',
                            style: TextStyle(color: Colors.white, fontSize: 45),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 1',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 2',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 3',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 4',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 5',
                                  style: TextStyle(fontSize: 30))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 6',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 7',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 8',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 9',
                                  style: TextStyle(fontSize: 30))),
                          ElevatedButton(
                              onPressed: () {
                                // Add button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(160, 90), // width, height
                              ),
                              child: const Text('Week 10',
                                  style: TextStyle(fontSize: 30))),
                        ],
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
