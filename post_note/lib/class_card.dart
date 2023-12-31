import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_note/auth.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/class_page.dart';

class ClassCard extends StatefulWidget {
  final String professorName;
  final String className;
  final BoxConstraints constraints;
  final bool userInClass;
  final String classUid;

  const ClassCard({
    super.key,
    required this.professorName,
    required this.className,
    required this.constraints,
    required this.userInClass,
    required this.classUid,
  });

  @override
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> enrollUserInClass(uid, classUid) async {
    await firestoreInstance.collection("users").doc(uid).update({
      "enrolled_classes": FieldValue.arrayUnion([classUid])
    });
  }

  void sendToClassPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClassPage(
          uid: getCurrentUID(),
          className: widget.className,
          classUid: widget.classUid,
          professorName: widget.professorName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 5.0,
          color: widget.userInClass ? Palette.outerSpace : Palette.fernGreen,
          child: InkWell(
            onTap: () {
              if (widget.userInClass) {
                // takes to class-specific page
                sendToClassPage();
              } else {
                _enrollDialogBuilder(
                    context, widget.className, widget.professorName);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color:
                    widget.userInClass ? Palette.teaGreen : Palette.mintCream,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.className,
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
    );
  }

  Future<void> _enrollDialogBuilder(
      BuildContext context, String className, String professor) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Palette.mintCream,
            title: Center(
                child: Text(
              className,
              style: const TextStyle(fontSize: 40),
            )),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Would you like to enroll in $className with $professor?',
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Palette.fernGreen)),
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
                  String uid = getCurrentUID();
                  enrollUserInClass(uid, widget.classUid).whenComplete(() {
                    Navigator.of(context).pop();
                    Navigator.of(context, rootNavigator: true)
                        .popAndPushNamed("/enrolled-classes");
                  });
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
