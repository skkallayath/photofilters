import 'package:flutter_test/flutter_test.dart';
import 'package:photofilters/filters/image_filters.dart';
import 'package:photofilters/filters/subfilters.dart';
import 'package:photofilters/utils/convolution_kernels.dart';

import 'test_utils.dart';

void main() {
  test("Custom filter", () {
    var customFilter = new ImageFilter(name: "Custom");
    customFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      coloredEdgeDetectionKernel,
    ));
    customFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      gaussian7x7Kernel,
    ));
    customFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      sharpenKernel,
    ));
    customFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      highPass3x3Kernel,
    ));
    customFilter.subFilters.add(ConvolutionSubFilter.fromKernel(
      lowPass3x3Kernel,
    ));
    customFilter.subFilters.add(SaturationSubFilter(0.5));
    applyFilterOnFile(customFilter, "res/bird.jpg", "out/custom.jpg");
  });
}
