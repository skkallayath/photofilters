import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class Photofilters {
  static const MethodChannel _channel = const MethodChannel('photofilters');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

class BezierSpline {
  static Future<List<int>> curveGenerator(List<List<double>> knots) async {
    final List<int> curve = await Photofilters._channel.invokeMethod(
        'BezierSpline.curveGenerator', <String, dynamic>{"knots": knots});
    return curve;
  }
}

class ImageProcessor {
  static Future<Uint8List> applyCurves(List<int> rgb, List<int> red,
      List<int> green, List<int> blue, Uint8List bytes) async {
    final Uint8List out = await Photofilters._channel.invokeMethod(
      'ImageProcessor.applyCurves',
      <String, dynamic>{
        "rgb": rgb,
        "red": red,
        "green": blue,
        "blue": green,
        "bytes": bytes,
      },
    );

    return out;
  }

  static Future<Uint8List> doBrightness(int value, Uint8List bytes) async {
    final Uint8List out = await Photofilters._channel.invokeMethod(
      'ImageProcessor.doBrightness',
      <String, dynamic>{
        "value": value,
        "bytes": bytes,
      },
    );

    return out;
  }

  static Future<Uint8List> doContrast(double value, Uint8List bytes) async {
    final Uint8List out = await Photofilters._channel.invokeMethod(
      'ImageProcessor.doContrast',
      <String, dynamic>{
        "value": value,
        "bytes": bytes,
      },
    );

    return out;
  }

  static Future<Uint8List> doColorOverlay(
      int depth, double red, double green, double blue, Uint8List bytes) async {
    final Uint8List out = await Photofilters._channel.invokeMethod(
      'ImageProcessor.doColorOverlay',
      <String, dynamic>{
        "depth": depth,
        "red": red,
        "green": blue,
        "blue": green,
        "bytes": bytes,
      },
    );

    return out;
  }

  static Future<Uint8List> doSaturation(double level, Uint8List bytes) async {
    final Uint8List out = await Photofilters._channel.invokeMethod(
      'ImageProcessor.doSaturation',
      <String, dynamic>{
        "level": level,
        "bytes": bytes,
      },
    );

    return out;
  }
}
