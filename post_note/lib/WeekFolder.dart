import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_note/upload_page.dart';
<<<<<<< HEAD
=======
import 'package:url_launcher/url_launcher.dart';
>>>>>>> 8aa1a3e9d3fae90c8350dc244688afcdab1f5efb

class WeekFolder extends StatefulWidget {
  final int weekNumber;
  final String className;

  const WeekFolder({
    super.key,
    required this.weekNumber,
    required this.className,
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
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('${widget.className}/Week${widget.weekNumber}/');

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
    return "${timestamp.hour}:${timestamp.minute}:${timestamp.second}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPage(
                className: "YourClassName",
                weekNumber: weekNumber,
              ),
            ),
          );
        },
        backgroundColor: Palette.fernGreen,
        child: const Text('Upload'),
      ),
      persistentFooterButtons: const <Widget>[
        // Place any additional persistent footer buttons here if needed
      ],
=======
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          widget.className,
          style: TextStyle(fontSize: 55),
        ),
      ),
>>>>>>> 8aa1a3e9d3fae90c8350dc244688afcdab1f5efb
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top ClipRRect for "Week #"
            ClipRRect(
<<<<<<< HEAD
              borderRadius: BorderRadius.circular(30.0),
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: width,
                    height: height,
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Palette.outerSpace,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),

            // Top ClipRRect
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Center(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 75,
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Palette.outerSpace,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Week $weekNumber',
=======
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                decoration: BoxDecoration(
                  color: Palette.outerSpace,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Week ${widget.weekNumber}',
>>>>>>> 8aa1a3e9d3fae90c8350dc244688afcdab1f5efb
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom ClipRRect for all of the download linked buttons
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                decoration: BoxDecoration(
                  color: Palette.outerSpace,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
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
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(double.infinity, 80),
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
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                // in case it takes a bit to get file name
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ),
                    Container(
                      // if the page has not been update in awhile, user can
                      // click the reload button that gets all the URLs
                      width: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          _getDownloadUrls();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.outerSpace,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reload',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.cached,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // display the last time the page was reloaded to the user
                    SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Last Reloaded: ${_formatTimestamp(lastReloadTimestamp)}',
                        style: TextStyle(
                          color: Colors.white,
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
        child: Text('Upload'),
        backgroundColor: Palette.fernGreen,
      ),
    );
  }

  // launch the file's Firebase URL to start the download
  Future<void> _openURLInWebView(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
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
      print("Error extracting filename: $e");
      return "Unknown File";
    }
  }
}
