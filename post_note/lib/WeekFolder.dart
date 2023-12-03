import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_note/upload_page.dart';
import 'package:url_launcher/url_launcher.dart';

class WeekFolder extends StatefulWidget {
  final int weekNumber;
  final String className;

  const WeekFolder({
    Key? key,
    required this.weekNumber,
    required this.className,
  }) : super(key: key);

  @override
  _WeekFolderState createState() => _WeekFolderState();
}

class _WeekFolderState extends State<WeekFolder> {
  List<String> downloadUrls = [];
  DateTime lastReloadTimestamp = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getDownloadUrls();
  }

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
        downloadUrls = urls;
        lastReloadTimestamp = DateTime.now();
      });
    } catch (e) {
      print("Error getting download URLs: $e");
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.hour}:${timestamp.minute}:${timestamp.second}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          widget.className,
          style: TextStyle(fontSize: 55),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top ClipRRect
            ClipRRect(
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

            // Bottom ClipRRect
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
                    for (String url in downloadUrls)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _openURLInWebView(url),
                          style: ElevatedButton.styleFrom(
                            primary: Palette.mint,
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(double.infinity, 80),
                          ),
                          child: FutureBuilder(
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
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ),
                    Container(
                      width: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          _getDownloadUrls();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Palette.outerSpace,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reload',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(width: 5),
                            if (DateTime.now()
                                    .difference(lastReloadTimestamp)
                                    .inSeconds <=
                                5)
                              Icon(
                                Icons.cached,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                    ),
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

  Future<void> _openURLInWebView(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

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
