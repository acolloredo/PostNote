// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_note/class_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/appbar_options.dart';
import 'package:post_note/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

final ScrollController classViewScrollController = ScrollController(
  debugLabel: "classViewScrollController",
);

class ClassView extends StatefulWidget {
  const ClassView({Key? key}) : super(key: key);

  @override
  State<ClassView> createState() => _ClassViewState();
}

String _getCurrentUID() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final String uid = user!.uid;
  return uid;
}

class _ClassViewState extends State<ClassView> {
  final firebaseInstance = FirebaseFirestore.instance;

  late Future dataLoaded; //declares variables that will be intialized later
  //List allClasses = [];
  List enrolledClassesArr = [];
  List unenrolledClassesArr = [];
  final firestoreInstance = FirebaseFirestore.instance;
  List searchResults = [];
  StreamController<QuerySnapshot<Object?>> classViewStreamController =
      BehaviorSubject();
  SearchController classSearchController = SearchController();
  TextEditingController classTextController = TextEditingController();

//getting the enrolled classesarray
  Future<void> getEnrolledClassesArray() async {
    await firebaseInstance
        .collection("users")
        .doc(_getCurrentUID())
        .get()
        .then((value) {
      //value of the future after it's been resolve
      setState(() {
        //print("SET STATE IN getEnrolledClassesArray");
        enrolledClassesArr = value.data()?["enrolled_classes"];
        //print(enrolledClassesArr);
      });
    });
  }

//getting the unerolledclasses
  Future getUnenrolledClassesArray() async {
    await getEnrolledClassesArray();
    //waiting until getEnrolled is finished
    //only use .then(), when you want to run a function from a query to firebase
    if (enrolledClassesArr.isNotEmpty) {
      var data = await firestoreInstance
          .collection("classes")
          .where('class_uid', whereNotIn: enrolledClassesArr)
          .where('quarter', isEqualTo: "Fall23")
          .get();
      //setting the state, since we are updating the unenrolled classes array
      setState(() {
        unenrolledClassesArr = data.docs;
        print(unenrolledClassesArr);
      });
    } else {
      //if we haven't enrolled in any classes, then we are going to add all the classes in data to our enrolledClasses Array
      var data = await firestoreInstance
          .collection("classes")
          .where('quarter', isEqualTo: "Fall23")
          .get();
      setState(() {
        unenrolledClassesArr = data.docs;
      });
    }

    searchResultsList();
    return "complete";
  }

  searchResultsList() {
    var showResults = [];
    //getting the search query from the
    if (classTextController.text.toLowerCase() != "") {
      for (var snapshot in unenrolledClassesArr) {
        //using classsSnapshot, to get the the class name and make it lowercase
        String className = snapshot["class_name"].toLowerCase();
        String professorName = snapshot["professor_name"].toLowerCase();

        if (className.contains(classTextController.text.toLowerCase())) {
          showResults.add(snapshot);
        }

        if (professorName.contains(classTextController.text.toLowerCase())) {
          showResults.add(snapshot);
        }
      }
    } else {
      showResults = List.from(unenrolledClassesArr);
    }

    setState(() {
      searchResults = showResults;
    });
  }

  @override
  void didChangeDependencies() {
    //return a future, so we have to create a new future variable
    //to tell us if it's been loaded or not
    super.didChangeDependencies();
    dataLoaded =
        getUnenrolledClassesArray(); //just flag to say the getUnerolled classes was loaded and set the state of that data list

    //because getUnenrolledArray is async, we can't just call it init
    //because it needs a call to firebase
  }

  //if the value isn't in the enrolled classes array, then assign it

  _onSearchChanged() {
    //when the search is changed we want to updates the searchresults list based on what's in the query
    searchResultsList();
  }

  @override
  initState() {
    super.initState();
    classTextController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    classSearchController.removeListener(_onSearchChanged);
    classSearchController.dispose();
    super.dispose();
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
                      controller: classTextController,
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  controller: classViewScrollController,
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.fromLTRB(100.0, 25.0, 100.0, 0.0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400.0,
                    mainAxisExtent: max(constraints.maxHeight / 3, 250.0),
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot doc =
                        searchResults[index]; //this contains the searchResults
                    final className = doc["class_name"];
                    final professorName = doc["professor_name"];
                    final classUid = doc["class_uid"];

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
            ),
          ),
        ],
      ),
    );
  }
}
