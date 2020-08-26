import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
// ignore: library_prefixes
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;
  final picker = ImagePicker();

  Future getImage(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    var imagefile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: Text('Photo Filter Example'),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    print(imagefile);
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
      });
      print(imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Filter Example'),
      ),
      body: Center(
        child: Container(
          child: imageFile == null
              ? Center(
                  child: Text('No image selected.'),
                )
              : Image.file(imageFile),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
