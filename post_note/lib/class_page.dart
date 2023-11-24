import 'package:flutter/material.dart';
import 'package:post_note/WeekFolder.dart';
import 'package:post_note/palette.dart';

class ClassPage extends StatelessWidget {
  final String className;

  const ClassPage({
    Key? key,
    required this.className,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          className,
          style: TextStyle(fontSize: 55),
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
                  // Stack for overlay effect
                  Stack(
                    children: <Widget>[
                      // "Study Groups" box
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

              // add right box for week layout
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.5,
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                      // Week buttons using Flexible
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          5,
                          (index) => Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploadPage(
                                              className: className,
                                              weekNumber: index + 1,
                                            )));
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  screenWidth * 0.25,
                                  screenWidth * 0.05,
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  'Week ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Week buttons for the second set
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          5,
                          (index) => Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploadPage(
                                              className: className,
                                              weekNumber: index + 6,
                                            )));
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  screenWidth * 0.25,
                                  screenWidth * 0.05,
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  'Week ${index + 6}',
                                  style: TextStyle(
                                    fontSize: 25,
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
