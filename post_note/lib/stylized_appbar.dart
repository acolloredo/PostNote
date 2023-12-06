import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/class_search.dart';
import 'package:post_note/appbar_options.dart';

class StyledAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  const StyledAppBar({super.key, this.height = 75});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<StyledAppBar> createState() => _StyledAppBarState();
}

class _StyledAppBarState extends State<StyledAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 75.0,
      title: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
            onTap: () {
              debugPrint(ModalRoute.of(context)?.settings.name);
              if (ModalRoute.of(context)?.settings.name == '/class-search') {
                Navigator.pop(context);
              } else {
                classViewScrollController.animateTo(
                  classViewScrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              }
            },
            child: SvgPicture.asset(
              'svgs/Post-Note-Logo-Filled.svg',
            ),
          ),
        ),
      ),
      actions: const [
        AppBarOptions(),
      ],
    );
  }
}
