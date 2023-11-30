import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/class_view.dart';
import 'package:post_note/palette.dart';
import 'search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = 'PostNote';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchController myController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalRoute.of(context)?.settings.name != '/home'
          ? null
          : AppBar(
              // TODO: add elevation?
              toolbarHeight: 75.0,
              title: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SearchBarAnchor(myController: myController),
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
                    // tooltipMessage: 'Home',
                    onTap: () {
                      classViewScrollController.animateTo(
                        classViewScrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    child: SvgPicture.asset(
                      'svgs/Post-Note-Logo-Filled.svg',
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MenuAnchor(
                    style: MenuStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(8.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(Palette.mint),
                      elevation: MaterialStateProperty.all(10.0),
                    ),
                    alignmentOffset: const Offset(-35.0, 0.0),
                    menuChildren: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextButton(
                          onPressed: () {
                            debugPrint("I am signing out");
                            FirebaseAuth.instance.signOut();
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextButton(
                          onPressed: () {
                            debugPrint("About appbar button pushed");
                          },
                          child: const Text('About'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextButton(
                          onPressed: () {
                            debugPrint("Help appbar button pushed");
                          },
                          child: const Text('Help'),
                        ),
                      ),
                    ],
                    builder: (context, controller, child) {
                      return NavBarButton(
                        tooltipMessage: 'More',
                        onPressed: () {
                          controller.isOpen
                              ? controller.close()
                              : controller.open();
                        },
                        icon: const Icon(Icons.more_vert_sharp),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: ModalRoute.of(context)?.settings.name != '/home'
          ? null
          : FloatingActionButton(
              onPressed: () {
                debugPrint("$widget FAB pressed");
              },
              tooltip: 'Add Notes',
              child: const Icon(Icons.upload_file_outlined),
            ),
      body: const ClassView(),
    );
  }
}

class NavBarButton extends IconButton {
  final String tooltipMessage;

  const NavBarButton({
    super.key,
    required this.tooltipMessage,
    required super.onPressed,
    required super.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: super.build(context),
    );
  }
}
