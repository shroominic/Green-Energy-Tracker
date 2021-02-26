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

  // AppBar Text
  final title = "Green Energy Tracker";

  // share of renewable energies
  var _percentage = "0";

  set percentage(String percentage) {
    setState(() {
      _percentage = percentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
                    child: FutureBuilder(
                        future: scraper.getCurrentGreenEnergyPercentage(),
                        builder: (context, snapshot) {
                          // filter null values
                          if (snapshot.data != null) {
                            _percentage = snapshot.data.toString();
                          }
                          return Column(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$_percentage',
                                    style: TextStyle(
                                      fontSize: 69,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 42,
                                      fontFamily: '',
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
