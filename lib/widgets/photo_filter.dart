import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imagelib;
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';

enum ApplyFilterStatus { LOADING, SUCCESS, ERROR }

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
      this.circleShape = false})
      : super(key: key);

  final Color appBarColor;
  final bool circleShape;
  final String filename;
  final List<Filter> filters;
  final BoxFit fit;
  final imagelib.Image image;
  final Widget loader;
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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loading = false;
    _filter = widget.filters[0];
    filename = widget.filename;
    image = widget.image;
    thumbnailImage = imagelib.copyResize(image, width: 84, height: 84);
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

                    Navigator.pop(context, {'image_filtered': imageFile});
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

class IsolateConfiguration {
  const IsolateConfiguration(this.sendPort, this.params);

  final Map<String, dynamic> params;
  final SendPort sendPort;
}

void isolateFunc(IsolateConfiguration isolateConfiguration) =>
    isolateConfiguration.sendPort
        .send(applyFilter(isolateConfiguration.params));

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
  ApplyFilterStatus applyFilterStatus = ApplyFilterStatus.LOADING;
  ReceivePort errorPort;
  Isolate isolate;
  Map<String, dynamic> params;
  ReceivePort receivePort;

  @override
  void dispose() {
    receivePort.close();
    errorPort.close();
    isolate?.kill(priority: Isolate.immediate);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    receivePort = ReceivePort();
    errorPort = ReceivePort();
    initIsolate();
    receivePort.listen(
      (dynamic data) {
        widget.cachedFilters[widget.filter.name] = data;
        setState(() {
          applyFilterStatus = ApplyFilterStatus.SUCCESS;
        });
      },
    );
    errorPort.listen((dynamic errorData) {
      final exception = Exception(errorData[0]);
      final stack = StackTrace.fromString(errorData[1] as String);
      print('$exception, $stack');
      setState(() {
        applyFilterStatus = ApplyFilterStatus.ERROR;
      });
    });
  }

  void initIsolate() async {
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      isolate = await Isolate.spawn(
          isolateFunc,
          IsolateConfiguration(receivePort.sendPort, <String, dynamic>{
            'filter': widget.filter,
            'image': widget.image,
            'filename': widget.filename,
          }),
          onError: errorPort.sendPort);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      if (applyFilterStatus == ApplyFilterStatus.LOADING) {
        return Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: widget.loader);
      } else if (applyFilterStatus == ApplyFilterStatus.ERROR) {
        return Center(child: Text('Error'));
      }
      return Container(
        width: 100,
        height: 100,
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: MemoryImage(
            widget.cachedFilters[widget.filter.name],
          ),
          backgroundColor: Colors.white,
        ),
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
  ApplyFilterStatus applyFilterStatus = ApplyFilterStatus.LOADING;
  ReceivePort errorPort;
  Isolate isolate;
  ReceivePort receivePort;

  @override
  void dispose() {
    receivePort.close();
    errorPort.close();
    isolate?.kill(priority: Isolate.immediate);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    receivePort = ReceivePort();
    errorPort = ReceivePort();
    initIsolate();
    receivePort.listen(
      (dynamic data) {
        widget.cachedFilters[widget.filter.name] = data;
        setState(() {
          applyFilterStatus = ApplyFilterStatus.SUCCESS;
        });
      },
    );
    errorPort.listen((dynamic errorData) {
      final exception = Exception(errorData[0]);
      final stack = StackTrace.fromString(errorData[1] as String);
      print('$exception, $stack');
      setState(() {
        applyFilterStatus = ApplyFilterStatus.ERROR;
      });
    });
  }

  void initIsolate() async {
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      isolate = await Isolate.spawn(
          isolateFunc,
          IsolateConfiguration(receivePort.sendPort, <String, dynamic>{
            'filter': widget.filter,
            'image': widget.image,
            'filename': widget.filename,
          }),
          onError: errorPort.sendPort);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cachedFilters[widget.filter?.name ?? '_'] == null) {
      if (applyFilterStatus == ApplyFilterStatus.LOADING) {
        return widget.loader;
      } else if (applyFilterStatus == ApplyFilterStatus.ERROR) {
        Center(child: Text('Error'));
      }
      return widget.circleShape
          ? SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 3,
                  backgroundImage: MemoryImage(
                    widget.cachedFilters[widget.filter.name],
                  ),
                ),
              ),
            )
          : Image.memory(
              widget.cachedFilters[widget.filter.name],
              fit: BoxFit.contain,
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
