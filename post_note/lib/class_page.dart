import 'package:flutter/material.dart';
import 'package:post_note/week_folder.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/appbar_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassPage extends StatelessWidget {
  final String className;
  final String professorName;
  final String classUid;
  final String uid;

  final firestoreInstance = FirebaseFirestore.instance;

  // unenroll:
  // get call to Firestore to get classUids enrolled in; current array of enrolled class
  // pop the unenrolled class from array
  // update to call to update to not have the class that you want to unenroll
  // and naviate user back to enrolled classes

  ClassPage({
    super.key,
    required this.className,
    required this.professorName,
    required this.classUid,
    required this.uid, // uid was already found in class_card.dart
  });

  // unenroll user function by removing classUid from enrolled_classes array
  Future<void> unenrollUserInClass(uid, classUid) async {
    await firestoreInstance.collection("users").doc(uid).update({
      "enrolled_classes": FieldValue.arrayRemove([classUid])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: Center(
          child: Text(
            "$className with $professorName",
            style: const TextStyle(fontSize: 35),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Palette.teaGreen),
            child: IconButton(
              icon: const Icon(Icons.remove_circle_outline_rounded),
              iconSize: 30.0,
              tooltip: "Unenroll",
              color: Palette.outerSpace,
              onPressed: () {
                unenrollUserInClass(uid, classUid).whenComplete(() {
                  Navigator.of(context).pop();
                  Navigator.of(context, rootNavigator: true)
                      .popAndPushNamed("/enrolled-classes");
                });
              },
            ),
          ),
          const AppBarOptions(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
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
                              padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          color: Palette.outerSpace,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WeekFolder(
                                                                weekNumber:
                                                                    index + 1,
                                                                className:
                                                                    className)));
                                              },
                                              child: Card(
                                                color: Palette.mintCream,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
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
                    Expanded(
                      flex: 1,
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
