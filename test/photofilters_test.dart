import 'dart:io';

import 'package:image/image.dart';
import 'package:test/test.dart';

import 'package:photofilters/photofilters.dart';

void main() {
  test("test ClarendonFilter", () {
    Image image = decodeImage(File('test/res/a.png').readAsBytesSync());
    var pixels = image.getBytes();
    ClarendonFilter filter = new ClarendonFilter();
    filter.apply(pixels);
    Image out = Image.fromBytes(image.width, image.height, pixels);
    // Image out =brightness(image, 110);
    new File('test/out/Clarendon.jpg').writeAsBytesSync(encodeJpg(out));
  });
}
