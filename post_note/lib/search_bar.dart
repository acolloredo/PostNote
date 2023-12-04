import 'package:flutter/material.dart';
import 'package:post_note/class_view.dart';
import 'package:post_note/palette.dart';
import 'search_bar.dart';

class SearchBarAnchor extends StatelessWidget {
  const SearchBarAnchor({
    Key? key, // Added Key? key parameter
    required this.myController,
    required this.classItems, // Added required classItems parameter
  }) : super(key: key); // Added super(key: key);

  final SearchController myController;
  final List<Map<String, dynamic>> classItems; // Adjusted the type

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
      suggestionsBuilder: (context, controller) {
        final searchQuery =
            (controller as dynamic).query?.toString()?.toLowerCase() ?? '';
        final filteredClasses = classItems.where((classItem) {
          final className = classItem["class_name"].toLowerCase();
          final professorName = classItem["professor_name"].toLowerCase();
          return className.contains(searchQuery) ||
              professorName.contains(searchQuery);
        }).toList();

        return filteredClasses.map((classItem) {
          return ListTile(
            title: Text(classItem["class_name"]),
            subtitle: Text(classItem["professor_name"]),
            onTap: () {
              //  navigate to the class details
            },
          );
        }).toList();
      },
    );
  }
}
