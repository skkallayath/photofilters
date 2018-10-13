import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

void main() => runApp(new MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  imageLib.Image _image;
  String fileName;
  Filter _filter;
  List<Filter> filters = presetFitersList;

  Future getImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    image = imageLib.copyResize(image, 600);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                _filter = filter;
              });
            },
          ),
          Expanded(
            child: new Center(
              child: _image == null
                  ? new Text('No image selected.')
                  : new PhotoFilter(
                      image: _image,
                      filter: _filter,
                      filename: fileName,
                      loader: Center(
                          child: Image.asset('assets/images/gifloader.gif')),
                    ),
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
