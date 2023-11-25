import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/class_page.dart';

final ScrollController classViewScrollController = ScrollController(
  debugLabel: "classViewScrollController",
);

class ClassView extends StatefulWidget {
  const ClassView({super.key});

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  @override
  Widget build(BuildContext context) {
    final firestoreInstance = FirebaseFirestore.instance;

    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestoreInstance
                .collection("classes")
                .where('quarter', isEqualTo: "Fall23")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    controller: classViewScrollController,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.fromLTRB(100.0, 25.0, 100.0, 0.0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400.0,
                      mainAxisExtent: max(constraints.maxHeight / 3, 250.0),
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      final className = doc["class_name"];
                      final professorName = doc["professor_name"];
                      debugPrint("INDEX: $index");
                      debugPrint("CLASS NAME: $className");
                      debugPrint("PROFESSOR NAME: $professorName");
                      debugPrint("\n\n");

                      return ClassCard(
                        constraints: constraints,
                        professorName: professorName,
                        courseID: className,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class ClassCard extends StatefulWidget {
  final String professorName;
  final String courseID;
  final BoxConstraints constraints;
  const ClassCard({
    super.key,
    required this.professorName,
    required this.courseID,
    required this.constraints,
  });

  @override
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  bool userInClass = false;
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> enrollUserInClass(uid, classId) async {
    await firestoreInstance.collection("users").doc(uid).update({
      "enrolled_classes": FieldValue.arrayUnion([classId])
    });

    setState(() {
      userInClass = true;
    });
  }

  void sendToClassPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassPage(className: widget.courseID)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          child: Card(
            color: userInClass ? Palette.outerSpace : Palette.fernGreen,
            child: InkWell(
              onTap: () {
                _enrollDialogBuilder(
                    context, widget.courseID, widget.professorName);
                // // takes to class-specific page
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             ClassPage(className: widget.courseID)));

                // setState(() {
                //   // TODO: remove (only here to demo class membership styling)
                //   userInClass = !userInClass;
                // });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: userInClass ? Palette.teaGreen : Palette.mintCream,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.courseID,
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      Text(widget.professorName,
                          style: const TextStyle(fontSize: 24.0)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _enrollDialogBuilder(
      BuildContext context, String courseID, String professor) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Palette.mintCream,
            title: Center(
                child: Text(
              courseID,
              style: const TextStyle(fontSize: 40),
            )),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Would you like to enroll in $courseID with $professor?',
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Palette.outerSpace)),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Text(
                    'Enroll',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Palette.errorColor)),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
