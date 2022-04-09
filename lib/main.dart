import 'package:easyt/data/memory.dart';
import 'package:flutter/material.dart';

import 'data/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EasyTracking',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white, foregroundColor: Colors.black)),
        home: Test());
  }
}

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);
  final Data data = DataMemory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("EasyT")));
  }
}
