import 'package:easyt/data/data.dart';
import 'package:easyt/data/memory.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/provider.dart';

// TODO: filters in collections
// TODO: collections: instead of long press, change add button to edit button (and allow multiple selections)
// TODO: filters in named types
// TODO: named types: instead of long press, change add button to edit button (and allow multiple selections)

// TODO: input validation at data point creation (match with basictype)
// TODO: datatable: instead of long press, let user select multiple entries (same type or different types?) and change add button to edit button
// TODO: prettify data table
// FIXME: can't vertically scroll data table

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
