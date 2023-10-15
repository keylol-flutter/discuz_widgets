import 'package:discuz_widgets/discuz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzCollapseExtension extends HtmlExtension {
  const DiscuzCollapseExtension();

  @override
  Set<String> get supportedTags => {'collapse'};

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: Collapse(
        context: context,
      ),
    );
  }
}

class Collapse extends StatefulWidget {
  final ExtensionContext context;

  const Collapse({
    super.key,
    required this.context,
  });

  @override
  State<StatefulWidget> createState() => _CollapseState();
}

class _CollapseState extends State<Collapse> {
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
      return Card(
        elevation: 0,
        margin: const EdgeInsets.only(top: 4, bottom: 4),
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          onTap: () {
            setState(() {
              _expanded = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(Icons.arrow_right),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
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
        child: Column(
          children: [
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.surfaceVariant,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                  bottom: Radius.zero,
                ),
              ),
              child: InkWell(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                  bottom: Radius.zero,
                ),
                onTap: () {
                  setState(() {
                    _expanded = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_drop_down),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.zero,
                  bottom: Radius.circular(12),
                ),
              ),
              child: Discuz(data: message),
            ),
          ],
        ),
      );
    }
  }
}
