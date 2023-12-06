import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_note/WeekFolder.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/appbar_options.dart';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

// add an unenroll button

class ClassPage extends StatelessWidget {
  final String className;
  final String classUid;
  final String professorName;

  const ClassPage({
    super.key,
    required this.className,
    required this.classUid,
    required this.professorName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: Center(
          child: Text(
            "$className with $professorName",
            style: const TextStyle(fontSize: 35),
          ),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Tooltip(
              message: "Unenroll",
              child: Material(
                color: Palette.teaGreen,
                child: InkWell(
                  onTap: () {
                    // TODO: add unenroll logic
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.rotate(
                      angle: pi, // 180
                      child: const Icon(
                        Icons.exit_to_app,
                        color: Palette.outerSpace,
                        size: 30.0,
                      ),
                    ),
                  ),
                  // iconSize: 30.0,
                  // tooltip: "Unenroll",
                  // color: Palette.outerSpace,
                  // onPressed: () {},
                ),
              ),
            ),
          ),
          const AppBarOptions(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 1.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClassPageSection(
                    title: "Weeks",
                    body: Container(),
                  ),
                ),
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 1.0,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: ClassPageSection(
                            title: "Class Study Groups",
                            body: Expanded(
                              child: StudyGroupListView(
                                classUid: classUid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: ClassPageSection(
                            title: "My Study Groups",
                            body: Container(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyGroupListView extends StatefulWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  final String classUid;

  StudyGroupListView({
    super.key,
    required this.classUid,
  });

  @override
  State<StudyGroupListView> createState() => _StudyGroupListViewState();
}

class _StudyGroupListViewState extends State<StudyGroupListView> {
  StreamController<QuerySnapshot<Object?>> studyGroupListViewStreamController = BehaviorSubject();

  // getStudyGroupsArray() async {
  //   return
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   studyGroupListViewStreamController.addStream(getStudyGroupsArray());
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: widget.firestoreInstance
              .collection("study_groups")
              // .where("class_uid", isEqualTo: widget.classUid)
              // .where('quarter', isEqualTo: "Fall23")
              .snapshots(),
          builder: (context, snapshot) => ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                  color: Palette.outerSpace,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Palette.mintCream,
                      ),
                      child: Builder(
                        builder: (context) {
                          List<dynamic> myList = snapshot.data?.docs[index].get("members") ?? "";
                          return Row(
                            children: [
                              Text("Study group #$index"),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  Text(myList.length.toString())
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}

class ClassPageSection extends StatelessWidget {
  final String title;
  final Widget body;
  const ClassPageSection({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.outerSpace,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Palette.teaGreen,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body,
            ],
          ),
        ),
      ),
    );
  }
}

// class _bodyREMOVETHIS extends StatelessWidget {
//   const _bodyREMOVETHIS({
//     super.key,
//     required this.className,
//   });

//   final String className;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
//       child: Center(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               // height: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 4.0),
//                 child: WeeksSection(className: className),
//               ),
//             ),
//             const Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 2.0),
//                   child: ClassStudyGroupsSection(),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 2.0),
//                   child: MyStudyGroupsSection(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WeeksSection extends StatelessWidget {
//   const WeeksSection({
//     super.key,
//     required this.className,
//   });

//   final String className;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Palette.outerSpace,
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Card(
//           color: Palette.teaGreen,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 65.0,
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 8.0),
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
//                       child: Text(
//                         "Class Study Groups",
//                         style: TextStyle(fontSize: 30),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
//                 child: SizedBox(
//                   child: LayoutBuilder(builder: (context, constraints) {
//                     return GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 5,
//                         mainAxisSpacing: 16.0,
//                         mainAxisExtent: constraints.maxHeight / 2.25,
//                       ),
//                       itemCount: 10,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Card(
//                           color: Palette.outerSpace,
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => WeekFolder(
//                                       weekNumber: index + 1,
//                                       className: className,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Card(
//                                 color: Palette.mintCream,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Week ${index + 1} Notes",
//                                       style: const TextStyle(fontSize: 20),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ClassStudyGroupsSection extends StatelessWidget {
//   const ClassStudyGroupsSection({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // width: double.infinity,
//       child: Card(
//         color: Palette.outerSpace,
//         child: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Card(
//             color: Palette.teaGreen,
//             child: Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
//                   child: Text(
//                     "Class Study Groups",
//                     style: TextStyle(fontSize: 30),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 ConstrainedBox(
//                   constraints: (const BoxConstraints(minHeight: 100)),
//                   child: ListView.builder(itemBuilder: (context, index) {
//                     return const ListTile();
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyStudyGroupsSection extends StatelessWidget {
//   const MyStudyGroupsSection({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       // width: double.infinity,
//       child: Card(
//         color: Palette.outerSpace,
//         child: Padding(
//           padding: EdgeInsets.all(4.0),
//           child: Card(
//             color: Palette.teaGreen,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
//                   child: Text(
//                     "My Study Groups",
//                     style: TextStyle(fontSize: 30),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
