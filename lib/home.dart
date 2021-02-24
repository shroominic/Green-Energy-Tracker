import 'package:flutter/material.dart';
import 'scraper.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.smard, {Key key}) : super(key: key);
  final SmardData smard;

  @override
  _MyHomePageState createState() => _MyHomePageState(smard);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.smard);
  final SmardData smard;

  final title = "Green Energy Tracker";

  var _data = "0";

  void _refresh() async {
    var data = await smard.getCurrentGreenEnergyPercentage();
    setState(() {
      _data = data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_data %',
              style: TextStyle(fontSize: 69, fontWeight: FontWeight.bold),
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
