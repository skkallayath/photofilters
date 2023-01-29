import 'dart:io';

import 'package:image/image.dart';
import 'package:photofilters/filters/filters.dart';

void applyFilterOnFile(Filter filter, String src, String dest) {
  final Image image = decodeImage(File(src).readAsBytesSync())!;
  final pixels = image.getBytes();
  filter.apply(pixels, image.width, image.height);
  final Image out = Image.fromBytes(width: image.width, height: image.height, bytes: pixels.buffer);
  File(dest).writeAsBytesSync(encodeNamedImage(dest, out)!);
}
