import 'package:flutter/material.dart';
import 'package:photofilters/photofilters.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('PhotoFilter example app'),
        ),
        body: new Center(
          child: new Text('Yet to implement'),
        ),
      ),
    );
  }
}
