class ConvolutionKernel extends Object {
  final List<int> convolution;
  final double bias;

  ConvolutionKernel(this.convolution, {this.bias = 0.0});
}

ConvolutionKernel identityKernel =
    new ConvolutionKernel([0, 0, 0, 0, 1, 0, 0, 0, 0]);
ConvolutionKernel brightenKernel = ConvolutionKernel([10]);
ConvolutionKernel sharpenKernel =
    new ConvolutionKernel([-1, -1, -1, -1, 9, -1, -1, -1, -1]);
ConvolutionKernel embossKernel =
    new ConvolutionKernel([-1, -1, 0, -1, 0, 1, 0, 1, 1], bias: 128);
ConvolutionKernel coloredEdgeDetectionKernel =
    new ConvolutionKernel([1, 1, 1, 1, -7, 1, 1, 1, 1]);
ConvolutionKernel edgeDetectionMediumKernel =
    new ConvolutionKernel([0, 1, 0, 1, -4, 1, 0, 1, 0]);
ConvolutionKernel edgeDetectionHardKernel =
    new ConvolutionKernel([-1, -1, -1, -1, 8, -1, -1, -1, -1]);

ConvolutionKernel blurKernel = new ConvolutionKernel([
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
