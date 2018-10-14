import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:image/image.dart' as imageLib;

class PhotoFilter extends StatelessWidget {
  final imageLib.Image image;
  final String filename;
  final Filter filter;
  final BoxFit fit;
  final Widget loader;
  PhotoFilter({
    @required this.image,
    @required this.filename,
    @required this.filter,
    this.fit = BoxFit.fill,
    this.loader = const Center(child: CircularProgressIndicator()),
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: compute(applyFilter, <String, dynamic>{
        "filter": filter,
        "image": image,
        "filename": filename,
      }),
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return loader;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return loader;
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            return Image.memory(
              snapshot.data,
              fit: fit,
            );
        }
        return null; // unreachable
      },
    );
  }
}

/**
 * The PhotoFilterSelector Widget for apply filter from a selected set of filters
 */

class PhotoFilterSelector extends StatefulWidget {
  final imageLib.Image image;
  final String filename;
  final Widget loader;
  final List<Filter> filters;
  final BoxFit fit;

  PhotoFilterSelector({
    @required this.image,
    @required this.filename,
    @required this.filters,
    this.loader = const Center(child: CircularProgressIndicator()),
    this.fit = BoxFit.fill,
  });

  @override
  _PhotoFilterSelectorState createState() => new _PhotoFilterSelectorState();
}

class _PhotoFilterSelectorState extends State<PhotoFilterSelector> {
  Map<String, List<int>> cachedFilters;
  Filter _filter;

  _PhotoFilterSelectorState() {
    cachedFilters = {};
  }

  @override
  void initState() {
    super.initState();
    _filter = widget.filters[0];
  }

  Widget _buildFilteredImage(
      Filter filter, imageLib.Image image, String filename) {
    if (cachedFilters[filter?.name ?? "_"] == null) {
      return FutureBuilder<List<int>>(
        future: compute(applyFilter, <String, dynamic>{
          "filter": filter,
          "image": widget.image,
          "filename": widget.filename,
        }),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return widget.loader;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return widget.loader;
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              cachedFilters[filter?.name ?? "_"] = snapshot.data;
              return Image.memory(
                snapshot.data,
                fit: widget.fit,
              );
          }
          return null; // unreachable
        },
      );
    } else {
      return Image.memory(
        cachedFilters[filter?.name ?? "_"],
        fit: widget.fit,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(12.0),
              child: _buildFilteredImage(
                _filter,
                widget.image,
                widget.filename,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.filters.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _buildFilterThumbnail(widget.filters[index],
                              widget.image, widget.filename),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            widget.filters[index].name,
                          )
                        ],
                      ),
                    ),
                    onTap: () => setState(() {
                          _filter = widget.filters[index];
                        }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildFilterThumbnail(Filter filter, imageLib.Image image, String filename) {
    if (cachedFilters[filter?.name ?? "_"] == null) {
      return FutureBuilder<List<int>>(
        future: compute(applyFilter, <String, dynamic>{
          "filter": filter,
          "image": widget.image,
          "filename": widget.filename,
        }),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircleAvatar(
                radius: 50.0,
                child: Center(
                  child: widget.loader,
                ),
                backgroundColor: Colors.white,
              );
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              cachedFilters[filter?.name ?? "_"] = snapshot.data;
              return CircleAvatar(
                radius: 50.0,
                backgroundImage: MemoryImage(
                  snapshot.data,
                ),
                backgroundColor: Colors.white,
              );
          }
          return null; // unreachable
        },
      );
    } else {
      return CircleAvatar(
        radius: 50.0,
        backgroundImage: MemoryImage(
          cachedFilters[filter?.name ?? "_"],
        ),
        backgroundColor: Colors.white,
      );
    }
  }
}

/**
 * The global applyfilter function
 */
List<int> applyFilter(Map<String, dynamic> params) {
  Filter filter = params["filter"];
  imageLib.Image image = params["image"];
  String filename = params["filename"];
  List<int> _bytes = image.getBytes();
  if (filter != null) {
    filter.apply(_bytes);
  }
  imageLib.Image _image =
      imageLib.Image.fromBytes(image.width, image.height, _bytes);
  _bytes = imageLib.encodeNamedImage(_image, filename);

  return _bytes;
}

/**
 * The global buildThumbnail function
 */
List<int> buildThumbnail(Map<String, dynamic> params) {
  int width = params["width"];
  params["image"] = imageLib.copyResize(params["image"], width);
  return applyFilter(params);
}
