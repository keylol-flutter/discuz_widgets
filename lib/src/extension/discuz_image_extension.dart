import 'package:cached_network_image/cached_network_image.dart';
import 'package:discuz_widgets/src/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/src/tree/image_element.dart';

class DiscuzImageExtension extends ImageExtension {
  DiscuzImageExtension(BuildContext context)
      : super(builder: (extensionContext) {
          final element = extensionContext.styledElement as ImageElement;
          final style = Style(
            width: element.width,
            height: element.height,
          ).merge(element.style);

          final url = element.src;
          return CssBoxWidget(
            style: style,
            childIsReplaced: true,
            child: GestureDetector(
              child: CachedNetworkImage(
                imageUrl: url,
                width: element.width?.value,
                height: element.height?.value,
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, progress) {
                  return CircularProgressIndicator(
                    value: progress.progress,
                  );
                },
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog.fullscreen(
                      child: ImageView(
                        url: url,
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
}
