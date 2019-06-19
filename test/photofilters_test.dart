import 'dart:io';

import 'package:image/image.dart';
import 'package:test/test.dart';

import 'package:photofilters/photofilters.dart';

void applyFilter(Filter filter, String src, String dest) {
  Image image = decodeImage(File(src).readAsBytesSync());
  var pixels = image.getBytes();
  filter.apply(pixels);
  Image out = Image.fromBytes(image.width, image.height, pixels);
  new File(dest).writeAsBytesSync(encodeNamedImage(out, dest));
}

void main() {
  test("test All", () {
    for (var filter in presetFiltersList) {
      print('Applying ${filter.name}');
      applyFilter(filter, 'test/res/bird.jpg', 'test/out/${filter.name}.jpg');
    }
  });
}
