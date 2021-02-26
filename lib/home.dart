import 'package:flutter/material.dart';
import 'scraper.dart' as scraper;
import 'data_manager.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.datamanager, {Key key}) : super(key: key);
  final DataManager datamanager;

  @override
  _MyHomePageState createState() => _MyHomePageState(datamanager);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.datamanager);
  final DataManager datamanager;

  final title = "Green Energy Tracker";

  var _data = "0";

  void _refresh() async {
    var data = await scraper.getCurrentGreenEnergyPercentage();
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
          children: [
            Spacer(
              flex: 1,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Anteil der Erneuerbaren Energien:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$_data',
                          style: TextStyle(
                            fontSize: 69,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '%',
                          style: TextStyle(
                            fontFamily: '',
                            fontStyle: FontStyle.normal,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
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
