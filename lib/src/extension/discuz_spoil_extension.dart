import 'package:discuz_widgets/discuz.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzSpoilExtension extends HtmlExtension {
  const DiscuzSpoilExtension();

  @override
  Set<String> get supportedTags => {'spoil'};

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: Spoil(
        context: context,
      ),
    );
  }
}

class Spoil extends StatefulWidget {
  final ExtensionContext context;

  const Spoil({super.key, required this.context});

  @override
  State<StatefulWidget> createState() => _SpoilState();
}

class _SpoilState extends State<Spoil> {
  late final String title;
  late final String message;

  bool _expanded = false;

  @override
  void initState() {
    title = widget.context.attributes['title'] ?? '';
    message = widget.context.innerHtml;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_expanded) {
      return Container(
        margin: const EdgeInsets.only(top: 4, bottom: 4),
        child: DottedBorder(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: Text(
                    title + (title.isNotEmpty ? '，' : ''),
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _expanded = true;
                    });
                  },
                  child: const Text(
                    '点击显示',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 4, bottom: 4),
        child: DottedBorder(
          color: Colors.red,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: Text(
                        title + (title.isNotEmpty ? '，' : ''),
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _expanded = false;
                        });
                      },
                      child: const Text(
                        '点击隐藏',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Discuz(
                data: message,
                onLinkTap: widget.context.parser.onLinkTap,
              ),
            ],
          ),
        ),
      );
    }
  }
}
