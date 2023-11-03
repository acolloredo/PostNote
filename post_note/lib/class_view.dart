import 'dart:math';
import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // TODO: replace with some sort of sliver implementation when adding search bar?
          return GridView.builder(
            controller: ScrollController(
              debugLabel: "ClassView_Scroll_Controller",
            ),
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400.0,
              mainAxisExtent: max(constraints.maxHeight / 3, 250.0),
            ),
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return ClassCard(
                constraints: constraints,
                professorName: "Professor number $index",
                courseID: "Course $index",
              );
            },
          );
        },
      ),
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
                // TODO: take to class-specific page
                setState(() {
                  // TODO: remove (only here to demo class membership styling)
                  userInClass = !userInClass;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: Palette.mintCream,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.professorName),
                      Text(widget.courseID),
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
