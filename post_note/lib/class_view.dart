// ignore_for_file: avoid_print
import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:post_note/class_card.dart';

final ScrollController classViewScrollController = ScrollController(
  debugLabel: "classViewScrollController",
);

String _getCurrentUID() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final String uid = user!.uid;
  return uid;
}

class ClassView extends StatefulWidget {
  const ClassView({super.key});

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  Iterable enrolledClassesArr = [];
  final firestoreInstance = FirebaseFirestore.instance;
  StreamController<QuerySnapshot<Object?>> classViewStreamController =
      BehaviorSubject();

  Future<void> getEnrolledClassesArray() async {
    await firestoreInstance
        .collection("users")
        .doc(_getCurrentUID())
        .get()
        .then((value) {
      setState(() {
        print("SET STATE IN getEnrolledClassesArray");
        enrolledClassesArr = value.data()?["enrolled_classes"];
        print(enrolledClassesArr);
      });
    });
  }

  @override
  initState() {
    super.initState();
    getEnrolledClassesArray().whenComplete(() async {
      if (enrolledClassesArr.isNotEmpty) {
        Stream<QuerySnapshot<Object?>> unenrolledClassesStream =
            firestoreInstance
                .collection("classes")
                .where('class_name', whereNotIn: enrolledClassesArr)
                .where('quarter', isEqualTo: "Fall23")
                .snapshots();

        setState(() {
          print("SET STATE IN enrolledClassesArr.isNotEmpty");
          classViewStreamController.addStream(unenrolledClassesStream);
        });
      } else {
        debugPrint("NO ENROLLED CLASSES");
        setState(() {
          print("SET STATE IN else");
          classViewStreamController.addStream(firestoreInstance
              .collection("classes")
              .where('quarter', isEqualTo: "Fall23")
              .snapshots());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build!");
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: classViewStreamController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("no data");
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
                        userInClass: false,
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
