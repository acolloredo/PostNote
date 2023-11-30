import "package:post_note/home_page.dart";
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'class_view.dart';
import 'search_bar.dart';

import 'package:flutter/material.dart';

// Import your SearchBarAnchor class and other dependencies here

class searchFiltering extends StatefulWidget {
  @override
  _searchFiltering createState() => _searchFiltering();
}

class _searchFiltering extends State<searchFiltering> {
  late SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  // using the stream builder in the app search bar
  // so if someone types in something in search bar it does through the stream builder

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search For A Class Here'),
      ),
      body: Column(
        children: [
          SearchBarAnchor(myController: _searchController),
        ],
      ),
    );
  }
}
