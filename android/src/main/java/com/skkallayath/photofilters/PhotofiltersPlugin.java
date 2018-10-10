package com.skkallayath.photofilters;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** PhotofiltersPlugin */
public class PhotofiltersPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "photofilters");
    channel.setMethodCallHandler(new PhotofiltersPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("BezierSpline.curveGenerator")) {
      Point[] knots = Point.parseFromRawArray(call.argument("knots"));
      Integer[] curve = BezierSpline.curveGenerator(knots);
      result.success(curve);
    } else if (call.method.equals("ImageProcessor.applyCurves")) {
      Integer[] rgb = call.argument("rgb");
      Integer[] red = call.argument("red");
      Integer[] green = call.argument("green");
      Integer[] blue = call.argument("blue");
      byte[] bytes = call.argument("bytes");
      Bitmap inputImage = bitmapFromByteArray(bytes);
      Bitmap outPutImage = ImageProcessor.applyCurves(rgb, red, green, blue, inputImage);
      byte[] out = bitmapToByteArray(outPutImage);
      result.success(out);
    } else if (call.method.equals("ImageProcessor.doBrightness")) {
      Integer value = call.argument("value");
      byte[] bytes = call.argument("bytes");
      Bitmap inputImage = bitmapFromByteArray(bytes);
      Bitmap outPutImage = ImageProcessor.doBrightness(value, inputImage);
      byte[] out = bitmapToByteArray(outPutImage);
      result.success(out);
    } else if (call.method.equals("ImageProcessor.doContrast")) {
      float value = call.argument("value");
      byte[] bytes = call.argument("bytes");
      Bitmap inputImage = bitmapFromByteArray(bytes);
      Bitmap outPutImage = ImageProcessor.doContrast(value, inputImage);
      byte[] out = bitmapToByteArray(outPutImage);
      result.success(out);
    } else if (call.method.equals("ImageProcessor.doColorOverlay")) {
      Integer depth = call.argument("depth");
      float red = call.argument("red");
      float green = call.argument("green");
      float blue = call.argument("blue");
      Bitmap inputImage = bitmapFromByteArray(bytes);
      Bitmap outPutImage = ImageProcessor.doColorOverlay(depth, red, green, blue, inputImage);
      byte[] out = bitmapToByteArray(outPutImage);
      result.success(out);
    } else if (call.method.equals("ImageProcessor.doSaturation")) {

      float level = call.argument("level");
      byte[] bytes = call.argument("bytes");
      Bitmap inputImage = bitmapFromByteArray(bytes);
      Bitmap outPutImage = ImageProcessor.doSaturation(inputImage, level);
      byte[] out = bitmapToByteArray(outPutImage);
      result.success(out);
    } else {
      result.notImplemented();
    }
  }

  private Bitmap bitmapFromByteArray(byte[] bytes) {
    return BitmapFactory.decodeByteArray(bytes, 0, bitmapdata.length);
  }

  private byte[] bitmapToByteArray(Bitmap bitmap) {
    ByteArrayOutputStream blob = new ByteArrayOutputStream();
    bitmap.compress(CompressFormat.PNG, 0 /* Ignored for PNGs */, blob);
    byte[] bitmapByteArray = blob.toByteArray();
    return bitmapByteArray;
  }
}
