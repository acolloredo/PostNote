import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class GradientSearchBar extends StatelessWidget {
  const GradientSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Palette.celadon,
            Palette.outerSpace,
            Palette.celadon,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Palette.outerSpace,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Palette.outerSpace,
          ),
        ),
      ),
    );
  }
}
