import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/class_view.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/appbar_options.dart';

class SearchBarAnchor extends StatelessWidget {
  const SearchBarAnchor({
    Key? key,
    required this.myController,
    required this.classItems,
    required this.builder, // Add required builder parameter
  }) : super(key: key);

  final SearchController myController;
  final List<Map<String, dynamic>> classItems;
  final Widget Function(BuildContext context, SearchController controller)
      builder;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: myController,
      viewLeading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Palette.outerSpace,
          onPressed: () {
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
          elevation: MaterialStateProperty.all(0.0),
          surfaceTintColor: MaterialStateProperty.all(Palette.fernGreen),
        );
      },
      child:
          builder(context, myController), // Use the provided builder function
    );
  }
}
