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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          widget.className,
          style: TextStyle(fontSize: 55),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Bottom ClipRRect
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Palette.outerSpace,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (String url in downloadUrls)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () => _openURLInWebView(url),
                            style: TextButton.styleFrom(
                              backgroundColor: Palette.mint,
                            ),
                            child: FutureBuilder(
                              future: _getFileName(url),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _getDownloadUrls();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Reload',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
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
                      SizedBox(height: 5),
                      Text(
                        'Last Reloaded: ${_formatTimestamp(lastReloadTimestamp)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Top ClipRRect
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                alignment: Alignment.center,
                width: width,
                height: 75,
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Palette.outerSpace,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
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
          ),
        ],
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
      return uri.pathSegments.last;
    } catch (e) {
      print("Error extracting filename: $e");
      return "Unknown File";
    }
  }
}
