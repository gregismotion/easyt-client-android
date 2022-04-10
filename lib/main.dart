
import 'package:easyt/data/data.dart';
import 'package:easyt/data/memory.dart';
import 'package:easyt/screens/collections_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: const MaterialApp(title: "EasyT", home: CollectionsScreen()),
      providers: [ChangeNotifierProvider.value(value: DataProvider())],
    );
  }
}