import 'package:photofilters/filters/image_filters.dart';
import 'package:photofilters/filters/subfilters.dart';
import 'package:photofilters/utils/convolution_kernels.dart';

var presetConvolutionFiltersList = [
  new ImageFilter(name: "Identity")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(identityKernel)),
  new ImageFilter(name: "Sharpen")
    ..subFilters.add(new ConvoultionSubFilter.fromKernel(sharpenKernel)),
  new ImageFilter(name: "Emboss")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(embossKernel)),
  new ImageFilter(name: "Colored Edge Detection")
    ..subFilters
        .add(ConvoultionSubFilter.fromKernel(coloredEdgeDetectionKernel)),
  new ImageFilter(name: "Edge Detection Medium")
    ..subFilters
        .add(ConvoultionSubFilter.fromKernel(edgeDetectionMediumKernel)),
  new ImageFilter(name: "Edge Detection Hard")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(edgeDetectionHardKernel)),
  new ImageFilter(name: "Blur")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(blurKernel)),
  new ImageFilter(name: "Gaussian 3x3")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(gaussian3x3Kernel)),
  new ImageFilter(name: "Gaussian 5x5")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(gaussian5x5Kernel)),
  new ImageFilter(name: "Gaussian 7x7")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(gaussian7x7Kernel)),
  new ImageFilter(name: "Mean 3x3")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(mean3x3Kernel)),
  new ImageFilter(name: "Mean 5x5")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(mean5x5Kernel)),
  new ImageFilter(name: "Low Pass 3x3")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(lowPass3x3Kernel)),
  new ImageFilter(name: "Low Pass 5x5")
    ..subFilters.add(ConvoultionSubFilter.fromKernel(lowPass5x5Kernel)),
];
