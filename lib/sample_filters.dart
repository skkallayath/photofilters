import 'package:photofilters/filter.dart';
import 'package:photofilters/geometry.dart';
import 'package:photofilters/subfilters.dart';

class SampleFilters {
  static List<Filter> get filters => [
        getStarLitFilter(),
        getBlueMessFilter(),
        getAweStruckVibeFilter(),
        getLimeStutterFilter(),
        getNightWhisperFilter(),
      ];

  static Filter getStarLitFilter() {
    List<Point> rgbKnots;
    rgbKnots = new List<Point>(8);
    rgbKnots[0] = new Point(0, 0);
    rgbKnots[1] = new Point(34, 6);
    rgbKnots[2] = new Point(69, 23);
    rgbKnots[3] = new Point(100, 58);
    rgbKnots[4] = new Point(150, 154);
    rgbKnots[5] = new Point(176, 196);
    rgbKnots[6] = new Point(207, 233);
    rgbKnots[7] = new Point(255, 255);
    Filter filter = new Filter("startLit");
    filter.addSubFilter(new ToneCurveSubFilter(rgbKnots, null, null, null));
    return filter;
  }

  static Filter getBlueMessFilter() {
    List<Point> redKnots;
    redKnots = new List<Point>(8);
    redKnots[0] = new Point(0, 0);
    redKnots[1] = new Point(86, 34);
    redKnots[2] = new Point(117, 41);
    redKnots[3] = new Point(146, 80);
    redKnots[4] = new Point(170, 151);
    redKnots[5] = new Point(200, 214);
    redKnots[6] = new Point(225, 242);
    redKnots[7] = new Point(255, 255);
    Filter filter = new Filter("blueMess");
    filter.addSubFilter(new ToneCurveSubFilter(null, redKnots, null, null));
    filter.addSubFilter(new BrightnessSubFilter(30));
    filter.addSubFilter(new ContrastSubFilter(1.0));
    return filter;
  }

  static Filter getAweStruckVibeFilter() {
    List<Point> rgbKnots;
    List<Point> redKnots;
    List<Point> greenKnots;
    List<Point> blueKnots;

    rgbKnots = new List<Point>(5);
    rgbKnots[0] = new Point(0, 0);
    rgbKnots[1] = new Point(80, 43);
    rgbKnots[2] = new Point(149, 102);
    rgbKnots[3] = new Point(201, 173);
    rgbKnots[4] = new Point(255, 255);

    redKnots = new List<Point>(5);
    redKnots[0] = new Point(0, 0);
    redKnots[1] = new Point(125, 147);
    redKnots[2] = new Point(177, 199);
    redKnots[3] = new Point(213, 228);
    redKnots[4] = new Point(255, 255);

    greenKnots = new List<Point>(6);
    greenKnots[0] = new Point(0, 0);
    greenKnots[1] = new Point(57, 76);
    greenKnots[2] = new Point(103, 130);
    greenKnots[3] = new Point(167, 192);
    greenKnots[4] = new Point(211, 229);
    greenKnots[5] = new Point(255, 255);

    blueKnots = new List<Point>(7);
    blueKnots[0] = new Point(0, 0);
    blueKnots[1] = new Point(38, 62);
    blueKnots[2] = new Point(75, 112);
    blueKnots[3] = new Point(116, 158);
    blueKnots[4] = new Point(171, 204);
    blueKnots[5] = new Point(212, 233);
    blueKnots[6] = new Point(255, 255);

    Filter filter = new Filter("aweStruckWibe");
    filter.addSubFilter(
        new ToneCurveSubFilter(rgbKnots, redKnots, greenKnots, blueKnots));
    return filter;
  }

  static Filter getLimeStutterFilter() {
    List<Point> blueKnots;
    blueKnots = new List<Point>(3);
    blueKnots[0] = new Point(0, 0);
    blueKnots[1] = new Point(165, 114);
    blueKnots[2] = new Point(255, 255);
    // Check whether output is null or not.
    Filter filter = new Filter("limeShutter");
    filter.addSubFilter(new ToneCurveSubFilter(null, null, null, blueKnots));
    return filter;
  }

  static Filter getNightWhisperFilter() {
    List<Point> rgbKnots;
    List<Point> redKnots;
    List<Point> greenKnots;
    List<Point> blueKnots;

    rgbKnots = new List<Point>(3);
    rgbKnots[0] = new Point(0, 0);
    rgbKnots[1] = new Point(174, 109);
    rgbKnots[2] = new Point(255, 255);

    redKnots = new List<Point>(4);
    redKnots[0] = new Point(0, 0);
    redKnots[1] = new Point(70, 114);
    redKnots[2] = new Point(157, 145);
    redKnots[3] = new Point(255, 255);

    greenKnots = new List<Point>(3);
    greenKnots[0] = new Point(0, 0);
    greenKnots[1] = new Point(109, 138);
    greenKnots[2] = new Point(255, 255);

    blueKnots = new List<Point>(3);
    blueKnots[0] = new Point(0, 0);
    blueKnots[1] = new Point(113, 152);
    blueKnots[2] = new Point(255, 255);

    Filter filter = new Filter("nightWhisper");
    filter.addSubFilter(
        new ToneCurveSubFilter(rgbKnots, redKnots, greenKnots, blueKnots));
    return filter;
  }
}
