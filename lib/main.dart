import 'package:discuz_widgets/discuz.dart';
import 'package:flutter/material.dart';

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
        <table>
          <tr>
            <th>Company</th>
            <th>Contact</th>
            <th>Country</th>
          </tr>
          <tr>
            <td>Alfreds Futterkiste</td>
            <td>Maria Anders</td>
            <td>Germany</td>
          </tr>
          <tr>
            <td>Centro comercial Moctezuma</td>
            <td>Francisco Chang</td>
            <td>Mexico</td>
          </tr>
        </table> 
        <div class="blockcode">
          <div>
            <p>代码:</p>
            <ol>
              <li>1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111</li>
              <li>\$ curl -vl x.com<br></li>
              <li>* processing: x.com<br></li>
              <li>*&nbsp; &nbsp;trying 34.102.136.180:80...<br></li>
              <li>* connected to x.com (34.102.136.180) port 80<br></li>
              <li>&gt; get / http/1.1<br></li>
              <li>&gt; host: x.com<br></li>
              <li>&gt; user-agent: curl/8.2.0<br></li>
              <li>&gt; accept: */*<br></li>
              <li>&gt; <br></li>
              <li>&lt; http/1.1 302 moved temporarily<br></li>
              <li>&lt; date: mon, 24 jul 2023 00:49:55 gmt<br></li>
              <li>&lt; transfer-encoding: chunked<br></li>
              <li>&lt; connection: keep-alive<br></li>
              <li>&lt; cache-control: private, max-age=0, no-store, no-cache, must-revalidate, post-check=0,
                  pre-check=0<br></li>
              <li>&lt; expires: thu, 01 jan 1970 00:00:01 gmt<br></li>
              <li>&lt; location: https://.twitter.com/<br></li>
              <li>&lt; server: cloudflare<br></li>
              <li>&lt; cf-ray:<br></li>
              <li>&lt; <br></li>
              <li>* ignoring the response-body<br></li>
              <li>* connection #0 to host x.com left intact<br></li>
              <li>* clear auth, redirects to port from 80 to 443<br></li>
              <li>* issue another request to this url: 'https://.twitter.com/'<br></li>
              <li>* could not resolve host: .twitter.com<br></li>
              <li>* closing connection<br></li>
              <li>curl: (6) could not resolve host: .twitter.com<br></li>
            </ol>
          </div>
        </div>
        ''',
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
