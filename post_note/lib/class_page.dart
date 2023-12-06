import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_note/week_folder.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/appbar_options.dart';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

// add an unenroll button

class ClassPage extends StatelessWidget {
  final String className;
  final String classUid;
  final String professorName;
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
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Tooltip(
              message: "Unenroll",
              child: Material(
                color: Palette.teaGreen,
                child: InkWell(
                  onTap: () {
                    unenrollUserInClass(uid, classUid).whenComplete(() {
                      Navigator.of(context).pop();
                      Navigator.of(context, rootNavigator: true)
                          .popAndPushNamed("/enrolled-classes");
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.rotate(
                      angle: pi, // 180
                      child: const Icon(
                        Icons.exit_to_app,
                        color: Palette.outerSpace,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const AppBarOptions(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 1.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClassPageSection(
                    title: "Weeks",
                    body: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                maxCrossAxisExtent:
                                    max(constraints.maxWidth / 5, 200.0),
                                mainAxisExtent:
                                    max(constraints.maxHeight / 2.25, 50.0),
                                childAspectRatio: 2.0,
                              ),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Palette.outerSpace,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WeekFolder(
                                              professorName: professorName,
                                              weekNumber: index + 1,
                                              className: className,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        color: Palette.mintCream,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FittedBox(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "Week ${index + 1} Notes",
                                                  style: const TextStyle(
                                                      fontSize: 25.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 1.0,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: ClassPageSection(
                            title: "My Study Groups",
                            body: Expanded(
                              child: MyStudyGroupListView(
                                classUid: classUid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: ClassPageSection(
                            title: "Class Study Groups",
                            body: Expanded(
                              child: JoinableStudyGroupListView(
                                classUid: classUid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStudyGroupListView extends StatefulWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  final String classUid;

  MyStudyGroupListView({
    super.key,
    required this.classUid,
  });

  @override
  State<MyStudyGroupListView> createState() => _MyStudyGroupListViewState();
}

class _MyStudyGroupListViewState extends State<MyStudyGroupListView> {
  StreamController<QuerySnapshot<Object?>> studyGroupListViewStreamController =
      BehaviorSubject();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: widget.firestoreInstance
              .collection("study_groups")
              .where("class_uid", isEqualTo: widget.classUid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    color: Palette.outerSpace,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Palette.mintCream,
                        ),
                        child: Builder(
                          builder: (context) {
                            List<dynamic> members =
                                snapshot.data?.docs[index].get("members") ?? "";
                            var name =
                                snapshot.data?.docs[index].get("name") ?? "";
                            return Row(
                              children: [
                                Text("${index + 1}.  "),
                                Text("$name"),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    Text(members.length.toString())
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class JoinableStudyGroupListView extends StatefulWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  final String classUid;

  JoinableStudyGroupListView({
    super.key,
    required this.classUid,
  });

  @override
  State<JoinableStudyGroupListView> createState() =>
      _JoinableStudyGroupListView();
}

class _JoinableStudyGroupListView extends State<JoinableStudyGroupListView> {
  StreamController<QuerySnapshot<Object?>> studyGroupListViewStreamController =
      BehaviorSubject();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: widget.firestoreInstance
              .collection("joinable_study_groups")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    color: Palette.outerSpace,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Palette.mintCream,
                        ),
                        child: Builder(
                          builder: (context) {
                            List<dynamic> members =
                                snapshot.data?.docs[index].get("members") ?? "";
                            var name =
                                snapshot.data?.docs[index].get("name") ?? "";
                            return Row(
                              children: [
                                Text("${index + 1}.  "),
                                Text("$name"),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    Text(members.length.toString())
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ClassPageSection extends StatelessWidget {
  final String title;
  final Widget body;
  const ClassPageSection({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.outerSpace,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Palette.teaGreen,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body,
            ],
          ),
        ),
      ),
    );
  }
}
