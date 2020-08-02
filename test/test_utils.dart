import 'dart:io';

import 'package:image/image.dart';
import 'package:photofilters/filters/filters.dart';

void applyFilterOnFile(Filter filter, String src, String dest) {
  Image image = decodeImage(File(src).readAsBytesSync());
  var pixels = image.getBytes();
  filter.apply(pixels, image.width, image.height);
  Image out = Image.fromBytes(image.width, image.height, pixels);
  new File(dest).writeAsBytesSync(encodeNamedImage(out, dest));
}
