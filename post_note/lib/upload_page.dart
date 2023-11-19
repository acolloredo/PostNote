import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_note/palette.dart';

class UploadPage extends StatefulWidget {
  final String className; // Add className parameter
  final int weekNumber;

  UploadPage({required this.className, required this.weekNumber});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? filePath;
  bool isLoading = false;
  bool fileUploaded = false;

  PlatformFile? _file;
  bool isImage = false;

  Future<void> resetState() async {
    setState(() {
      filePath = null;
      isLoading = true;
      fileUploaded = false;
      _file = null;
      isImage = false;
    });
  }

  Future<void> pickFile() async {
    try {
      // Reset the state when picking another file
      await resetState();

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      // If the user does not pick anything
      if (result == null) return;

      PlatformFile file = result.files.first;
      if (file.extension == 'jpg' ||
          file.extension == 'jpeg' ||
          file.extension == 'png') {
        setState(() {
          isImage = true;
        });
      } else {
        setState(() {
          isImage = false;
        });
      }

      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isLoading = false;
        _file = file;
        fileUploaded = true;
      });

      await _uploadFileToFirebase(file);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _uploadFileToFirebase(PlatformFile file) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('${widget.className}/Week${widget.weekNumber}/${file.name}');
      await storageRef.putData(file.bytes!);

      String downloadUrl = await storageRef.getDownloadURL();

      print("File uploaded successfully. Download URL: $downloadUrl");
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  void _checkFileUpload(BuildContext context) {
    if (fileUploaded) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('File Uploaded'),
            content: Text('Name of Uploaded File: ${_file!.name}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        },
      );
    } else {
      print('File was not uploaded yet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'File Upload Example for ${widget.className} - Week${widget.weekNumber}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: pickFile,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(350, 90),
                    ),
                    child: const Text('Select a file to upload',
                        style: TextStyle(color: Colors.white, fontSize: 30))),
            SizedBox(height: 20),
            if (_file != null)
              Column(
                children: [
                  if (isImage)
                    Image.memory(Uint8List.fromList(_file!.bytes!),
                        width: 300, height: 300),
                  SizedBox(height: 10),
                  //Text(
                  //  'Uploaded File Name: ${_file!.name}',
                  //  style: TextStyle(fontSize: 20),
                  //),
                ],
              ),
            SizedBox(height: 20),
            if (fileUploaded)
              Column(
                children: [
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
                ],
              ),
          ],
        ),
      ),
    );
  }
}
