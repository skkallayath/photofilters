import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'package:photofilters/utils/image_utils.dart' as utils;

/**
 * The [Filter] class to define a Filter consists of multiple [SubFilter]s
 */
class Filter extends Object {
  final String name;
  final List<SubFilter> subFilters;

  Filter({@required this.name})
      : assert(name != null),
        this.subFilters = [];

  /**
   * Apply the [Filter] to an Image.
   */
  void apply(Uint8List pixels) {
    for (SubFilter subFilter in subFilters) {
      subFilter.apply(pixels);
    }
  }
}

/**
 * The [SubFilter] class is the abstract class to define any SubFilter.
 */
abstract class SubFilter extends Object {
  /**
   * Apply the [SubFilter] to an Image.
   */
  void apply(Uint8List pixels);
}

/**
 * The [ContrastSubFilter] class is a SubFilter class to apply [contrast] to an image.
 */
class ContrastSubFilter implements SubFilter {
  final num contrast;
  ContrastSubFilter(this.contrast);

  /**
   * Apply the [ContrastSubFilter] to an Image.
   */
  @override
  void apply(Uint8List pixels) => utils.contrast(pixels, contrast);
}

/**
 * The [BrightnessSubFilter] class is a SubFilter class to apply [brightness] to an image.
 */
class BrightnessSubFilter implements SubFilter {
  final num brightness;
  BrightnessSubFilter(this.brightness);

  /**
   * Apply the [BrightnessSubFilter] to an Image.
   */
  @override
  void apply(Uint8List pixels) => utils.brightness(pixels, brightness);
}

/**
 * The [SaturationSubFilter] class is a SubFilter class to apply [saturation] to an image.
 */
class SaturationSubFilter implements SubFilter {
  final num saturation;
  SaturationSubFilter(this.saturation);

  /**
   * Apply the [SaturationSubFilter] to an Image.
   */
  @override
  void apply(Uint8List pixels) => utils.saturation(pixels, saturation);
}

/**
 * The [SepiaSubFilter] class is a SubFilter class to apply [sepia] to an image.
 */
class SepiaSubFilter implements SubFilter {
  final num sepia;
  SepiaSubFilter(this.sepia);

  /**
   * Apply the [SepiaSubFilter] to an Image.
   */
  @override
  void apply(Uint8List pixels) => utils.sepia(pixels, sepia);
}

/**
 * The [GrayScaleSubFilter] class is a SubFilter class to apply GrayScale to an image.
 */
class GrayScaleSubFilter implements SubFilter {
  // final num grayScale;
  // GrayScaleSubFilter(this.grayScale);

  /**
   * Apply the [GrayScaleSubFilter] to an Image.
   */
  @override
  void apply(Uint8List pixels) => utils.grayscale(pixels);
}

/**
 * The [InvertSubFilter] class is a SubFilter class to invert an image.
 */
class InvertSubFilter implements SubFilter {
  // final num invert;
  // InvertSubFilter(this.invert);

  /**
   * Apply the [InvertSubFilter] to an Image.
   */
  @override
  void apply(Uint8List pixels) => utils.invert(pixels);
}

/**
 * The [HueRotationSubFilter] class is a SubFilter class to rotate hue in [degrees].
 */
class HueRotationSubFilter implements SubFilter {
  final int degrees;
  HueRotationSubFilter(this.degrees);

  /**
   * Apply the [HueRotationSubFilter] to an Image.
   */
  @override
  void apply(Uint8List pixels) => utils.hueRotation(pixels, degrees);
}
