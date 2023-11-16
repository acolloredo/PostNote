import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class WeekFolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 100,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Palette.outerSpace,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text("Week X",
                textDirection: TextDirection.ltr,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
