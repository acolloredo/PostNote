import 'dart:math';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:post_note/class_card.dart';
import 'search_bar.dart';

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
  List<Map<String, dynamic>> classData = [];
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
        var query = firestoreInstance
            .collection("classes")
            .where('class_uid', whereNotIn: enrolledClassesArr)
            .where('quarter', isEqualTo: "Fall23");
        print(query);
        Stream<QuerySnapshot<Object?>> unenrolledClassesStream =
            firestoreInstance
                .collection("classes")
                .where('class_uid', whereNotIn: enrolledClassesArr)
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
    return StreamBuilder<QuerySnapshot>(
      stream: classViewStreamController.stream, // Use classViewStreamController
      builder: (context, snapshot) {
        return SearchBarAnchor(
          myController: SearchController(),
          classItems: classData, // Pass class data to SearchBarAnchor
          suggestionsBuilder: (context, controller) {
            final searchQuery = controller.query.toLowerCase();
            final filteredClasses = snapshot.data!.docs.where((doc) {
              final className = doc["class_name"].toLowerCase();
              final professorName = doc["professor_name"].toLowerCase();
              return className.contains(searchQuery) ||
                  professorName.contains(searchQuery);
            }).toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400.0,
                mainAxisExtent:
                    max(MediaQuery.of(context).size.height / 3, 250.0),
              ),
              itemCount: filteredClasses.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(filteredClasses[index]["class_name"]);
              },
            );
          },
        );
      },
    );
  }
}
