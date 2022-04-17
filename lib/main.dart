import 'package:easyt/data/data.dart';
import 'package:easyt/data/memory.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/provider.dart';

// TODO: limit amount of data points at creation based on named type count
// TODO: only allow one kind of named type in data point creation

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    final Data _data = DataMemory();

    return MultiProvider(
      child: MaterialApp.router(
        title: "EasyT",
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
      providers: [
        ChangeNotifierProvider.value(value: TypeProvider(_data)),
        ChangeNotifierProvider.value(value: CollectionProvider(_data)),
        ChangeNotifierProvider.value(value: DataProvider(_data))
      ],
    );
  }
}
