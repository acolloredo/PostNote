import 'package:flutter/material.dart';
import 'package:post_note/appbar_options.dart';
import 'package:post_note/palette.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_note/upload_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class WeekFolder extends StatefulWidget {
  final int weekNumber;
  final String className;
  final String professorName;

  const WeekFolder({
    super.key,
    required this.weekNumber,
    required this.className,
    required this.professorName,
  });

  @override
  _WeekFolderState createState() => _WeekFolderState();
}

class _WeekFolderState extends State<WeekFolder> {
  // list of string URLs
  List<String> downloadUrls = [];
  // used to the let user know the last time the download links were reloaded
  DateTime lastReloadTimestamp = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getDownloadUrls();
  }

  // function to retreive the download URLs from Firebase
  Future<void> _getDownloadUrls() async {
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('${widget.className}/Week${widget.weekNumber}/');

      final ListResult result = await storageRef.listAll();

      final List<String> urls = [];
      for (final Reference ref in result.items) {
        final String url = await ref.getDownloadURL();
        urls.add(url);
      }

      setState(() {
        // populate the URL list with the Firebase URLs
        downloadUrls = urls;
        // set the reload time stamp to right now
        lastReloadTimestamp = DateTime.now();
      });
    } catch (e) {
      print("Error getting download URLs: $e");
    }
  }

  // put the timestamp in the hour:minute:second format
  String _formatTimestamp(DateTime timestamp) {
    final DateFormat formatter = DateFormat();
    return formatter.format(DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [AppBarOptions()],
        toolbarHeight: 75,
        title: Text(
          widget.className,
          style: const TextStyle(fontSize: 35),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(75.0, 0.0, 75.0, 16.0),
          child: Column(
            children: <Widget>[
              // Top ClipRRect for "Week #"
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 75.0,
                  margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  decoration: const BoxDecoration(
                    color: Palette.outerSpace,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      'Week ${widget.weekNumber}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom ClipRRect for all of the download linked buttons
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  decoration: const BoxDecoration(
                    color: Palette.outerSpace,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      // for every URL, make a button that when clicked,
                      // will allow you to download using the Firebase URL
                      for (String url in downloadUrls)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => _openURLInWebView(url),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.mint,
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(double.infinity, 80),
                            ),
                            child: FutureBuilder(
                              // call function to get *only* the file name
                              // from the file's download URL
                              future: _getFileName(url),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final fileName = snapshot.data.toString();
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fileName,
                                        style: const TextStyle(
                                            color: Palette.mintCream,
                                            fontSize: 20,
                                            decoration: TextDecoration.underline,
                                            decorationColor: Palette.mintCream),
                                      ),
                                    ],
                                  );
                                } else {
                                  // in case it takes a bit to get file name
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          color: Palette.fernGreen,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            _getDownloadUrls();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Reload',
                                style: TextStyle(fontSize: 18, color: Palette.mintCream),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.cached,
                                color: Palette.mintCream,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // display the last time the page was reloaded to the user
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Last Reloaded: ${_formatTimestamp(lastReloadTimestamp)}',
                          style: const TextStyle(
                            color: Palette.mintCream,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // if the user wants to upload a file, go to the upload page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPage(
                className: widget.className,
                weekNumber: widget.weekNumber,
              ),
            ),
          );
        },
        backgroundColor: Palette.fernGreen,
        child: const Icon(Icons.upload_file),
      ),
    );
  }

  // launch the file's Firebase URL to start the download
  Future<void> _openURLInWebView(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  // extract the file's name from the Firebase URL
  Future<String> _getFileName(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      final List<String> pathSegments = uri.pathSegments;

      // classname/week#/filename
      if (pathSegments.length >= 2) {
        final String fileNameWithExt = pathSegments.last;
        final List<String> fileNameParts = fileNameWithExt.split('/');
        return fileNameParts.isNotEmpty ? fileNameParts.last : "Unknown File";
      } else {
        return "Unknown File";
      }
    } catch (e) {
      debugPrint("Error extracting filename: $e");
      return "Unknown File";
    }
  }
}
