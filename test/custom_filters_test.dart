import 'package:flutter_test/flutter_test.dart';
import 'package:photofilters/filters/color_filters.dart';
import 'package:photofilters/filters/image_filters.dart';
import 'package:photofilters/filters/subfilters.dart';
import 'package:photofilters/utils/convolution_kernels.dart';

import 'test_utils.dart';

void main() {
  test("Custom Image filter", () {
    var customFilter = new ImageFilter(name: "Custom Image Filter");
    customFilter.addSubFilter(ConvolutionSubFilter.fromKernel(
      coloredEdgeDetectionKernel,
    ));
    customFilter.addSubFilters([
      ConvolutionSubFilter.fromKernel(
        guassian7x7Kernel,
      ),
      ConvolutionSubFilter.fromKernel(
        sharpenKernel,
      ),
      ConvolutionSubFilter.fromKernel(
        highPass3x3Kernel,
      )
    ]);
    customFilter.addSubFilter(ConvolutionSubFilter.fromKernel(
      lowPass3x3Kernel,
    ));
    customFilter.addSubFilter(SaturationSubFilter(0.5));
    applyFilterOnFile(customFilter, "res/bird.jpg", "out/custom_image.jpg");
  });

  test("Custom Color filter", () {
    var customFilter = new ColorFilter(name: "Custom Color Filter");
    customFilter.addSubFilter(SaturationSubFilter(0.5));
    customFilter
        .addSubFilters([BrightnessSubFilter(0.5), HueRotationSubFilter(30)]);
    applyFilterOnFile(customFilter, "res/bird.jpg", "out/custom_color.jpg");
  });
}
