class ConvolutionKernel extends Object {
  final List<num> convolution;
  final double bias;

  ConvolutionKernel(this.convolution, {this.bias = 0.0});
}

ConvolutionKernel identityKernel =
    ConvolutionKernel([0, 0, 0, 0, 1, 0, 0, 0, 0]);
ConvolutionKernel sharpenKernel =
    ConvolutionKernel([-1, -1, -1, -1, 9, -1, -1, -1, -1]);
ConvolutionKernel embossKernel =
    ConvolutionKernel([-1, -1, 0, -1, 0, 1, 0, 1, 1], bias: 128);
ConvolutionKernel coloredEdgeDetectionKernel =
    ConvolutionKernel([1, 1, 1, 1, -7, 1, 1, 1, 1]);
ConvolutionKernel edgeDetectionMediumKernel =
    ConvolutionKernel([0, 1, 0, 1, -4, 1, 0, 1, 0]);
ConvolutionKernel edgeDetectionHardKernel =
    ConvolutionKernel([-1, -1, -1, -1, 8, -1, -1, -1, -1]);

ConvolutionKernel blurKernel = ConvolutionKernel([
  0,
  0,
  1,
  0,
  0,
  0,
  1,
  1,
  1,
  0,
  1,
  1,
  1,
  1,
  1,
  0,
  1,
  1,
  1,
  0,
  0,
  0,
  1,
  0,
  0
]);

ConvolutionKernel guassian3x3Kernel = ConvolutionKernel([
  1,
  2,
  1,
  2,
  4,
  2,
  1,
  2,
  1,
]);

ConvolutionKernel guassian5x5Kernel = ConvolutionKernel([
  2,
  04,
  05,
  04,
  2,
  4,
  09,
  12,
  09,
  4,
  5,
  12,
  15,
  12,
  5,
  4,
  09,
  12,
  09,
  4,
  2,
  04,
  05,
  04,
  2
]);

ConvolutionKernel guassian7x7Kernel = ConvolutionKernel([
  1,
  1,
  2,
  2,
  2,
  1,
  1,
  1,
  2,
  2,
  4,
  2,
  2,
  1,
  2,
  2,
  4,
  8,
  4,
  2,
  2,
  2,
  4,
  8,
  16,
  8,
  4,
  2,
  2,
  2,
  4,
  8,
  4,
  2,
  2,
  1,
  2,
  2,
  4,
  2,
  2,
  1,
  1,
  1,
  2,
  2,
  2,
  1,
  1,
]);

ConvolutionKernel mean3x3Kernel = ConvolutionKernel([
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
]);

ConvolutionKernel mean5x5Kernel = ConvolutionKernel([
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1
]);

ConvolutionKernel lowPass3x3Kernel = ConvolutionKernel([
  1,
  2,
  1,
  2,
  4,
  2,
  1,
  2,
  1,
]);

ConvolutionKernel lowPass5x5Kernel = ConvolutionKernel([
  1,
  1,
  1,
  1,
  1,
  1,
  4,
  4,
  4,
  1,
  1,
  4,
  12,
  4,
  1,
  1,
  4,
  4,
  4,
  1,
  1,
  1,
  1,
  1,
  1,
]);

ConvolutionKernel highPass3x3Kernel =
    ConvolutionKernel([0, -0.25, 0, -0.25, 2, -0.25, 0, -0.25, 0]);
