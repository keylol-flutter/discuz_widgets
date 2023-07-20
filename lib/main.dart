import 'package:discuz_widgets/discuz.dart';
import 'package:discuz_widgets/src/extension/discuz_collapse_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Discuz(
        data: '''
        <collapse title="CollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapseCollapse">
          <collapse title="Collapse1">
            Collapse1
          </collapse>
          <collapse title="Collapse2">
            Collapse2
          </collapse>
        </collapse>
        <spoil title="SpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoilSpoil">
          <spoil title="Spoil1">
            Spoil1
          </spoil>
          <spoil title="Spoil2">
            Spoil2
          </spoil>
        </spoil>
        <countdown>2023-08-20 00:00:00</countdown>
        ''',
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
