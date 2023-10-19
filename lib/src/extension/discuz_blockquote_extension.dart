import 'package:discuz_widgets/discuz.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzBlockquoteExtension extends HtmlExtension {
  final bool isPost;

  const DiscuzBlockquoteExtension({this.isPost = false});

  @override
  Set<String> get supportedTags => {'blockquote'};

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: BlockQuote(
        extensionContext: context,
        isPost: isPost,
      ),
    );
  }
}

class BlockQuote extends StatelessWidget {
  final ExtensionContext extensionContext;
  final bool isPost;

  const BlockQuote(
      {super.key, required this.extensionContext, required this.isPost});

  @override
  Widget build(BuildContext context) {
    if (!isPost) {
      return Discuz(
        data: '引用: ${extensionContext.innerHtml}',
        nested: true,
      );
    }

    return DottedBorder(
      color: Colors.grey,
      child: Discuz(
        data: extensionContext.innerHtml,
        nested: true,
      ),
    );
  }
}
