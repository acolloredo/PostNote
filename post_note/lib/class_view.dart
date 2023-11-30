import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/class_page.dart';
import 'search_bar.dart';

final ScrollController classViewScrollController = ScrollController(
  debugLabel: "classViewScrollController",
);

class ClassView extends StatefulWidget {
  const ClassView({super.key});

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  final firestoreInstance = FirebaseFirestore.instance;
  List<DocumentSnapshot> allClasses = [];
  List<DocumentSnapshot> filteredClasses = [];
  String searchQuery = "";

  void filterClasses(String query) {
    setState(() {
      searchQuery = query;
      filteredClasses = allClasses
          .where((doc) =>
              doc['class_name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              doc['professor_name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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

              return LayoutBuilder();
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
                // takes to class-specific page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassPage(className: widget.courseID)));

                setState(() {
                  // TODO: remove (only here to demo class membership styling)
                  userInClass = !userInClass;
                });
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
}
