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
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Discuz extends StatefulWidget {
  final String baseUrl;

  final String data;
  final Map<String, String> attachments;

  final bool isPost;
  final bool nested;
  final Color? color;
  final OnTap? onLinkTap;

  final void Function(bool)? saveImgCallback;

  const Discuz({
    super.key,
    this.baseUrl = '',
    required this.data,
    this.attachments = const {},
    this.isPost = false,
    this.nested = false,
    this.color,
    this.onLinkTap,
    this.saveImgCallback,
  });

  @override
  State<StatefulWidget> createState() => _DiscuzState();
}

class _DiscuzState extends State<Discuz> {
  late final String data;
  final attachmentUrls = <String>[];

  @override
  void initState() {
    data = _parseData(widget.data);
    super.initState();
  }

  String _parseData(String data) {
    // trim
    data = data.trimLeft().trimRight();
    try {
      // \r\n 替换成换行
      data = data.replaceAll('\r\n', '<br />').replaceAll('\n\r', '<br />');
      // 多个 <br/> 合并
      data = data.replaceAllMapped(
        RegExp(r'(<br\s?/>)+'),
        (match) => '<br />',
      );
      // 去除文末换行
      data = data.replaceAllMapped(RegExp(r'(<br\s?/>)+$'), (match) => '');
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: '换行符合并失败 ${e.toString()}');
    }

    try {
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
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: '折叠或隐藏内容替换失败 ${e.toString()}');
    }

    try {
      // 视频
      data = data
          .replaceAll('[media]', '<iframe src="')
          .replaceAll('[/media]', '"></iframe>');
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: '视频替换失败 ${e.toString()}');
    }

    try {
      // 倒计时
      data = data.replaceAllMapped(
        RegExp(r'\[micxp_countdown=?([^\]]*)]'),
        (match) {
          return '<countdown title=${match[1]}>';
        },
      ).replaceAll('[/micxp_countdown]', '</countdown>');
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: '倒计时替换失败 ${e.toString()}');
    }

    try {
      // 附件后多余换行去除
      data = data.replaceAllMapped(
        RegExp(r'\[/attach](<br\s?/>)+'),
        (match) => '[/attach]',
      );
      // 附件
      data = data.replaceAllMapped(
        RegExp(r'\[attach](.*?)\[/attach]'),
        (match) {
          final attachmentUrl = widget.attachments.remove(match[1]);
          if (attachmentUrl == null) {
            return '';
          }
          attachmentUrls.add(attachmentUrl);
          return '<img src="$attachmentUrl">';
        },
      );
      // 多余附件文末显示
      if (widget.attachments.isNotEmpty) {
        for (final attachment in widget.attachments.values) {
          attachmentUrls.add(attachment);
          data += '<br /><img src="$attachment">';
        }
      }
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: '附件替换失败 ${e.toString()}');
    }

    try {
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
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack, label: '表格格式化失败 ${e.toString()}');
    }

    // 使用 https
    data = data.replaceAll('http://', 'https://');

    // html unescape
    final htmlUnescape = HtmlUnescape();
    data = htmlUnescape.convert(data);

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
          const DiscuzReplyWrapExtension(),
          DiscuzImageExtension(
            baseUrl: widget.baseUrl,
            urls: attachmentUrls,
            saveImgCallback: widget.saveImgCallback,
          ),
          const DiscuzTableExtension(),
          const DiscuzIframeExtension(),
          const VideoHtmlExtension(),
        ],
        style: {
          'body': Style(
            margin: widget.nested ? Margins.zero : null,
            color: widget.color,
          ),
          'p': Style(
            lineHeight: LineHeight.normal,
          ),
        },
      ),
    );
  }
}
