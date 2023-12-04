import 'package:flutter/material.dart';
import 'package:post_note/WeekFolder.dart';
import 'package:post_note/palette.dart';

// add an unenroll button

class ClassPage extends StatelessWidget {
  final String className;

  const ClassPage({
    super.key,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          className,
          style: const TextStyle(fontSize: 55),
        ),
      ),
      // unenroll button
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: SizedBox(
        height: 100,
        width: 100,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              // allow student to unenroll from class
            },
            backgroundColor: Palette.fernGreen,
            child: const Text('Unenroll'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            children: <Widget>[
              // Left column with 3 text boxes
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // left grey box for study groups
                      Container(
                        width: screenWidth * 0.5,
                        height: screenWidth * 0.5,
                        color: Colors.grey,
                      ),
                      // "Study Groups:" box
                      Positioned(
                        top: 20,
                        left: 85,
                        child: Container(
                          width: screenWidth * 0.35,
                          height: screenWidth * 0.1,
                          color: Palette.fernGreen,
                          child: const Center(
                            child: Text(
                              'Study Groups:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // "Currently in:" box
                      Positioned(
                        top: 120,
                        left: 85,
                        child: Container(
                          width: screenWidth * 0.35,
                          height: screenWidth * 0.2,
                          color: Palette.fernGreen,
                          child: const Align(
                            alignment: Alignment(-0.85, -0.7),
                            child: Text(
                              'Currently in:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // "Request to join others:" box
                      Positioned(
                        top: 320,
                        left: 85,
                        child: Container(
                          width: screenWidth * 0.35,
                          height: screenWidth * 0.2,
                          color: Palette.fernGreen,
                          child: const Align(
                            alignment: Alignment(-0.85, -0.7),
                            child: Text(
                              'Request to join others:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // right box grey box for week layout
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.5,
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // "Week Folders for Notes:" box
                      Container(
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.1,
                        color: Palette.fernGreen,
                        child: const Center(
                          child: Text(
                            'Week Folders for Notes:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      // two rows for week buttons
                      // 1st row: Week 1 - 5
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          5,
                          (index) => Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                // if Week # button pushed, go to Week Page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WeekFolder(
                                        weekNumber: index + 1,
                                        className: className,
                                      ),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  screenWidth * 0.35,
                                  screenWidth * 0.05,
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  'Week ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Week buttons for the second set
                      // 2 row: Week 6 - 10
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          5,
                          (index) => Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                // if Week # button pushed, go to Week Page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WeekFolder(
                                              weekNumber: index + 6,
                                              className: className,
                                            )));
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  screenWidth * 0.35,
                                  screenWidth * 0.05,
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  'Week ${index + 6}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
