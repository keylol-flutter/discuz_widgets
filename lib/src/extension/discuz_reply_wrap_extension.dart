import 'package:discuz_widgets/discuz.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzReplyWrapExtension extends HtmlExtension {
  const DiscuzReplyWrapExtension();

  @override
  Set<String> get supportedTags => {'div'};

  @override
  bool matches(ExtensionContext context) {
    return super.matches(context) && context.classes.contains('reply_wrap');
  }

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: ReplyWrap(
        extensionContext: context,
      ),
    );
  }
}

class ReplyWrap extends StatelessWidget {
  final ExtensionContext extensionContext;

  const ReplyWrap({super.key, required this.extensionContext});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      child: Discuz(
        data: '引用: ${extensionContext.innerHtml}',
        nested: true,
      ),
    );
  }
}
