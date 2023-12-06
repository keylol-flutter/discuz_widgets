import 'package:discuz_widgets/src/extension/discuz_blockcode_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_collapse_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_countdown_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_iframe_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_image_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_reply_wrap_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_spoil_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_table_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_video/flutter_html_video.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Discuz extends StatefulWidget {
  final String baseUrl;

  final String data;
  final Map<String, String> attachments;

  final bool isPost;
  final bool nested;
  final Color? color;
  final OnTap? onLinkTap;

  const Discuz({
    super.key,
    this.baseUrl = '',
    required this.data,
    this.attachments = const {},
    this.isPost = false,
    this.nested = false,
    this.color,
    this.onLinkTap,
  });

  @override
  State<StatefulWidget> createState() => _DiscuzState();
}

class _DiscuzState extends State<Discuz> {
  late final String data;

  @override
  void initState() {
    data = _parseData(widget.data);
    super.initState();
  }

  String _parseData(String data) {
    // trim
    data = data.trimLeft().trimRight();
    // \r\n 替换空格
    data = data.replaceAll('\r\n', '');

    // 折叠内容
    data = data.replaceAllMapped(
      RegExp(r'\[collapse=?([^\]]*)]'),
      (match) {
        return '<collapse title="${match[1]}">';
      },
    ).replaceAll('[/collapse]', '</collapse>');

    // 隐藏内容
    data = data.replaceAllMapped(
      RegExp(r'\[spoil=?([^\]]*)]'),
      (match) {
        return '<spoil title="${match[1]}">';
      },
    ).replaceAll('[/spoil]', '</spoil>');

    // 视频
    data = data
        .replaceAll('[media]', '<iframe src="')
        .replaceAll('[/media]', '"></iframe>');

    // 倒计时
    data = data.replaceAllMapped(
      RegExp(r'\[micxp_countdown=?([^\]]*)]'),
      (match) {
        return '<countdown title=${match[1]}>';
      },
    ).replaceAll('[/micxp_countdown]', '</countdown>');

    // 附件
    data = data.replaceAllMapped(
      RegExp(r'\[attach](((?!\[attach]).)*)\[/attach]'),
      (match) {
        return '<img src="${widget.attachments[match[1]]}">';
      },
    );

    // table
    data = data.replaceAllMapped(
      RegExp(r'<tr>(((?!<tr>).)*)<tr>', multiLine: true),
      (match) {
        var str = match[1] ?? '';

        while (str.contains('</tr>')) {
          var tempStr = str.replaceFirst('</tr>', '');
          if (!tempStr.contains('/tr>')) {
            break;
          }
          str = tempStr;
        }

        return '<tr>$str<tr>';
      },
    ).replaceAllMapped(
      RegExp(r'<tr>(((?!<tr>).)*)$', multiLine: true),
      (match) {
        var str = match[1] ?? '';

        while (str.contains('</tr>')) {
          var tempStr = str.replaceFirst('</tr>', '');
          if (!tempStr.contains('/tr>')) {
            break;
          }
          str = tempStr;
        }

        return '<tr>$str';
      },
    );

    // 使用 https
    data = data.replaceAll('http://', 'https://');

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Html(
        data: data,
        onLinkTap: widget.onLinkTap ??
            (url, attributes, element) {
              if (url != null) {
                launchUrlString(url, mode: LaunchMode.externalApplication);
              }
            },
        extensions: [
          const DiscuzCollapseExtension(),
          const DiscuzSpoilExtension(),
          const DiscuzCountdownExtension(),
          const DiscuzBlockcodeExtension(),
          DiscuzReplyWrapExtension(isPost: widget.isPost),
          DiscuzImageExtension(baseUrl: widget.baseUrl),
          const DiscuzTableExtension(),
          const DiscuzIframeExtension(),
          const VideoHtmlExtension(),
        ],
        style: {
          'body': Style(
            margin: widget.nested ? Margins.zero : null,
            color: widget.color,
          ),
        },
      ),
    );
  }
}
