import 'package:photofilters/filters/image_filters.dart';
import 'package:photofilters/filters/subfilters.dart';
import 'package:photofilters/utils/convolution_kernels.dart';

var presetConvolutionFiltersList = [
  new ImageFilter(name: "Identity")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(identityKernel)),
  new ImageFilter(name: "Sharpen")
    ..subFilters.add(new ConvolutionSubFilter.fromKernel(sharpenKernel)),
  new ImageFilter(name: "Emboss")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(embossKernel)),
  new ImageFilter(name: "Colored Edge Detection")
    ..subFilters
        .add(ConvolutionSubFilter.fromKernel(coloredEdgeDetectionKernel)),
  new ImageFilter(name: "Edge Detection Medium")
    ..subFilters
        .add(ConvolutionSubFilter.fromKernel(edgeDetectionMediumKernel)),
  new ImageFilter(name: "Edge Detection Hard")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(edgeDetectionHardKernel)),
  new ImageFilter(name: "Blur")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(blurKernel)),
  new ImageFilter(name: "Gaussian 3x3")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(gaussian3x3Kernel)),
  new ImageFilter(name: "Gaussian 5x5")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(gaussian5x5Kernel)),
  new ImageFilter(name: "Gaussian 7x7")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(gaussian7x7Kernel)),
  new ImageFilter(name: "Mean 3x3")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(mean3x3Kernel)),
  new ImageFilter(name: "Mean 5x5")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(mean5x5Kernel)),
  new ImageFilter(name: "Low Pass 3x3")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(lowPass3x3Kernel)),
  new ImageFilter(name: "Low Pass 5x5")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(lowPass5x5Kernel)),
  new ImageFilter(name: "High Pass 3x3")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(highPass3x3Kernel)),
];
