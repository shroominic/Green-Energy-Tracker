import 'package:flutter/material.dart';
import 'home.dart';
import 'data_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DataManager datamanager = new DataManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Energy Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(datamanager),
    );
  }
}
