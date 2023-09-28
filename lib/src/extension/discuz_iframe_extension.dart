import 'package:discuz_widgets/src/widgets/auto_resize_webview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DiscuzIframeExtension extends HtmlExtension {
  const DiscuzIframeExtension();

  @override
  Set<String> get supportedTags => {'iframe'};

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: Iframe(
        context: context,
      ),
    );
  }
}

class Iframe extends StatefulWidget {
  final ExtensionContext context;

  const Iframe({super.key, required this.context});

  @override
  State<StatefulWidget> createState() => _IframeState();
}

class _IframeState extends State<Iframe> {
  late final String url;
  late double? width;
  late double? height;

  @override
  void initState() {
    url = widget.context.attributes['src'] ?? '';
    width = widget.context.style?.width?.value;
    height = widget.context.style?.height?.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container();
    }

    return AutoResizeWebView(
      url: url,
    );
  }
}
