import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:photofilters/photofilters.dart';
import 'test_utils.dart';

void main() {
  test("test All", () {
    for (var filter in presetFiltersList) {
      debugPrint('Applying ${filter.name}');
      applyFilterOnFile(filter, 'res/bird.jpg', 'out/${filter.name}.jpg');
    }
  });
}
