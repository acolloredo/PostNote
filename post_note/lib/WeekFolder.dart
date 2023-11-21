import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class WeekFolder extends StatelessWidget {
  final int weekNumber;

  const WeekFolder({
    Key? key,
    required this.weekNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: <Widget>[
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
                            fontSize: 40),
                      ),
                    ),
                  ),
                )),
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
                )),
          ],
        ),
      ),
    );
  }
}
