import 'package:flutter/material.dart';
import 'package:post_note/WeekFolder.dart';
import 'package:post_note/palette.dart';

// add an unenroll button

class ClassPagePrime extends StatelessWidget {
  final String className;

  const ClassPagePrime({
    super.key,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          className,
          style: const TextStyle(fontSize: 55),
        ),
      ),
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
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Palette.outerSpace,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(
                              color: Palette.teaGreen,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        8.0, 16.0, 8.0, 16.0),
                                    child: Text(
                                      "Class Study Groups",
                                      style: TextStyle(fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Palette.outerSpace,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(
                              color: Palette.teaGreen,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        8.0, 16.0, 8.0, 16.0),
                                    child: Text(
                                      "My Study Groups",
                                      style: TextStyle(fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: double.infinity,
                    child: Card(
                      color: Palette.outerSpace,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          color: Palette.teaGreen,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TEST",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Text("TEST", style: TextStyle(fontSize: 24.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
