import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppBarOptions extends StatelessWidget {
  const AppBarOptions({
    super.key,
  });

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['postnote68@gmail.com'],
      subject: '[PostNote Support Request]: Help Required',
      body: 'Hi PostNote Team, *insertMessage here*',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launchUrlString('$mailtoLink');
  }

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
                      title: const Text('Read user guide or email us:',
                          style: TextStyle(fontSize: 25)),
                      actions: [
                        TextButton(
                          onPressed: launchMailto,
                          child: const Text('postnote68@gmail.com',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 22)),
                        ),
                        TextButton(
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://docs.google.com/document/d/1fO4Fn-NJVvtoj7mL0FaDDEi826xHD96FDZ2r644GdT8/edit');

                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: const Text('User Guide',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 22)),
                        ),
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
