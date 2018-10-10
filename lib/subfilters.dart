import 'dart:typed_data';

import 'package:photofilters/filter.dart';
import 'package:photofilters/geometry.dart';
import 'package:photofilters/photofilters.dart';

class BrightnessSubFilter implements SubFilter {
  @override
  String tag = "";

  int brightness = 0;

  BrightnessSubFilter(this.brightness);

  @override
  Future<Uint8List> process(Uint8List inputImage) async {
    return ImageProcessor.doBrightness(brightness, inputImage);
  }

  void changeBrightness(int value) {
    this.brightness += value;
  }
}

class ColorOverlaySubFilter implements SubFilter {
  @override
  String tag = "";

  // the color overlay depth is between 0-255
  final int colorOverlayDepth;

  // these values are between 0-1
  final double colorOverlayRed;
  final double colorOverlayGreen;
  final double colorOverlayBlue;

  ColorOverlaySubFilter(this.colorOverlayDepth, this.colorOverlayRed,
      this.colorOverlayBlue, this.colorOverlayGreen);

  @override
  Future<Uint8List> process(Uint8List inputImage) async {
    return await ImageProcessor.doColorOverlay(colorOverlayDepth,
        colorOverlayRed, colorOverlayGreen, colorOverlayBlue, inputImage);
  }
}

class ContrastSubFilter implements SubFilter {
  @override
  String tag = "";

  // The value is in fraction, value 1 has no effect
  double contrast = 0;

  ContrastSubFilter(this.contrast) {
    this.contrast = contrast;
  }

  @override
  Future<Uint8List> process(Uint8List inputImage) async {
    return ImageProcessor.doContrast(contrast, inputImage);
  }

  void changeContrast(double value) {
    this.contrast += value;
  }
}

class SaturationSubFilter implements SubFilter {
  @override
  String tag = "";

  // The Level value is float, where level = 1 has no effect on the image
  double level;

  SaturationSubFilter(this.level) {
    this.level = level;
  }

  @override
  Future<Uint8List> process(Uint8List inputImage) async {
    return ImageProcessor.doSaturation(level, inputImage);
  }
}

class ToneCurveSubFilter implements SubFilter {
  @override
  String tag = "";

  // These are knots which contains the plot points
  List<Point> rgbKnots;
  List<Point> greenKnots;
  List<Point> redKnots;
  List<Point> blueKnots;
  List<int> rgb;
  List<int> r;
  List<int> g;
  List<int> b;
  ToneCurveSubFilter(List<Point> rgbKnots, List<Point> redKnots,
      List<Point> greenKnots, List<Point> blueKnots) {
    List<Point> straightKnots = new List<Point>(2);
    straightKnots[0] = new Point(0.0, 0.0);
    straightKnots[1] = new Point(255.0, 255.0);
    this.rgbKnots = rgbKnots ?? straightKnots;
    this.redKnots = redKnots ?? straightKnots;
    this.greenKnots = greenKnots ?? straightKnots;
    this.blueKnots = blueKnots ?? straightKnots;
  }

  @override
  Future<Uint8List> process(Uint8List inputImage) async {
    rgbKnots = sortPointsOnXAxis(rgbKnots);
    redKnots = sortPointsOnXAxis(redKnots);
    greenKnots = sortPointsOnXAxis(greenKnots);
    blueKnots = sortPointsOnXAxis(blueKnots);
    if (rgb == null) {
      rgb = await BezierSpline.curveGenerator(
          rgbKnots.map<List<double>>((p) => p.toList()).toList());
    }

    if (r == null) {
      r = await BezierSpline.curveGenerator(
          redKnots.map<List<double>>((p) => p.toList()).toList());
    }

    if (g == null) {
      g = await BezierSpline.curveGenerator(
          greenKnots.map<List<double>>((p) => p.toList()).toList());
    }

    if (b == null) {
      b = await BezierSpline.curveGenerator(
          blueKnots.map<List<double>>((p) => p.toList()).toList());
    }

    return ImageProcessor.applyCurves(rgb, r, g, b, inputImage);
  }

  List<Point> sortPointsOnXAxis(List<Point> points) {
    if (points == null) {
      return null;
    }
    for (int s = 1; s < points.length - 1; s++) {
      for (int k = 0; k <= points.length - 2; k++) {
        if (points[k].x > points[k + 1].x) {
          double temp = 0.0;
          temp = points[k].x;
          points[k].x = points[k + 1].x; //swapping values
          points[k + 1].x = temp;
        }
      }
    }
    return points;
  }
}
