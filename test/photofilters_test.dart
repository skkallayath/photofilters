import 'dart:io';

import 'package:image/image.dart';
import 'package:test/test.dart';

import 'package:photofilters/photofilters.dart';

void main() {
  test("test BrightnessSubFilter", () {
    Image image = decodeImage(File('test/res/a.png').readAsBytesSync());
    var pixels = image.getBytes();
    BrightnessSubFilter filter = new BrightnessSubFilter(1.10);
    filter.apply(pixels);
    Image out = Image.fromBytes(image.width, image.height, pixels);
    new File('test/out/Brightness.jpg').writeAsBytesSync(encodeJpg(out));
  });
}
