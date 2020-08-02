import 'package:photofilters/filters/image_filters.dart';
import 'package:photofilters/filters/subfilters.dart';
import 'package:photofilters/utils/convolution_kernels.dart';

var presetConvolutionFiltersList = [
  new ImageFilter(name: "Identity")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(identityKernel)),
  new ImageFilter(name: "Sharpen")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(sharpenKernel)),
  new ImageFilter(name: "Emboss")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(embossKernel)),
  new ImageFilter(name: "Colored Edge Detection")
    ..subFilters
        .add(ConvolutionSubFilter.fromKernel(coloredEdgeDetectionKernel)),
  new ImageFilter(name: "Edge Detection Medium")
    ..subFilters
        .add(ConvolutionSubFilter.fromKernel(edgeDetectionMediumKernel)),
  new ImageFilter(name: "Edge Detection Hard")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(edgeDetectionHardKernel)),
  new ImageFilter(name: "Blur")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(blurKernel)),
  new ImageFilter(name: "Guassian 3x3")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(guassian3x3Kernel)),
  new ImageFilter(name: "Guassian 5x5")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(guassian5x5Kernel)),
  new ImageFilter(name: "Guassian 7x7")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(guassian7x7Kernel)),
  new ImageFilter(name: "Mean 3x3")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(mean3x3Kernel)),
  new ImageFilter(name: "Mean 5x5")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(mean5x5Kernel)),
  new ImageFilter(name: "Low Pass 3x3")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(lowPass3x3Kernel)),
  new ImageFilter(name: "Low Pass 5x5")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(lowPass5x5Kernel)),
  new ImageFilter(name: "High Pass 3x3")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(highPass3x3Kernel)),
];
