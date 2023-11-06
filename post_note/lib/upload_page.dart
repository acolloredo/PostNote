import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? filePath;
  bool isLoading = false;

  PlatformFile? _imagePicked;
  Future<void> pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      // if user does not pick anything
      if (result == null) return;

      setState(() {
        isLoading = false;
        _imagePicked = result.files.first;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imagePicked != null)
              Image.memory(Uint8List.fromList(_imagePicked!.bytes!),
                  width: 300, height: 300),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: pickFile,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(350, 90), // width, height
                    ),
                    child: const Text('Select a file to upload',
                        style: TextStyle(color: Colors.white, fontSize: 30))),
          ],
        ),
      ),
    );
  }
}
