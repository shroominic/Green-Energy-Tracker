import 'package:flutter/material.dart';
import 'package:green_energy_tracker/info.dart';
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
  double _percentage = 0;
  double _percentageMinimum = 0;
  double _percentageMaximum = 0;

  init() {
    loadData();
  }

  Future<bool> loadData() async {
    await datamanager.init();
    var percentage = await datamanager.currentGreenEnergyPercentage;
    var percentageMaximum = await datamanager.greenEnergy24maximum;
    var percentageMinimum = await datamanager.greenEnergy24minimum;
    setState(() {
      _percentage = percentage;
      _percentageMaximum = percentageMaximum;
      _percentageMinimum = percentageMinimum;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Spacer(
                  flex: 2,
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
                          ),
                        ],
                      )),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                '24h Minimum:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$_percentageMinimum',
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '%',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 27,
                                      fontFamily: '',
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '24h Maximum:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_percentageMaximum',
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '%',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontFamily: '',
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FutureBuilder(
          builder: (context, snapshot) {
            return Icon(Icons.refresh);
          },
          future: init(),
        ),
        onPressed: init,
      ),
    );
  }
}
