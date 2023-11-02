import 'package:flutter/material.dart';
import 'package:post_note/class_page.dart';
import 'package:post_note/upload_page.dart';
import 'package:post_note/palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NavBarButton(
            tooltipMessage: 'Home',
            onPressed: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
            icon: const Icon(
              Icons.home,
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
                backgroundColor: MaterialStateProperty.all(Palette.fernGreen),
                elevation: MaterialStateProperty.all(10.0),
              ),
              alignmentOffset: const Offset(-35.0, 0.0),
              menuChildren: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Logout'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('About'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Help'),
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
          )
        ],
      ),
      floatingActionButton: Wrap(children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: FloatingActionButton(
            heroTag: "button0",
            onPressed: () {
              debugPrint('');
            },
            tooltip: 'Add Notes',
            child: const Icon(Icons.upload_file_outlined),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: FloatingActionButton(
            heroTag: "button1",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClassPage()));
            },
            tooltip: 'Class Page',
            child: const Icon(Icons.class_),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: FloatingActionButton(
            heroTag: "button2",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UploadPage()));
            },
            tooltip: 'Upload Page',
            child: const Icon(Icons.note_add),
          ),
        ),
      ]),
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
