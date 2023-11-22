import 'package:discuz_widgets/discuz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class DiscuzTableExtension extends HtmlExtension {
  const DiscuzTableExtension();

  @override
  Set<String> get supportedTags => {'table'};

  @override
  InlineSpan build(ExtensionContext context) {
    final tBodyElement = context.elementChildren
        .firstWhere((element) => element.localName == 'tbody');
    return WidgetSpan(
      child: Column(
        children: _getElementsByTags(tBodyElement, {'tr'}).map(
          (row) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: _getElementsByTags(row, {'td', 'th'}).map(
                (col) {
                  return Expanded(
                    child: Discuz(
                      data: col.innerHtml,
                    ),
                  );
                },
              ).toList(),
            );
          },
        ).toList(),
      ),
    );
  }

  List<dom.Element> _getElementsByTags(dom.Element element, Set<String> tags) {
    return element.children.where((element) {
      return tags.contains(element.localName);
    }).toList();
  }
}