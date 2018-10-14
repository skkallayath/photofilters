# Photo Filters package for flutter

A flutter package for iOS and Android for applying filter to an image. A set of preset filters are also available. You can create your own filters too.

## Installation

First, add `photofilters` and `image` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### iOS

No configuration required - the plugin should work out of the box.

### Android

No configuration required - the plugin should work out of the box.

### Example

``` dart
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
        title: new Text('Photo Filter Example'),
      ),
      body: new Container(
        alignment: Alignment(0.0, 0.0),
        child: _image == null
            ? new Text('No image selected.')
            : new PhotoFilterSelector(
                image: _image,
                filters: presetFitersList,
                filename: fileName,
                loader: Center(child: CircularProgressIndicator()),
              ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
```

## UI Screen Shots

![screenshot](https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/screenshot.gif)

## Sample Images of Filters

| | | |
|:-------------------------:|:-------------------------:|:-------------------------:|
| <img width="1604" alt="No Filter" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/No Filter.jpg">  No Filter | <img width="1604" alt="AddictiveBlue" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/AddictiveBlue.jpg">  AddictiveBlue | <img width="1604" alt="AddictiveRed" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/AddictiveRed.jpg">  AddictiveRed | <img width="1604" alt="Aden" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Aden.jpg">  Aden  | 
| <img width="1604" alt="Amaro" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Amaro.jpg">  Amaro | <img width="1604" alt="Ashby" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Ashby.jpg">  Ashby | <img width="1604" alt="Brannan" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Brannan.jpg">  Brannan | <img width="1604" alt="Brooklyn" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Brooklyn.jpg">  Brooklyn  | 
| <img width="1604" alt="Charmes" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Charmes.jpg">  Charmes | <img width="1604" alt="Clarendon" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Clarendon.jpg">  Clarendon | <img width="1604" alt="Crema" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Crema.jpg">  Crema | <img width="1604" alt="Dogpatch" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Dogpatch.jpg">  Dogpatch  | 
| <img width="1604" alt="Earlybird" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Earlybird.jpg">  Earlybird | <img width="1604" alt="1977" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/1977.jpg">  1977 | <img width="1604" alt="Gingham" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Gingham.jpg">  Gingham | <img width="1604" alt="Ginza" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Ginza.jpg">  Ginza  | 
| <img width="1604" alt="Hefe" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Hefe.jpg">  Hefe | <img width="1604" alt="Helena" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Helena.jpg">  Helena | <img width="1604" alt="Hudson" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Hudson.jpg">  Hudson | <img width="1604" alt="Inkwell" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Inkwell.jpg">  Inkwell  | 
| <img width="1604" alt="Juno" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Juno.jpg">  Juno | <img width="1604" alt="Kelvin" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Kelvin.jpg">  Kelvin | <img width="1604" alt="Lark" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Lark.jpg">  Lark | <img width="1604" alt="Lo-Fi" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Lo-Fi.jpg">  Lo-Fi  | 
| <img width="1604" alt="Ludwig" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Ludwig.jpg">  Ludwig | <img width="1604" alt="Maven" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Maven.jpg">  Maven | <img width="1604" alt="Mayfair" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Mayfair.jpg">  Mayfair | <img width="1604" alt="Moon" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Moon.jpg">  Moon  | 
| <img width="1604" alt="Nashville" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Nashville.jpg">  Nashville | <img width="1604" alt="Perpetua" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Perpetua.jpg">  Perpetua | <img width="1604" alt="Reyes" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Reyes.jpg">  Reyes | <img width="1604" alt="Rise" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Rise.jpg">  Rise  | 
| <img width="1604" alt="Sierra" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Sierra.jpg">  Sierra | <img width="1604" alt="Skyline" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Skyline.jpg">  Skyline | <img width="1604" alt="Slumber" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Slumber.jpg">  Slumber | <img width="1604" alt="Stinson" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Stinson.jpg">  Stinson  | 
| <img width="1604" alt="Sutro" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Sutro.jpg">  Sutro | <img width="1604" alt="Toaster" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Toaster.jpg">  Toaster | <img width="1604" alt="Valencia" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Valencia.jpg">  Valencia | <img width="1604" alt="Vesper" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Vesper.jpg">  Vesper  | 
| <img width="1604" alt="Walden" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Walden.jpg">  Walden | <img width="1604" alt="Willow" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/Willow.jpg">  Willow | <img width="1604" alt="X-Pro II" src="https://raw.githubusercontent.com/skkallayath/photofilters/master/exampleimages/X-Pro II.jpg">  X-Pro II  | |


## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
