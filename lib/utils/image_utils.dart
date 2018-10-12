import 'dart:math';
import 'dart:typed_data';

void saturation(Uint8List bytes, num saturation) {
  saturation = (saturation < -1) ? -1 : saturation;
  for (int i = 0; i < bytes.length; i += 4) {
    num r = bytes[i], g = bytes[i + 1], b = bytes[i + 2];
    num gray =
        0.2989 * r + 0.5870 * g + 0.1140 * b; //weights from CCIR 601 spec
    bytes[i] = (-gray * saturation + bytes[i] * (1 + saturation)).round();
    bytes[i + 1] =
        (-gray * saturation + bytes[i + 1] * (1 + saturation)).round();
    bytes[i + 2] =
        (-gray * saturation + bytes[i + 2] * (1 + saturation)).round();
  }
}

void hueRotation(Uint8List bytes, int degrees) {
  double U = cos(degrees * pi / 180);
  double W = sin(degrees * pi / 180);

  for (int i = 0; i < bytes.length; i += 4) {
    num r = bytes[i], g = bytes[i + 1], b = bytes[i + 2];
    bytes[i] = ((.299 + .701 * U + .168 * W) * r +
            (.587 - .587 * U + .330 * W) * g +
            (.114 - .114 * U - .497 * W) * b)
        .round();
    bytes[i + 1] = ((.299 - .299 * U - .328 * W) * r +
            (.587 + .413 * U + .035 * W) * g +
            (.114 - .114 * U + .292 * W) * b)
        .round();
    bytes[i + 2] = ((.299 - .3 * U + 1.25 * W) * r +
            (.587 - .588 * U - 1.05 * W) * g +
            (.114 + .886 * U - .203 * W) * b)
        .round();
  }
}

void grayscale(Uint8List bytes) {
  for (int i = 0; i < bytes.length; i += 4) {
    int r = bytes[i], g = bytes[i + 1], b = bytes[i + 2];
    int avg = (0.2126 * r + 0.7152 * g + 0.0722 * b).round();
    bytes[i] = avg;
    bytes[i + 1] = avg;
    bytes[i + 2] = avg;
  }
}

// Adj is 0 (unchanged) to 1 (sepia)
void sepia(Uint8List bytes, num adj) {
  for (int i = 0; i < bytes.length; i += 4) {
    int r = bytes[i], g = bytes[i + 1], b = bytes[i + 2];
    bytes[i] = ((r * (1 - (0.607 * adj))) + (g * .769 * adj) + (b * .189 * adj))
        .round();
    bytes[i + 1] =
        ((r * .349 * adj) + (g * (1 - (0.314 * adj))) + (b * .168 * adj))
            .round();
    bytes[i + 2] =
        ((r * .272 * adj) + (g * .534 * adj) + (b * (1 - (0.869 * adj))))
            .round();
  }
}

void invert(Uint8List bytes) {
  for (int i = 0; i < bytes.length; i += 4) {
    bytes[i] = 255 - bytes[i];
    bytes[i + 1] = 255 - bytes[i + 1];
    bytes[i + 2] = 255 - bytes[i + 2];
  }
}

/* adj should be -1 (darker) to 1 (lighter). 0 is unchanged. */
void brightness(Uint8List bytes, num adj) {
  adj = (adj > 1) ? 1 : adj;
  adj = (adj < -1) ? -1 : adj;
  adj = ~~(255 * adj).round();
  for (int i = 0; i < bytes.length; i += 4) {
    bytes[i] += adj;
    bytes[i + 1] += adj;
    bytes[i + 2] += adj;
  }
}

// Better result (slow) - adj should be < 1 (desaturated) to 1 (unchanged) and < 1
void hueSaturation(Uint8List bytes, num adj) {
  for (int i = 0; i < bytes.length; i += 4) {
    var hsv = rgbToHsv(bytes[i], bytes[i + 1], bytes[i + 2]);
    hsv[1] *= adj;
    var rgb = hsvToRgb(hsv[0], hsv[1], hsv[2]);
    bytes[i] = rgb[0];
    bytes[i + 1] = rgb[1];
    bytes[i + 2] = rgb[2];
  }
}

// Contrast - the adj value should be -1 to 1
void contrast(Uint8List bytes, num adj) {
  adj *= 255;
  double factor = (259 * (adj + 255)) / (255 * (259 - adj));
  for (int i = 0; i < bytes.length; i += 4) {
    bytes[i] = (factor * (bytes[i] - 128) + 128).round();
    bytes[i + 1] = (factor * (bytes[i + 1] - 128) + 128).round();
    bytes[i + 2] = (factor * (bytes[i + 2] - 128) + 128).round();
  }
}

// ColorFilter - add a slight color overlay. rgbColor is an array of [r, g, b, adj]
void colorFilter(Uint8List bytes, num red, num green, num blue, num adj) {
  for (int i = 0; i < bytes.length; i += 4) {
    bytes[i] -= (bytes[i] - red) * adj;
    bytes[i + 1] -= (bytes[i + 1] - green) * adj;
    bytes[i + 2] -= (bytes[i + 2] - blue) * adj;
  }
}

// RGB Adjust
void rgbAdjust(Uint8List bytes, num red, num green, num blue) {
  for (int i = 0; i < bytes.length; i += 4) {
    bytes[i] *= red;
    bytes[i + 1] *= green;
    bytes[i + 2] *= blue;
  }
}

// Convolute - weights are 3x3 matrix
void convolute(Uint8List bytes, int width, int height, List<num> weights) {
  int side = sqrt(weights.length).round();
  int halfSide = ~~(side / 2).round();
  int sw = width;
  int sh = height;

  int w = sw;
  int h = sh;

  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int sy = y;
      int sx = x;
      int dstOff = (y * w + x) * 4;
      int r = 0, g = 0, b = 0;
      for (int cy = 0; cy < side; cy++) {
        for (int cx = 0; cx < side; cx++) {
          int scy = sy + cy - halfSide;
          int scx = sx + cx - halfSide;
          if (scy >= 0 && scy < sh && scx >= 0 && scx < sw) {
            int srcOff = (scy * sw + scx) * 4;
            int wt = weights[cy * side + cx];
            r += bytes[srcOff] * wt;
            g += bytes[srcOff + 1] * wt;
            b += bytes[srcOff + 2] * wt;
          }
        }
      }
      bytes[dstOff] = r;
      bytes[dstOff + 1] = g;
      bytes[dstOff + 2] = b;
    }
  }
}

List<num> rgbToHsv(num r, num g, num b) {
  r /= 255;
  g /= 255;
  b /= 255;

  num _max = max(
    r,
    max(g, b),
  );
  num _min = min(
    r,
    max(g, b),
  );
  num h, s, v = _max;

  num d = _max - _min;
  s = max == 0 ? 0 : d / _max;

  if (max == min) {
    h = 0; // achromatic
  } else {
    if (_max == r) {
      h = (g - b) / d + (g < b ? 6 : 0);
    } else if (_max == g) {
      h = (b - r) / d + 2;
    } else if (_max == b) {
      h = (r - g) / d + 4;
    }
  }

  h /= 6;

  return [h, s, v];
}

List<num> hsvToRgb(num h, num s, num v) {
  int r, g, b;

  int i = (h * 6).floor();
  int f = h * 6 - i;
  int p = v * (1 - s);
  int q = v * (1 - f * s);
  int t = v * (1 - (1 - f) * s);

  switch (i % 6) {
    case 0:
      r = v;
      g = t;
      b = p;
      break;
    case 1:
      r = q;
      g = v;
      b = p;
      break;
    case 2:
      r = p;
      g = v;
      b = t;
      break;
    case 3:
      r = p;
      g = q;
      b = v;
      break;
    case 4:
      r = t;
      g = p;
      b = v;
      break;
    case 5:
      r = v;
      g = p;
      b = q;
      break;
  }

  return [r * 255, g * 255, b * 255];
}
