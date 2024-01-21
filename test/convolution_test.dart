import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photofilters/photofilters.dart';

import 'test_utils.dart';

void main() {
  test("test Convolution", () {
    for (var filter in presetConvolutionFiltersList) {
      debugPrint('Applying ${filter.name}');
      applyFilterOnFile(
          filter, 'res/bird.jpg', 'out/convolution/${filter.name}.jpg');
    }
  });
}
