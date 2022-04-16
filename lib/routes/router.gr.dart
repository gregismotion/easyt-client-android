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
import 'package:flutter/material.dart' as _i11;

import '../screens/collection_screen.dart' as _i6;
import '../screens/collections_screen.dart' as _i3;
import '../screens/create_collection_screen.dart' as _i4;
import '../screens/create_data_points_screen.dart' as _i7;
import '../screens/create_named_type_screen.dart' as _i9;
import '../screens/edit_collection_screen.dart' as _i5;
import '../screens/edit_named_type_screen.dart' as _i10;
import '../screens/home_screen.dart' as _i1;
import '../screens/named_types_screen.dart' as _i8;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
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
    EditCollectionRoute.name: (routeData) {
      final args = routeData.argsAs<EditCollectionRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.EditCollectionScreen(
              key: args.key,
              collectionId: args.collectionId,
              currentName: args.currentName));
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
    NamedTypesRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.NamedTypesScreen());
    },
    CreateNamedTypeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CreateNamedTypeScreen());
    },
    EditNamedTypeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditNamedTypeRouteArgs>(
          orElse: () => EditNamedTypeRouteArgs(
              namedTypeId: pathParams.getString(':namedTypeId'),
              currentValue: pathParams.getString(':currentValue')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.EditNamedTypeScreen(
              key: args.key,
              namedTypeId: args.namedTypeId,
              currentValue: args.currentValue));
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
                _i2.RouteConfig(EditCollectionRoute.name,
                    path: 'edit', parent: CollectionsRouter.name),
                _i2.RouteConfig(CollectionRoute.name,
                    path: 'view', parent: CollectionsRouter.name),
                _i2.RouteConfig(CreateDataPointsRoute.name,
                    path: 'addDataGroup', parent: CollectionsRouter.name)
              ]),
          _i2.RouteConfig(NamedTypesRouter.name,
              path: 'named_types',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(NamedTypesRoute.name,
                    path: '', parent: NamedTypesRouter.name),
                _i2.RouteConfig(CreateNamedTypeRoute.name,
                    path: 'create', parent: NamedTypesRouter.name),
                _i2.RouteConfig(EditNamedTypeRoute.name,
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
/// [_i5.EditCollectionScreen]
class EditCollectionRoute extends _i2.PageRouteInfo<EditCollectionRouteArgs> {
  EditCollectionRoute(
      {_i11.Key? key,
      required String collectionId,
      required String currentName})
      : super(EditCollectionRoute.name,
            path: 'edit',
            args: EditCollectionRouteArgs(
                key: key,
                collectionId: collectionId,
                currentName: currentName));

  static const String name = 'EditCollectionRoute';
}

class EditCollectionRouteArgs {
  const EditCollectionRouteArgs(
      {this.key, required this.collectionId, required this.currentName});

  final _i11.Key? key;

  final String collectionId;

  final String currentName;

  @override
  String toString() {
    return 'EditCollectionRouteArgs{key: $key, collectionId: $collectionId, currentName: $currentName}';
  }
}

/// generated route for
/// [_i6.CollectionScreen]
class CollectionRoute extends _i2.PageRouteInfo<CollectionRouteArgs> {
  CollectionRoute({_i11.Key? key, required String collectionId})
      : super(CollectionRoute.name,
            path: 'view',
            args: CollectionRouteArgs(key: key, collectionId: collectionId),
            rawPathParams: {'collectionId': collectionId});

  static const String name = 'CollectionRoute';
}

class CollectionRouteArgs {
  const CollectionRouteArgs({this.key, required this.collectionId});

  final _i11.Key? key;

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
  CreateDataPointsRoute({_i11.Key? key, required String collectionId})
      : super(CreateDataPointsRoute.name,
            path: 'addDataGroup',
            args:
                CreateDataPointsRouteArgs(key: key, collectionId: collectionId),
            rawPathParams: {'collectionId': collectionId});

  static const String name = 'CreateDataPointsRoute';
}

class CreateDataPointsRouteArgs {
  const CreateDataPointsRouteArgs({this.key, required this.collectionId});

  final _i11.Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'CreateDataPointsRouteArgs{key: $key, collectionId: $collectionId}';
  }
}

/// generated route for
/// [_i8.NamedTypesScreen]
class NamedTypesRoute extends _i2.PageRouteInfo<void> {
  const NamedTypesRoute() : super(NamedTypesRoute.name, path: '');

  static const String name = 'NamedTypesRoute';
}

/// generated route for
/// [_i9.CreateNamedTypeScreen]
class CreateNamedTypeRoute extends _i2.PageRouteInfo<void> {
  const CreateNamedTypeRoute()
      : super(CreateNamedTypeRoute.name, path: 'create');

  static const String name = 'CreateNamedTypeRoute';
}

/// generated route for
/// [_i10.EditNamedTypeScreen]
class EditNamedTypeRoute extends _i2.PageRouteInfo<EditNamedTypeRouteArgs> {
  EditNamedTypeRoute(
      {_i11.Key? key,
      required String namedTypeId,
      required String currentValue})
      : super(EditNamedTypeRoute.name,
            path: 'edit',
            args: EditNamedTypeRouteArgs(
                key: key, namedTypeId: namedTypeId, currentValue: currentValue),
            rawPathParams: {
              ':namedTypeId': namedTypeId,
              ':currentValue': currentValue
            });

  static const String name = 'EditNamedTypeRoute';
}

class EditNamedTypeRouteArgs {
  const EditNamedTypeRouteArgs(
      {this.key, required this.namedTypeId, required this.currentValue});

  final _i11.Key? key;

  final String namedTypeId;

  final String currentValue;

  @override
  String toString() {
    return 'EditNamedTypeRouteArgs{key: $key, namedTypeId: $namedTypeId, currentValue: $currentValue}';
  }
}
