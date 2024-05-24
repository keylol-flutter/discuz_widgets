import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

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
      var id = url
          .replaceAll('https://www.bilibili.com/video/', '')
          .replaceAll('/', '')
          .split('?')[0];
      if (id.startsWith('BV')) {
        url = 'https://player.bilibili.com/player.html?bvid=$id&autoplay=0';
      } else {
        id = id.replaceAll('av', '');
        url = 'https://player.bilibili.com/player.html?aid=$id&autoplay=0';
      }
    } else if (url.startsWith('https://youtu.be/')) {
      url = url.replaceFirst('https://youtu.be/',
          'https://www.youtube.com/embed/QdBZY2fkU-0?si=NmWFz6qgan_jSLBY');
    }

    if (url.startsWith('https://store.steampowered.com/widget')) {
      _height = 80.0;
    } else if (url.startsWith('//music.163.com/outchain/player')) {
      url = 'https:$url';
      url = url.replaceFirst('music.163.com', 'music.163.com/m');
    }

    if (_height == null) {
      final width = MediaQuery.of(context).size.width;
      _height = (width / 1920.0) * 1080.0;
    }

    return SizedBox(
      height: _height,
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: '''
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <iframe src="$url" width="100%" height="100%" frameborder="0"
              allowfullscreen="allowfullscreen" sandbox="allow-top-navigation allow-same-origin allow-forms allow-scripts allow-popups"/>
          ''',
        ),
        initialSettings: InAppWebViewSettings(
          transparentBackground: true,
          javaScriptEnabled: true,
          builtInZoomControls: false,
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
          final url = navigationAction.request.url!;
          if (await canLaunchUrl(url)) {
            await launchUrl(
              url,
            );
            return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
