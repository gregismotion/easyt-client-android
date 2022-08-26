// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i13;

import '../screens/collection_screen.dart' as _i6;
import '../screens/collections_screen.dart' as _i3;
import '../screens/create_collection_screen.dart' as _i4;
import '../screens/create_data_points_screen.dart' as _i7;
import '../screens/create_named_type_screen.dart' as _i11;
import '../screens/edit_collections_screen.dart' as _i5;
import '../screens/edit_data_group_screen.dart' as _i8;
import '../screens/edit_data_point_screen.dart' as _i9;
import '../screens/edit_named_types_screen.dart' as _i12;
import '../screens/home_screen.dart' as _i1;
import '../screens/named_types_screen.dart' as _i10;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    CollectionsRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    NamedTypesRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    CollectionsRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CollectionsScreen());
    },
    CreateCollectionRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CreateCollectionScreen());
    },
    EditCollectionsRoute.name: (routeData) {
      final args = routeData.argsAs<EditCollectionsRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.EditCollectionsScreen(
              key: args.key, collections: args.collections));
    },
    CollectionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CollectionRouteArgs>(
          orElse: () => CollectionRouteArgs(
              collectionId: pathParams.getString('collectionId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.CollectionScreen(
              key: args.key, collectionId: args.collectionId));
    },
    CreateDataPointsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CreateDataPointsRouteArgs>(
          orElse: () => CreateDataPointsRouteArgs(
              collectionId: pathParams.getString('collectionId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.CreateDataPointsScreen(
              key: args.key, collectionId: args.collectionId));
    },
    EditDataGroupRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditDataGroupRouteArgs>(
          orElse: () => EditDataGroupRouteArgs(
              collectionId: pathParams.getString('collectionId'),
              groupId: pathParams.getString('groupId'),
              currentDate: pathParams.getString('currentDate')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.EditDataGroupScreen(
              key: args.key,
              collectionId: args.collectionId,
              groupId: args.groupId,
              currentDate: args.currentDate));
    },
    EditDataPointRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditDataPointRouteArgs>(
          orElse: () => EditDataPointRouteArgs(
              collectionId: pathParams.getString('collectionId'),
              groupId: pathParams.getString('groupId'),
              dataId: pathParams.getString('dataId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.EditDataPointScreen(
              key: args.key,
              collectionId: args.collectionId,
              groupId: args.groupId,
              dataId: args.dataId));
    },
    NamedTypesRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.NamedTypesScreen());
    },
    CreateNamedTypeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.CreateNamedTypeScreen());
    },
    EditNamedTypesRoute.name: (routeData) {
      final args = routeData.argsAs<EditNamedTypesRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.EditNamedTypesScreen(
              key: args.key, namedTypes: args.namedTypes));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
          _i2.RouteConfig(CollectionsRouter.name,
              path: 'collections',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(CollectionsRoute.name,
                    path: '', parent: CollectionsRouter.name),
                _i2.RouteConfig(CreateCollectionRoute.name,
                    path: 'create', parent: CollectionsRouter.name),
                _i2.RouteConfig(EditCollectionsRoute.name,
                    path: 'edit', parent: CollectionsRouter.name),
                _i2.RouteConfig(CollectionRoute.name,
                    path: 'view', parent: CollectionsRouter.name),
                _i2.RouteConfig(CreateDataPointsRoute.name,
                    path: 'addDataGroup', parent: CollectionsRouter.name),
                _i2.RouteConfig(EditDataGroupRoute.name,
                    path: 'editDataGroup', parent: CollectionsRouter.name),
                _i2.RouteConfig(EditDataPointRoute.name,
                    path: 'editDataPoint', parent: CollectionsRouter.name)
              ]),
          _i2.RouteConfig(NamedTypesRouter.name,
              path: 'named_types',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(NamedTypesRoute.name,
                    path: '', parent: NamedTypesRouter.name),
                _i2.RouteConfig(CreateNamedTypeRoute.name,
                    path: 'create', parent: NamedTypesRouter.name),
                _i2.RouteConfig(EditNamedTypesRoute.name,
                    path: 'edit', parent: NamedTypesRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class CollectionsRouter extends _i2.PageRouteInfo<void> {
  const CollectionsRouter({List<_i2.PageRouteInfo>? children})
      : super(CollectionsRouter.name,
            path: 'collections', initialChildren: children);

  static const String name = 'CollectionsRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class NamedTypesRouter extends _i2.PageRouteInfo<void> {
  const NamedTypesRouter({List<_i2.PageRouteInfo>? children})
      : super(NamedTypesRouter.name,
            path: 'named_types', initialChildren: children);

  static const String name = 'NamedTypesRouter';
}

/// generated route for
/// [_i3.CollectionsScreen]
class CollectionsRoute extends _i2.PageRouteInfo<void> {
  const CollectionsRoute() : super(CollectionsRoute.name, path: '');

  static const String name = 'CollectionsRoute';
}

/// generated route for
/// [_i4.CreateCollectionScreen]
class CreateCollectionRoute extends _i2.PageRouteInfo<void> {
  const CreateCollectionRoute()
      : super(CreateCollectionRoute.name, path: 'create');

  static const String name = 'CreateCollectionRoute';
}

/// generated route for
/// [_i5.EditCollectionsScreen]
class EditCollectionsRoute extends _i2.PageRouteInfo<EditCollectionsRouteArgs> {
  EditCollectionsRoute(
      {_i13.Key? key, required Map<String, String> collections})
      : super(EditCollectionsRoute.name,
            path: 'edit',
            args: EditCollectionsRouteArgs(key: key, collections: collections));

  static const String name = 'EditCollectionsRoute';
}

class EditCollectionsRouteArgs {
  const EditCollectionsRouteArgs({this.key, required this.collections});

  final _i13.Key? key;

  final Map<String, String> collections;

  @override
  String toString() {
    return 'EditCollectionsRouteArgs{key: $key, collections: $collections}';
  }
}

/// generated route for
/// [_i6.CollectionScreen]
class CollectionRoute extends _i2.PageRouteInfo<CollectionRouteArgs> {
  CollectionRoute({_i13.Key? key, required String collectionId})
      : super(CollectionRoute.name,
            path: 'view',
            args: CollectionRouteArgs(key: key, collectionId: collectionId),
            rawPathParams: {'collectionId': collectionId});

  static const String name = 'CollectionRoute';
}

class CollectionRouteArgs {
  const CollectionRouteArgs({this.key, required this.collectionId});

  final _i13.Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'CollectionRouteArgs{key: $key, collectionId: $collectionId}';
  }
}

/// generated route for
/// [_i7.CreateDataPointsScreen]
class CreateDataPointsRoute
    extends _i2.PageRouteInfo<CreateDataPointsRouteArgs> {
  CreateDataPointsRoute({_i13.Key? key, required String collectionId})
      : super(CreateDataPointsRoute.name,
            path: 'addDataGroup',
            args:
                CreateDataPointsRouteArgs(key: key, collectionId: collectionId),
            rawPathParams: {'collectionId': collectionId});

  static const String name = 'CreateDataPointsRoute';
}

class CreateDataPointsRouteArgs {
  const CreateDataPointsRouteArgs({this.key, required this.collectionId});

  final _i13.Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'CreateDataPointsRouteArgs{key: $key, collectionId: $collectionId}';
  }
}

/// generated route for
/// [_i8.EditDataGroupScreen]
class EditDataGroupRoute extends _i2.PageRouteInfo<EditDataGroupRouteArgs> {
  EditDataGroupRoute(
      {_i13.Key? key,
      required String collectionId,
      required String groupId,
      required String currentDate})
      : super(EditDataGroupRoute.name,
            path: 'editDataGroup',
            args: EditDataGroupRouteArgs(
                key: key,
                collectionId: collectionId,
                groupId: groupId,
                currentDate: currentDate),
            rawPathParams: {
              'collectionId': collectionId,
              'groupId': groupId,
              'currentDate': currentDate
            });

  static const String name = 'EditDataGroupRoute';
}

class EditDataGroupRouteArgs {
  const EditDataGroupRouteArgs(
      {this.key,
      required this.collectionId,
      required this.groupId,
      required this.currentDate});

  final _i13.Key? key;

  final String collectionId;

  final String groupId;

  final String currentDate;

  @override
  String toString() {
    return 'EditDataGroupRouteArgs{key: $key, collectionId: $collectionId, groupId: $groupId, currentDate: $currentDate}';
  }
}

/// generated route for
/// [_i9.EditDataPointScreen]
class EditDataPointRoute extends _i2.PageRouteInfo<EditDataPointRouteArgs> {
  EditDataPointRoute(
      {_i13.Key? key,
      required String collectionId,
      required String groupId,
      required String dataId})
      : super(EditDataPointRoute.name,
            path: 'editDataPoint',
            args: EditDataPointRouteArgs(
                key: key,
                collectionId: collectionId,
                groupId: groupId,
                dataId: dataId),
            rawPathParams: {
              'collectionId': collectionId,
              'groupId': groupId,
              'dataId': dataId
            });

  static const String name = 'EditDataPointRoute';
}

class EditDataPointRouteArgs {
  const EditDataPointRouteArgs(
      {this.key,
      required this.collectionId,
      required this.groupId,
      required this.dataId});

  final _i13.Key? key;

  final String collectionId;

  final String groupId;

  final String dataId;

  @override
  String toString() {
    return 'EditDataPointRouteArgs{key: $key, collectionId: $collectionId, groupId: $groupId, dataId: $dataId}';
  }
}

/// generated route for
/// [_i10.NamedTypesScreen]
class NamedTypesRoute extends _i2.PageRouteInfo<void> {
  const NamedTypesRoute() : super(NamedTypesRoute.name, path: '');

  static const String name = 'NamedTypesRoute';
}

/// generated route for
/// [_i11.CreateNamedTypeScreen]
class CreateNamedTypeRoute extends _i2.PageRouteInfo<void> {
  const CreateNamedTypeRoute()
      : super(CreateNamedTypeRoute.name, path: 'create');

  static const String name = 'CreateNamedTypeRoute';
}

/// generated route for
/// [_i12.EditNamedTypesScreen]
class EditNamedTypesRoute extends _i2.PageRouteInfo<EditNamedTypesRouteArgs> {
  EditNamedTypesRoute({_i13.Key? key, required Map<String, String> namedTypes})
      : super(EditNamedTypesRoute.name,
            path: 'edit',
            args: EditNamedTypesRouteArgs(key: key, namedTypes: namedTypes));

  static const String name = 'EditNamedTypesRoute';
}

class EditNamedTypesRouteArgs {
  const EditNamedTypesRouteArgs({this.key, required this.namedTypes});

  final _i13.Key? key;

  final Map<String, String> namedTypes;

  @override
  String toString() {
    return 'EditNamedTypesRouteArgs{key: $key, namedTypes: $namedTypes}';
  }
}
