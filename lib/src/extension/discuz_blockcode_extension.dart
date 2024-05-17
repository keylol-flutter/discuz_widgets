import 'package:collection/collection.dart';
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
  late final List<String> codeLines;

  @override
  void initState() {
    final element = widget.context.element;
    if (element == null) {
      codeLines = [];
    } else {
      codeLines = element
          .getElementsByTagName('li')
          .map((e) => e.innerHtml.replaceAll('&nbsp', ' '))
          .where((e) => e.isNotEmpty)
          .toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (codeLines.isEmpty) {
      return Container();
    }

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: codeLines.mapIndexed((index, codeLine) {
              return Row(
                children: [
                  SizedBox(
                    width: 24,
                    child: SelectionContainer.disabled(
                        child: Text('${index + 1}.')),
                  ),
                  Text(codeLine),
                ],
              );
            }).toList()),
      ),
    );
  }
}
