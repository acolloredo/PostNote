import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/class_view.dart';
import 'package:post_note/palette.dart';

class HomePage extends StatefulWidget {
  final Widget bodyContent;

  const HomePage({super.key, required this.bodyContent});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'PostNote';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchController myController = SearchController();

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
                child: ModalRoute.of(context)?.settings.name != '/class-search'
                    ? null
                    : SearchAnchor(
                        searchController: myController,
                        viewLeading: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Palette.outerSpace,
                            onPressed: () {
                              // TODO: pass value?
                              myController.closeView(null);
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
                                myController.clear();
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
                            onTap: () => controller.openView(),
                            elevation: const MaterialStatePropertyAll(0.0),
                            surfaceTintColor: const MaterialStatePropertyAll(Palette.fernGreen),
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
                    controller.isOpen ? controller.close() : controller.open();
                  },
                  icon: const Icon(Icons.more_vert_sharp),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ModalRoute.of(context)?.settings.name != '/enrolled-classes'
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/class-search');
              },
              tooltip: 'Add a class',
              child: const Icon(Icons.add),
            ),
      body: widget.bodyContent,
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
