import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_note/palette.dart';

class UploadPage extends StatefulWidget {
  final int weekNumber;
  final String className;

  const UploadPage(
      {super.key, required this.className, required this.weekNumber});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  // set default state for variables
  String? filePath;
  bool isLoading = false;
  bool fileUploaded = false;
  PlatformFile? _file;
  bool isImage = false;

  // call when the user wants to upload another file
  // after having just uploaded one
  Future<void> resetState() async {
    setState(() {
      filePath = null;
      isLoading = true;
      fileUploaded = false;
      _file = null;
      isImage = false;
    });
  }

  // function to pick the file
  Future<void> pickFile() async {
    try {
      // reset the state when picking another file
      await resetState();

      // the file that the user picked
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      // if the user does not pick anything
      if (result == null) return;

      // get the file name and extension
      // check the extension
      PlatformFile file = result.files.first;
      // if the file is an image, can display preview
      if (file.extension == 'jpg' ||
          file.extension == 'jpeg' ||
          file.extension == 'png') {
        setState(() {
          isImage = true;
        });
        // else the file is not an image, so unable to display preview
      } else {
        setState(() {
          isImage = false;
        });
      }

      // wait a couple seconds for the file to be uploaded
      await Future.delayed(const Duration(seconds: 2));

      // the file is getting uploaded
      setState(() {
        isLoading = false;
        _file = file;
        fileUploaded = true;
      });

      // waiting until the file actually is uploaded
      await _uploadFileToFirebase(file);
    } catch (e) {
      // in case an issue arises
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // function that uploads the file under the correct folders in Firebase
  Future<void> _uploadFileToFirebase(PlatformFile file) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('${widget.className}/Week${widget.weekNumber}/${file.name}');
      await storageRef.putData(file.bytes!);

      String downloadUrl = await storageRef.getDownloadURL();

      debugPrint("File uploaded successfully. Download URL: $downloadUrl");
    } catch (e) {
      debugPrint("Error uploading file: $e");
    }
  }

  // function that will tell the user that the file was successfully uploaded
  void _checkFileUpload(BuildContext context) {
    if (fileUploaded) {
      // a pop up that will tell the user that the upload was a success
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('File Uploaded!', style: TextStyle(fontSize: 25)),
            content: Text('Name of Uploaded File: ${_file!.name}',
                style: const TextStyle(fontSize: 22)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK',
                    style: TextStyle(color: Colors.black, fontSize: 22)),
              ),
            ],
          );
        },
      );
    } else {
      debugPrint('File was not uploaded yet.');
    }
  }

  // build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          title: Text(
            'File Upload for ${widget.className} - Week ${widget.weekNumber}',
            style: const TextStyle(fontSize: 35),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 150),
                // if button to upload has been clicked, show progress indicator
                isLoading
                    ? const CircularProgressIndicator()
                    // else allow the user to click to upload a file
                    : ElevatedButton(
                        onPressed: pickFile, // have the user pick the file
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(350, 90),
                        ),
                        child: const Text('Select a file to upload',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30))),
                // if a file was actually picked
                if (_file != null)
                  Column(
                    children: [
                      // if the uploaded file is an image, display preview
                      if (isImage)
                        Image.memory(Uint8List.fromList(_file!.bytes!),
                            width: 600, height: 600),
                      const SizedBox(height: 10),
                    ],
                  ),
                // if the file got successfully uploaded, let the user know
                if (fileUploaded)
                  Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => _checkFileUpload(context),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(350, 90),
                            backgroundColor: Palette.fernGreen),
                        child: const Text(
                          'Upload Success!',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
