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
              _saveNetworkImageToPhoto(context).then((success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: success
                        ? const Text('Save success')
                        : const Text('Save failed'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              });
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

  Future<bool> _saveNetworkImageToPhoto(BuildContext context) async {
    final fileName = url.split('/').last;
    try {
      Response<List<int>> res = await Dio().get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));
      final data = Uint8List.fromList(res.data!);
      return await ImageSave.saveImage(data, fileName,
              overwriteSameNameFile: false) ??
          false;
    } catch (e) {
      return false;
    }
  }
}
