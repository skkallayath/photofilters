import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Filter> filters = presetFiltersList;
  final picker = ImagePicker();
  File? imageFile;

  Future getImage(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      final File imageFile = File(pickedFile.path);
      final String fileName = basename(imageFile.path);
      var image = imageLib.decodeImage(await imageFile.readAsBytes())!;
      image = imageLib.copyResize(image, width: 600);
      Map imagefile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoFilterSelector(
            title: Text("Photo Filter Example"),
            image: image,
            filters: presetFiltersList,
            filename: fileName,
            loader: Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (imagefile.containsKey('image_filtered')) {
        setState(() {
          this.imageFile = imagefile['image_filtered'];
        });
        print(imageFile.path);
      }
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
              : Image.file(File(imageFile!.path)),
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
