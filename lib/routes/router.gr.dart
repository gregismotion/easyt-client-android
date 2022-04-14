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
import 'package:flutter/material.dart' as _i8;

import '../screens/collection_screen.dart' as _i5;
import '../screens/collections_screen.dart' as _i3;
import '../screens/create_collection_screen.dart' as _i4;
import '../screens/create_named_type_screen.dart' as _i7;
import '../screens/home_screen.dart' as _i1;
import '../screens/named_types_screen.dart' as _i6;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
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
    CollectionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CollectionRouteArgs>(
          orElse: () => CollectionRouteArgs(
              collectionId: pathParams.getString('collectionId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.CollectionScreen(
              key: args.key, collectionId: args.collectionId));
    },
    NamedTypesRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.NamedTypesScreen());
    },
    CreateNamedTypeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.CreateNamedTypeScreen());
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
                _i2.RouteConfig(CollectionRoute.name,
                    path: 'view', parent: CollectionsRouter.name)
              ]),
          _i2.RouteConfig(NamedTypesRouter.name,
              path: 'named_types',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(NamedTypesRoute.name,
                    path: '', parent: NamedTypesRouter.name),
                _i2.RouteConfig(CreateNamedTypeRoute.name,
                    path: 'create', parent: NamedTypesRouter.name)
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
/// [_i5.CollectionScreen]
class CollectionRoute extends _i2.PageRouteInfo<CollectionRouteArgs> {
  CollectionRoute({_i8.Key? key, required String collectionId})
      : super(CollectionRoute.name,
            path: 'view',
            args: CollectionRouteArgs(key: key, collectionId: collectionId),
            rawPathParams: {'collectionId': collectionId});

  static const String name = 'CollectionRoute';
}

class CollectionRouteArgs {
  const CollectionRouteArgs({this.key, required this.collectionId});

  final _i8.Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'CollectionRouteArgs{key: $key, collectionId: $collectionId}';
  }
}

/// generated route for
/// [_i6.NamedTypesScreen]
class NamedTypesRoute extends _i2.PageRouteInfo<void> {
  const NamedTypesRoute() : super(NamedTypesRoute.name, path: '');

  static const String name = 'NamedTypesRoute';
}

/// generated route for
/// [_i7.CreateNamedTypeScreen]
class CreateNamedTypeRoute extends _i2.PageRouteInfo<void> {
  const CreateNamedTypeRoute()
      : super(CreateNamedTypeRoute.name, path: 'create');

  static const String name = 'CreateNamedTypeRoute';
}
