import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:image/image.dart' as imageLib;

class PhotoFilter extends StatelessWidget {
  final File imageFile;
  final Filter filter;
  final Widget loader;
  final BoxFit fit;

  PhotoFilter({
    @required this.imageFile,
    @required this.filter,
    this.loader,
    this.fit = BoxFit.fill,
  });

  List<int> applyFilter() {
    String _filename = basename(imageFile.path);
    imageLib.Image _image =
        imageLib.decodeNamedImage(imageFile.readAsBytesSync(), _filename);
    List<int> _bytes = _image.getBytes();
    filter.apply(_bytes);
    _image = imageLib.Image.fromBytes(_image.width, _image.height, _bytes);
    return imageLib.encodeNamedImage(_image, _filename);
  }

  @override
  Widget build(BuildContext context) {
    Widget _image;
    if (filter == null) {
      _image = Image.file(imageFile);
    } else {
      List<int> _bytes = applyFilter();
      _image = Image.memory(
        _bytes,
        fit: fit,
      );
    }
    return _image;
  }
}
