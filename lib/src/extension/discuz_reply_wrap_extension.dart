import 'package:discuz_widgets/discuz.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzReplyWrapExtension extends HtmlExtension {
  final bool isPost;

  DiscuzReplyWrapExtension({this.isPost = false});

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
        isPost: isPost,
      ),
    );
  }
}

class ReplyWrap extends StatelessWidget {
  final bool isPost;
  final ExtensionContext extensionContext;

  const ReplyWrap(
      {super.key, required this.extensionContext, required this.isPost});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset('images/quote_proper_left.png'),
            Expanded(child: Container())
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 16.0),
            Expanded(child: Discuz(
              data: '引用: ${extensionContext.innerHtml}',
              nested: false,
              color: Colors.grey,
            )),
            const SizedBox(width: 16.0)
          ],
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Image.asset('images/quote_proper_right.png')
          ],
        )
      ],
    );


    // if (!isPost) {
    //   return Discuz(
    //     data: '引用: ${extensionContext.innerHtml}',
    //     nested: false,
    //     color: Colors.grey,
    //   );
    // }
    //
    // return DottedBorder(
    //   color: Colors.grey,
    //   child: Discuz(
    //     data: '引用: ${extensionContext.innerHtml}',
    //     nested: false,
    //     color: Colors.grey,
    //   ),
    // );
  }
}
