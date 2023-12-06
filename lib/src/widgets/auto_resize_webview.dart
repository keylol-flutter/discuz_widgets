import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AutoResizeWebView extends StatefulWidget {
  final String url;

  const AutoResizeWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AutoResizeWebViewState();
}

class _AutoResizeWebViewState extends State<AutoResizeWebView>
    with AutomaticKeepAliveClientMixin {
  double? _height;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var url = widget.url;
    if (url.startsWith('https://www.bilibili.com/video/')) {
      final bvid = url
          .replaceAll('https://www.bilibili.com/video/', '')
          .replaceAll('/', '')
          .split('?')[0];
      url = 'https://player.bilibili.com/player.html?bvid=$bvid';
    } else if (url.startsWith('https://youtu.be/')) {
      url = url.replaceFirst('https://youtu.be/',
          'https://www.youtube.com/embed/QdBZY2fkU-0?si=NmWFz6qgan_jSLBY');
    }

    if (url.startsWith('https://store.steampowered.com/widget')) {
      _height = 73.0;
    } else if (url.startsWith('https://music.163.com/outchain/player')) {
      url = url.replaceAllMapped(RegExp(r'height=(\d+)'), (match) {
        return 'height=70';
      });
      _height = 70.0;
    }

    if (_height == null) {
      final width = MediaQuery.of(context).size.width;
      _height = (width / 1920.0) * 1080.0;
    }

    return SizedBox(
      height: _height,
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            transparentBackground: true,
            javaScriptEnabled: true,
            javaScriptCanOpenWindowsAutomatically: true,
          ),
        ),
        onLoadStop: (controller, uri) async {
          if (_height != null) {
            return;
          }
          final scrollHeight = await controller.evaluateJavascript(
              source: 'document.body.scrollHeight') as double?;
          if (scrollHeight != null) {
            final height = scrollHeight.ceilToDouble();
            setState(() {
              _height = height;
            });
          }
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          return NavigationActionPolicy.CANCEL;
        },
      ),
    );
  }
}
