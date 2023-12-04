import 'package:flutter/material.dart';
import 'package:post_note/WeekFolder.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/appbar_hamburger.dart';

// add an unenroll button

class ClassPagePrime extends StatelessWidget {
  final String className;
  final String professorName;

  const ClassPagePrime({
    super.key,
    required this.className,
    required this.professorName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: Text(
          "$className with $professorName",
          style: const TextStyle(fontSize: 35),
        ),
        actions: const [AppBarHamburger()],
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  child: SizedBox(
                    height: double.infinity,
                    child: Card(
                      color: Palette.outerSpace,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          color: Palette.teaGreen,
                          child: Column(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                                child: Text(
                                  "Weeks",
                                  style: TextStyle(fontSize: 40.0),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 16.0, 16.0, 0.0),
                                  child: SizedBox(
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      return GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            mainAxisSpacing: 16.0,
                                            mainAxisExtent:
                                                constraints.maxHeight / 2.25,
                                          ),
                                          itemCount: 10,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                              color: Palette.fernGreen,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Card(
                                                  color: Palette.mintCream,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Week ${index + 1} Notes",
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Palette.outerSpace,
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
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
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Palette.outerSpace,
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
