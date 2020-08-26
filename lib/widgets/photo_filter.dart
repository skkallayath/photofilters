import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imagelib;
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:worker_manager/worker_manager.dart';

class PhotoFilter extends StatelessWidget {
  PhotoFilter({
    @required this.image,
    @required this.filename,
    @required this.filter,
    this.fit = BoxFit.fill,
    this.loader = const Center(child: CircularProgressIndicator()),
  });

  final String filename;
  final Filter filter;
  final BoxFit fit;
  final imagelib.Image image;
  final Widget loader;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: compute(applyFilter, <String, dynamic>{
        'filter': filter,
        'image': image,
        'filename': filename,
      }),
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return loader;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return loader;
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
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

///The PhotoFilterSelector Widget for apply filter from a selected set of filters
class PhotoFilterSelector extends StatefulWidget {
  const PhotoFilterSelector(
      {Key key,
      @required this.title,
      @required this.filters,
      @required this.image,
      this.appBarColor = Colors.blue,
      this.loader = const Center(child: CircularProgressIndicator()),
      this.fit = BoxFit.fill,
      @required this.filename,
      this.selectFilter,
      this.circleShape = false})
      : super(key: key);

  final Color appBarColor;
  final bool circleShape;
  final String filename;
  final List<Filter> filters;
  final BoxFit fit;
  final imagelib.Image image;
  final Widget loader;
  final Filter selectFilter;
  final Widget title;

  @override
  State<StatefulWidget> createState() => _PhotoFilterSelectorState();
}

class _PhotoFilterSelectorState extends State<PhotoFilterSelector> {
  Map<String, List<int>> cachedImageFilters = {};
  Map<String, List<int>> cachedThumbnailFilters = {};
  String filename;
  imagelib.Image image; //original image
  bool loading;
  imagelib.Image thumbnailImage; // thumbnail image

  Filter _filter;

  @override
  void dispose() {
    if (!Executor().isClosed) {
      Executor().close();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loading = Executor().isClosed;
    warmUpExecutor();
    if (widget.selectFilter != null &&
        widget.filters.contains(widget.selectFilter)) {
      _filter = widget.selectFilter;
    } else {
      _filter = widget.filters[0];
    }
    filename = widget.filename;
    image = widget.image;
    thumbnailImage = imagelib.copyResize(image, width: 84, height: 84);
  }

  void warmUpExecutor() async {
    if (Executor().isClosed) {
      await Executor().warmUp();
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/filtered_${_filter?.name ?? "_"}_$filename');
  }

  Future<File> saveFilteredImage() async {
    var imageFile = await _localFile;
    await imageFile.writeAsBytes(cachedImageFilters[_filter?.name ?? '_']);
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        backgroundColor: widget.appBarColor,
        actions: <Widget>[
          loading
              ? Container()
              : IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    var imageFile = await saveFilteredImage();

                    Navigator.pop(context, {
                      'image_filtered': imageFile,
                      'selected_filter': _filter
                    });
                  },
                )
        ],
      ),
      body: loading
          ? widget.loader
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: _BuiltFilteredImage(
                    key: ValueKey(_filter?.name ?? '_'),
                    filter: _filter,
                    image: image,
                    filename: filename,
                    loader: widget.loader,
                    circleShape: widget.circleShape,
                    cachedFilters: cachedImageFilters,
                    boxFit: widget.fit,
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 125,
                  child: ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.filters.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _BuiltFilteredThumbnail(
                              filter: widget.filters[index],
                              image: thumbnailImage,
                              filename: filename,
                              loader: widget.loader,
                              cachedFilters: cachedThumbnailFilters,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                widget.filters[index].name,
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        onTap: () => setState(() {
                          _filter = widget.filters[index];
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

///The global applyfilter function
List<int> applyFilter(Map<String, dynamic> params) {
  Filter filter = params['filter'];
  imagelib.Image image = params['image'];
  String filename = params['filename'];
  List<int> _bytes = image.getBytes();
  if (filter != null) {
    filter.apply(_bytes, image.width, image.height);
  }
  var _image = imagelib.Image.fromBytes(image.width, image.height, _bytes);
  _bytes = imagelib.encodeNamedImage(_image, filename);

  return _bytes;
}

///The global buildThumbnail function
List<int> buildThumbnail(Map<String, dynamic> params) {
  int width = params['width'];
  params['image'] = imagelib.copyResize(params['image'], width: width);
  return applyFilter(params);
}

class _BuiltFilteredThumbnail extends StatefulWidget {
  const _BuiltFilteredThumbnail(
      {Key key,
      @required this.filter,
      @required this.image,
      @required this.filename,
      @required this.loader,
      @required this.cachedFilters})
      : assert(filter != null),
        assert(image != null),
        assert(filename != null),
        assert(loader != null),
        assert(cachedFilters != null),
        super(key: key);

  final Map<String, dynamic> cachedFilters;
  final String filename;
  final Filter filter;
  final imagelib.Image image;
  final Widget loader;

  @override
  __BuiltFilteredThumbnailState createState() =>
      __BuiltFilteredThumbnailState();
}

class __BuiltFilteredThumbnailState extends State<_BuiltFilteredThumbnail> {
  Cancelable<List<int>> applyFilterCancelable;

  @override
  void dispose() {
    applyFilterCancelable?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      applyFilterCancelable = Executor().execute(arg1: <String, dynamic>{
        'filter': widget.filter,
        'image': widget.image,
        'filename': widget.filename,
      }, fun1: applyFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      return FutureBuilder<List<int>>(
        future: applyFilterCancelable,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: widget.loader);
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              widget.cachedFilters[widget.filter?.name ?? '_'] = snapshot.data;
              return Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: MemoryImage(
                    snapshot.data,
                  ),
                  backgroundColor: Colors.white,
                ),
              );
          }
          return null; // unreachable
        },
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: MemoryImage(
            widget.cachedFilters[widget.filter?.name ?? '_'],
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}

class _BuiltFilteredImage extends StatefulWidget {
  const _BuiltFilteredImage({
    Key key,
    @required this.filter,
    @required this.image,
    @required this.filename,
    @required this.loader,
    @required this.circleShape,
    @required this.cachedFilters,
    @required this.boxFit,
  })  : assert(filter != null),
        assert(image != null),
        assert(filename != null),
        assert(loader != null),
        assert(circleShape != null),
        assert(cachedFilters != null),
        assert(boxFit != null),
        super(key: key);

  final BoxFit boxFit;
  final Map<String, dynamic> cachedFilters;
  final bool circleShape;
  final String filename;
  final Filter filter;
  final imagelib.Image image;
  final Widget loader;

  @override
  __BuiltFilteredImageState createState() => __BuiltFilteredImageState();
}

class __BuiltFilteredImageState extends State<_BuiltFilteredImage> {
  Cancelable<List<int>> applyFilterCancelable;

  @override
  void dispose() {
    applyFilterCancelable?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      applyFilterCancelable = Executor().execute(arg1: <String, dynamic>{
        'filter': widget.filter,
        'image': widget.image,
        'filename': widget.filename,
      }, fun1: applyFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      return FutureBuilder<List<int>>(
        future: applyFilterCancelable,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return widget.loader;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return widget.loader;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              widget.cachedFilters[widget.filter?.name ?? '_'] = snapshot.data;
              return widget.circleShape
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Center(
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 3,
                          backgroundImage: MemoryImage(
                            snapshot.data,
                          ),
                        ),
                      ),
                    )
                  : Image.memory(
                      snapshot.data,
                      fit: BoxFit.contain,
                    );
          }
          return null; // unreachable
        },
      );
    } else {
      return widget.circleShape
          ? SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 3,
                  backgroundImage: MemoryImage(
                    widget.cachedFilters[widget.filter?.name ?? '_'],
                  ),
                ),
              ),
            )
          : Image.memory(
              widget.cachedFilters[widget.filter?.name ?? '_'],
              fit: widget.boxFit,
            );
    }
  }
}
