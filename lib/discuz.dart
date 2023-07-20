import 'package:discuz_widgets/src/extension/discuz_collapse_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_countdown_extension.dart';
import 'package:discuz_widgets/src/extension/discuz_spoil_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Discuz extends StatelessWidget {
  final String data;

  const Discuz({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      extensions: const [
        DiscuzCollapseExtension(),
        DiscuzSpoilExtension(),
        DiscuzCountdownExtension(),
      ],
    );
  }
}
