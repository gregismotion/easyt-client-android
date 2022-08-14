import 'package:auto_route/auto_route.dart';
import 'package:easyt/screens/collection_screen.dart';
import 'package:easyt/screens/collections_screen.dart';
import 'package:easyt/screens/create_collection_screen.dart';
import 'package:easyt/screens/create_data_points_screen.dart';
import 'package:easyt/screens/create_named_type_screen.dart';
import 'package:easyt/screens/edit_collections_screen.dart';
import 'package:easyt/screens/edit_data_group_screen.dart';
import 'package:easyt/screens/edit_data_point_screen.dart';
import 'package:easyt/screens/edit_named_type_screen.dart';
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
          AutoRoute(path: 'edit', page: EditCollectionsScreen),
          AutoRoute(path: 'view', page: CollectionScreen),
          AutoRoute(path: 'addDataGroup', page: CreateDataPointsScreen),
          AutoRoute(path: 'editDataGroup', page: EditDataGroupScreen),
          AutoRoute(path: 'editDataPoint', page: EditDataPointScreen)
        ]),
    AutoRoute(
        path: 'named_types',
        name: 'NamedTypesRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: NamedTypesScreen),
          AutoRoute(path: 'create', page: CreateNamedTypeScreen),
          AutoRoute(path: 'edit', page: EditNamedTypeScreen),
        ]),
  ]),
])
class $AppRouter {}
