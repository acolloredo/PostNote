import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreInstance = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: firestoreInstance
          .collection("classes")
          .where('quarter', isEqualTo: "Fall23")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("No Classes Available"),
          );
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.fromLTRB(
                  100.0,
                  25.0,
                  100.0,
                  25.0,
                ),
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
        }
      },
    );
  }
}

class ClassCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // TODO: take to class-specific page
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(professorName),
                    Text(courseID),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
