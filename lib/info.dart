import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

String beschreibung = '''Die App Green Energy Tracker bietet eine Möglichkeit für jeden Einzelnen, etwas für die Umwelt zu tun, indem man seinen täglichen Stromverbrauch an die Verfügbarkeit von Erneuerbaren Energien anpasst.''';
String erklaerungsText = '''
Mit dem Anteil der Erneuerbaren Energien (%), kann man seinen Energiehaushalt an die Verfügbarkeit der Erneuerbaren Energien im deutschen Stromnetz anzupassen.
Anhand des minimal und maximal Wertes kann man den Aktuellen Wert in Vergleich setzen. Dadurch kann man entscheiden ob gerade viel oder wenig erneuerbare Energien im Stromnetz sind. Der minimal/maximal Wert bezieht sich auf die letzten 24 Stunden. 
''';
String datenText = '''
Alle Daten werden Intern berechnet und vom Server der Bundesnetzagentur (Smard.de) bezogen.
Diese Daten sind kostenfrei zur Verfügung und unterliegen der Lizenz CC BY 4.0.
''';
String lizenz = ''' 2021 Dominic Bäumer''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                borderOnForeground: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text('App Beschreibung', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ), 
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(beschreibung),
                        )
                    ],
                  ),
              ),
              Card(
                elevation: 2,
                borderOnForeground: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text('Information zur Nutzung', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ), 
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(erklaerungsText),
                        )
                    ],
                  ),
              ),
              Card(
                elevation: 2,
                borderOnForeground: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text('Daten', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ), 
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(datenText),
                        )
                    ],
                  ),
              ),
              Spacer(),
              Card(
                elevation: 0,
                borderOnForeground: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.copyright, size: 14,),
                            Text(lizenz),
                          ],
                        ),
                        )
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}