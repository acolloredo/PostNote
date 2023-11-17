import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class WeekFolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
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
                      "Week X",
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
                    alignment: Alignment.center,
                    width: 1000,
                    height: 500,
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
    );
  }
}
