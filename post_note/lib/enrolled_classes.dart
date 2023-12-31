import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_note/auth.dart';
import 'package:post_note/stylized_appbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:post_note/class_card.dart';
import 'package:post_note/palette.dart';

final ScrollController enrolledClassViewScrollController = ScrollController(
  debugLabel: "enrolledClassViewScrollController",
);

class EnrolledClassView extends StatefulWidget {
  const EnrolledClassView({super.key});

  @override
  State<EnrolledClassView> createState() => _EnrolledClassViewState();
}

class _EnrolledClassViewState extends State<EnrolledClassView> {
  Iterable enrolledClassesArr = [];
  int numEnrolledClasses = 0;
  final firestoreInstance = FirebaseFirestore.instance;
  StreamController<QuerySnapshot<Object?>> enrolledClassViewStreamController =
      BehaviorSubject();

  Future<void> getEnrolledClassesArray() async {
    await firestoreInstance
        .collection("users")
        .doc(getCurrentUID())
        .get()
        .then((value) {
      setState(() {
        enrolledClassesArr = value.data()?["enrolled_classes"];
        numEnrolledClasses = enrolledClassesArr.length;
      });
    });
  }

  @override
  initState() {
    super.initState();
    getEnrolledClassesArray().whenComplete(() {
      if (enrolledClassesArr.isNotEmpty) {
        numEnrolledClasses = enrolledClassesArr.length;
        debugPrint("$numEnrolledClasses ENROLLED CLASSES");

        Stream<QuerySnapshot<Object?>> enrolledClassesStream = firestoreInstance
            .collection("classes")
            .where('class_uid', whereIn: enrolledClassesArr)
            .where('quarter', isEqualTo: "Fall23")
            .snapshots();

        setState(() {
          enrolledClassViewStreamController.addStream(enrolledClassesStream);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StyledAppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: enrolledClassViewStreamController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                          child: Text(
                            "You are not enrolled in any classes yet!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.outerSpace,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                          child: Text(
                            "Click the button below to enroll in one.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Palette.outerSpace,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      controller: enrolledClassViewScrollController,
                      clipBehavior: Clip.antiAlias,
                      padding:
                          const EdgeInsets.fromLTRB(100.0, 25.0, 100.0, 0.0),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400.0,
                        mainAxisExtent: max(constraints.maxHeight / 3, 250.0),
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        final className = doc["class_name"];
                        final professorName = doc["professor_name"];
                        final classUid = doc["class_uid"];
                        debugPrint("INDEX: $index");
                        debugPrint("CLASS NAME: $className");
                        debugPrint("PROFESSOR NAME: $professorName");
                        debugPrint("\n\n");

                        return ClassCard(
                          constraints: constraints,
                          professorName: professorName,
                          className: className,
                          classUid: classUid,
                          userInClass: true,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/class-search');
        },
        tooltip: 'Add a class',
        child: const Icon(Icons.add),
      ),
    );
  }
}
