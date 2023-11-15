import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Uint8List? _fileBytes;
  String path = 'cse101/section1/'; // will change with custom path here
  bool _fileUploaded = false;

  Future<void> _pickAndUploadFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt'],
      );

      if (result != null) {
        setState(() {
          _fileBytes = result.files.single.bytes;
        });

        await _uploadFileToFirebase(result.files.single.name);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File uploaded successfully!'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> _uploadFileToFirebase(String fileName) async {
    if (_fileBytes == null) {
      print("No file selected");
      return;
    }

    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('$path$fileName');

      await storageRef.putData(_fileBytes!);

      String downloadUrl = await storageRef.getDownloadURL();

      print("File uploaded successfully. Download URL: $downloadUrl");
      setState(() {
        _fileUploaded = true;
      });
    } catch (e) {
      print("Error uploading file: $e");
    } finally {
      setState(() {
        _fileBytes = null;
      });
    }
  }

  void _checkFileUpload(BuildContext context) {
    if (_fileUploaded) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('File Uploaded'),
            content: Text('The file was uploaded successfully!'),
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
        title: const Text('File Upload to Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _pickAndUploadFile(context),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Palette.fernGreen),
              child: const Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            if (_fileUploaded)
              ElevatedButton(
                onPressed: () => _checkFileUpload(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.fernGreen),
                child: const Text(
                  'Upload success!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
