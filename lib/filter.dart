import 'dart:typed_data';

class Filter {
  String name = "";
  List<SubFilter> subFilters = [];

  Filter.from(Filter filter) {
    this.name = filter.name;
    this.subFilters = filter.subFilters;
  }

  Filter(this.name);

  void addSubFilter(SubFilter subFilter) {
    subFilters.add(subFilter);
  }

  void clearSubFilters() {
    subFilters.clear();
  }

  void removeSubFilterWithTag(String tag) {
    subFilters.removeWhere((sf) => sf.tag == tag);
  }

  SubFilter getSubFilterByTag(String tag) {
    if (subFilters.any((sf) => sf.tag == tag)) {
      return subFilters.firstWhere((sf) => sf.tag == tag);
    }
    return null;
  }

  Future<Uint8List> processFilter(Uint8List inputImage) async {
    Uint8List outputImage = inputImage;
    if (outputImage != null) {
      for (SubFilter subFilter in subFilters) {
        outputImage =await subFilter.process(outputImage);
      }
    }

    return outputImage;
  }
}

abstract class SubFilter {
  String tag;

  Future<Uint8List> process(Uint8List inputImage);
}
