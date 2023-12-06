import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class AppBarOptions extends StatelessWidget {
  const AppBarOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('About PostNote:',
                          style: TextStyle(fontSize: 25)),
                      content: Text(
                          'A centralized hub where students can easily share, manage, and view notes!',
                          style: const TextStyle(fontSize: 22)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('About'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextButton(
              onPressed: () {
                debugPrint("Help appbar button pushed");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Please email:',
                          style: TextStyle(fontSize: 25)),
                      content: Text('postnote@gmail.com',
                          style: const TextStyle(fontSize: 22)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                        ),
                      ],
                    );
                  },
                );
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
