import 'package:cached_network_image/cached_network_image.dart';
import 'package:discuz_widgets/src/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/src/tree/image_element.dart';

class DiscuzImageExtension extends ImageExtension {
  final String baseUrl;
  final List<String> urls;

  DiscuzImageExtension({required this.baseUrl, this.urls = const []})
      : super(
          builder: (extensionContext) {
            final element = extensionContext.styledElement as ImageElement;

            var url = element.src;
            if (!url.startsWith('http')) {
              url = baseUrl + url;
            }

            return GestureDetector(
              child: CachedNetworkImage(
                imageUrl: url,
                width: element.width?.value,
                height: element.height?.value,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return CircularProgressIndicator(
                    value: progress.progress,
                  );
                },
              ),
              onTap: () {
                showDialog(
                  context: extensionContext.buildContext!,
                  builder: (context) {
                    return Dialog.fullscreen(
                      child: ImageView(
                        url: url,
                        urls: urls,
                      ),
                    );
                  },
                );
              },
            );
          },
        );

  @override
  bool matches(ExtensionContext context) {
    return context.elementName == 'img';
  }
}
