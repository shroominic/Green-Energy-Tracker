import 'package:flutter/material.dart';
import 'scraper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SmardAPI api = SmardAPI();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(api, title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.api, {Key key, this.title}) : super(key: key);

  final SmardAPI api;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(api);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.api);
  SmardAPI api;

  var _data = 'zero';

  void _refresh() async {
    var data = await api.getData();
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_data',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
