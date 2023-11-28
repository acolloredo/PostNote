import 'package:flutter/material.dart';
import 'package:post_note/download_page.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/upload_page.dart';

import 'upload_page.dart';

class WeekFolder extends StatelessWidget {
  final int weekNumber;
  final String className;

  const WeekFolder({
    Key? key,
    required this.weekNumber,
    required this.className,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPage(
                className: "YourClassName",
                weekNumber: weekNumber,
              ),
            ),
          );
        },
        child: Text('Upload'),
        backgroundColor: Palette.fernGreen,
      ),
      persistentFooterButtons: <Widget>[
        // Place any additional persistent footer buttons here if needed
      ],
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // Bottom ClipRRect
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: width,
                    height: height,
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Palette.outerSpace,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),

            // Top ClipRRect
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Center(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 75,
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Palette.outerSpace,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Week ${weekNumber}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
