// ignore_for_file: avoid_print
import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:post_note/class_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/appbar_options.dart';
import 'package:post_note/palette.dart';

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
  List enrolledClassesArr = [];
  List unenrolledClassesArr = [];
  final firestoreInstance = FirebaseFirestore.instance;
  late Future dataLoaded;
  StreamController<QuerySnapshot<Object?>> classViewStreamController =
      BehaviorSubject();
  SearchController classSearchController = SearchController();

  Future getEnrolledClassesArray() async {
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

  Future getUnenrolledClassesArray() async {
    await getEnrolledClassesArray();
    if (enrolledClassesArr.isNotEmpty) {
      var data = await firestoreInstance
          .collection("classes")
          .where('class_uid', whereNotIn: enrolledClassesArr)
          .where('quarter', isEqualTo: "Fall23")
          .get();
      setState(() {
        unenrolledClassesArr = data.docs;
      });
    } else {
      var data = await firestoreInstance
          .collection("classes")
          .where('quarter', isEqualTo: "Fall23")
          .get();
      setState(() {
        unenrolledClassesArr = data.docs;
      });
    }
    return "success";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dataLoaded = getUnenrolledClassesArray();
  }

  @override
  initState() {
    super.initState();
    getEnrolledClassesArray().whenComplete(() async {
      if (enrolledClassesArr.isNotEmpty) {
        Stream<QuerySnapshot<Object?>> unenrolledClassesStream =
            firestoreInstance
                .collection("classes")
                .where('class_uid', whereNotIn: enrolledClassesArr)
                .where('quarter', isEqualTo: "Fall23")
                .snapshots();

        setState(() {
          classViewStreamController.addStream(unenrolledClassesStream);
        });
      } else {
        setState(() {
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SearchAnchor(
                  searchController: classSearchController,
                  viewLeading: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Palette.outerSpace,
                      onPressed: () {
                        classSearchController.closeView(null);
                      },
                    ),
                  ),
                  viewTrailing: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: Palette.outerSpace,
                        onPressed: () {
                          classSearchController.clear();
                        },
                      ),
                    )
                  ],
                  headerTextStyle: const TextStyle(
                    backgroundColor: Colors.transparent,
                    color: Palette.outerSpace,
                  ),
                  dividerColor: Palette.outerSpace,
                  builder: (context, controller) {
                    return SearchBar(
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.search,
                          color: Palette.outerSpace,
                        ),
                      ),
                      elevation: const MaterialStatePropertyAll(0.0),
                      surfaceTintColor:
                          const MaterialStatePropertyAll(Palette.fernGreen),
                      onChanged: (value) {
                        print(value);
                      },
                    );
                  },
                  suggestionsBuilder: (context, controller) {
                    return [];
                  },
                ),
              ),
            ),
          ],
        ),
        leading: Container(
          margin: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
          child: Tooltip(
            message: "Home",
            child: InkWell(
              borderRadius: BorderRadius.circular(5.0),
              onTap: () {
                debugPrint(ModalRoute.of(context)?.settings.name);
                if (ModalRoute.of(context)?.settings.name == '/class-search') {
                  Navigator.pop(context);
                } else {
                  classViewScrollController.animateTo(
                    classViewScrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              child: SvgPicture.asset(
                'svgs/Post-Note-Logo-Filled.svg',
              ),
            ),
          ),
        ),
        actions: const [
          AppBarOptions(),
        ],
      ),
      body: Column(
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
                        print(classSearchController.value);

                        return ClassCard(
                          constraints: constraints,
                          professorName: professorName,
                          className: className,
                          classUid: classUid,
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
      ),
    );
  }
}
