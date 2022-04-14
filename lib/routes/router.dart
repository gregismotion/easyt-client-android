import 'package:auto_route/auto_route.dart';
import 'package:easyt/screens/collections_screen.dart';
import 'package:easyt/screens/create_collection_screen.dart';
import 'package:easyt/screens/home_screen.dart';
import 'package:easyt/screens/named_types_screen.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: <AutoRoute>[
  AutoRoute(path: '/', page: HomeScreen, children: [
    AutoRoute(
        path: 'collections',
        name: 'CollectionsRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: CollectionsScreen),
          AutoRoute(path: 'create', page: CreateCollectionScreen),
        ]),
    AutoRoute(
        path: 'named_types',
        name: 'NamedTypesRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: NamedTypesScreen),
          AutoRoute(path: 'create', page: EmptyRouterPage),
        ]),
  ]),
])
class $AppRouter {}