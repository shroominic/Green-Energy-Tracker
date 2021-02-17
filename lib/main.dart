import 'package:flutter/material.dart';
import 'home.dart';
import 'scraper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SmardData smard = new SmardData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Energy Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(smard),
    );
  }
}
