import 'package:discuz_widgets/discuz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzReplyWrapExtension extends HtmlExtension {
  const DiscuzReplyWrapExtension();

  @override
  Set<String> get supportedTags => {'blockquote'};

  @override
  bool matches(ExtensionContext context) {
    return super.matches(context) || context.classes.contains('reply_wrap');
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

  const ReplyWrap({
    super.key,
    required this.extensionContext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(
              'images/quote_proper_left.png',
              package: 'discuz_widgets',
            ),
            Expanded(child: Container())
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 16.0),
            Expanded(
              child: Discuz(
                data: extensionContext.innerHtml,
                nested: false,
                color: Colors.grey,
                onLinkTap: extensionContext.parser.onLinkTap,
              ),
            ),
            const SizedBox(width: 16.0)
          ],
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Image.asset(
              'images/quote_proper_right.png',
              package: 'discuz_widgets',
            )
          ],
        )
      ],
    );
  }
}
