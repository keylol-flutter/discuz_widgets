import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscuzCountdownExtension extends HtmlExtension {
  const DiscuzCountdownExtension();

  @override
  Set<String> get supportedTags => {'countdown'};

  @override
  InlineSpan build(ExtensionContext context) {
    return WidgetSpan(
      child: Countdown(
        context: context,
      ),
    );
  }
}

class Countdown extends StatefulWidget {
  final ExtensionContext context;

  const Countdown({super.key, required this.context});

  @override
  State<StatefulWidget> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late final DateTime? date;
  late final String? text;

  @override
  void initState() {
    date = widget.context.innerHtml.isEmpty
        ? null
        : DateTime.parse(widget.context.innerHtml.replaceAllMapped(
            RegExp(r'\s(\d):(\d{2})'),
            (match) {
              return ' 0${match[1]}:${match[2]}';
            },
          ));
    text = widget.context.attributes['title'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      return Container();
    }

    if (date!.compareTo(DateTime.now()) < 0) {
      return Center(
        child: Text('本活动已结束${text == null ? '' : '，'}$text'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: StreamBuilder<String>(
          stream: Stream.periodic(const Duration(seconds: 1), (i) {
            final now = DateTime.now();
            var date = this.date!;

            var difference = date.difference(now);
            final days = difference.inDays;
            date = date.subtract(Duration(days: days));

            difference = date.difference(now);
            final hours = difference.inHours;
            date = date.subtract(Duration(hours: hours));

            difference = date.difference(now);
            final minutes = difference.inMinutes;
            date = date.subtract(Duration(minutes: minutes));

            difference = date.difference(now);
            final seconds = difference.inSeconds;

            return '$days天$hours小时$minutes分$seconds秒';
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
