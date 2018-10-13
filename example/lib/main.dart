import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(new MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image;
  Filter _filter;
  List<Filter> filters = presetFitersList;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Render");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker Example'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new DropdownButton<Filter>(
            items: []
              ..add(new DropdownMenuItem<Filter>(
                value: null,
                child: new Text("Choose filter"),
              ))
              ..addAll(filters.map((Filter value) {
                return new DropdownMenuItem<Filter>(
                  value: value,
                  child: new Text(value.name),
                );
              }).toList()),
            onChanged: (filter) {
              setState(() {
                print("Changed filter");
                _filter = filter;
              });
            },
          ),
          Expanded(
            child: new Center(
              child: _image == null
                  ? new Text('No image selected.')
                  : new PhotoFilter(imageFile: _image, filter: _filter),
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
