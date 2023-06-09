import 'dart:math';

List<num?> rgbToHsv(num r, num g, num b) {
  r /= 255;
  g /= 255;
  b /= 255;

  num maxVal = max(
    r,
    max(g, b),
  );
  num minVal = min(
    r,
    max(g, b),
  );
  num? h, s, v = maxVal;

  num d = maxVal - minVal;
  s = maxVal == 0 ? 0 : d / maxVal;

  if (max == min) {
    h = 0; // achromatic
  } else {
    if (maxVal == r) {
      h = (g - b) / d + (g < b ? 6 : 0);
    } else if (maxVal == g) {
      h = (b - r) / d + 2;
    } else if (maxVal == b) {
      h = (r - g) / d + 4;
    }
  }

  h = h ?? 0 / 6;

  return [h, s, v];
}

List<num> hsvToRgb(num h, num s, num v) {
  int r = 0, g = 0, b = 0;

  int i = (h * 6).floor();
  int f = h * 6 - i as int;
  int p = v * (1 - s) as int;
  int q = v * (1 - f * s) as int;
  int t = v * (1 - (1 - f) * s) as int;

  switch (i % 6) {
    case 0:
      r = v as int;
      g = t;
      b = p;
      break;
    case 1:
      r = q;
      g = v as int;
      b = p;
      break;
    case 2:
      r = p;
      g = v as int;
      b = t;
      break;
    case 3:
      r = p;
      g = q;
      b = v as int;
      break;
    case 4:
      r = t;
      g = p;
      b = v as int;
      break;
    case 5:
      r = v as int;
      g = p;
      b = q;
      break;
  }

  return [r * 255, g * 255, b * 255];
}
