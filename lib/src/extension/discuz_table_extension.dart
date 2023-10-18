import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';

class DiscuzTableExtension extends TableHtmlExtension {
  const DiscuzTableExtension();

  @override
  bool matches(ExtensionContext context) {
    return super.matches(context) && !context.innerHtml.contains('<table');
  }
}