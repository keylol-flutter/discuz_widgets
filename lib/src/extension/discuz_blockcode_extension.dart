import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzBlockcodeExtension extends HtmlExtension {
  const DiscuzBlockcodeExtension();

  @override
  Set<String> get supportedTags => {'div'};

  @override
  bool matches(ExtensionContext context) {
    return super.matches(context) && context.classes.contains('blockcode');
  }

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: BlockCode(
        context: context,
      ),
    );
  }
}

class BlockCode extends StatefulWidget {
  final ExtensionContext context;

  const BlockCode({super.key, required this.context});

  @override
  State<StatefulWidget> createState() => _BlockCodeState();
}

class _BlockCodeState extends State<BlockCode> {
  late final String data;

  @override
  void initState() {
    data = widget.context.innerHtml;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Html(data: data),
        ],
      ),
    );
  }
}
