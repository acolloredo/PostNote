import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_note/class_view.dart';
import 'package:post_note/palette.dart';
import 'package:post_note/appbar_options.dart';

class HomePage extends StatefulWidget {
  final Widget bodyContent;

  const HomePage({super.key, required this.bodyContent});

  final String title = 'PostNote';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchController myController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ModalRoute.of(context)?.settings.name != '/class-search'
                    ? null
                    : SearchAnchor(
                        searchController: myController,
                        viewLeading: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Palette.outerSpace,
                            onPressed: () {
                              // TODO: pass value?
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
                            elevation: const MaterialStatePropertyAll(0.0),
                            surfaceTintColor: const MaterialStatePropertyAll(
                                Palette.fernGreen),
                          );
                        },
                        suggestionsBuilder: (context, controller) {
                          return [];
                        },
                      ),
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
      ),
      floatingActionButton:
          ModalRoute.of(context)?.settings.name != '/enrolled-classes'
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/class-search');
                  },
                  tooltip: 'Add a class',
                  child: const Icon(Icons.add),
                ),
      body: widget.bodyContent,
    );
  }
}
