import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatefulWidget {
  final String url;
  final List<String> urls;

  final void Function(bool)? saveImgCallback;

  const ImageView({
    super.key,
    required this.url,
    required this.urls,
    this.saveImgCallback,
  });

  @override
  State<StatefulWidget> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late final int _initIndex;
  late final int _index;
  late final PageController _controller;

  @override
  void initState() {
    widget.urls.forEachIndexed((index, url) {
      if (url == widget.url) {
        _initIndex = index;
      }
    });
    _index = _initIndex;
    _controller = PageController(initialPage: _initIndex);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveNetworkImageToPhoto(context)
                  .then((success) => widget.saveImgCallback?.call(success));
            },
          ),
        ],
      ),
      body: PhotoViewGallery.builder(
        backgroundDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(widget.urls[index]),
              initialScale: PhotoViewComputedScale.contained,
              heroAttributes: PhotoViewHeroAttributes(tag: widget.urls[index]),
              errorBuilder: (context, error, stackTrace) {
                print('ImageView error: $error');
                print('ImageView stackTrace: $stackTrace');

                return const Center(child: CircularProgressIndicator());
              });
        },
        itemCount: widget.urls.length,
        pageController: _controller,
        onPageChanged: (index) {
          _index = index;
        },
      ),
    );
  }

  Future<bool> _saveNetworkImageToPhoto(BuildContext context) async {
    final url = widget.urls[_index];
    try {
      Response<List<int>> res = await Dio().get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));
      final data = Uint8List.fromList(res.data!);
      final result = await ImageGallerySaver.saveImage(data);
      return result['isSuccess'] ?? false;
    } catch (e) {
      return false;
    }
  }
}
