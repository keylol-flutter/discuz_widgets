import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_save/image_save.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final String url;

  const ImageView({super.key, required this.url});

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
              _saveNetworkImageToPhoto(context);
            },
          ),
        ],
      ),
      body: PhotoView(
        imageProvider: NetworkImage(url),
        backgroundDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }

  Future<void> _saveNetworkImageToPhoto(BuildContext context) async {
    final fileName = url.split('/').last;
    try {
      Response<List<int>> res = await Dio().get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));
      final data = Uint8List.fromList(res.data!);
      await ImageSave.saveImage(data, fileName);
    } on PlatformException catch (e) {
    }
  }
}
