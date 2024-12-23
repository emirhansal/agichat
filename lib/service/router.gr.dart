// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:agichat/views/home/view_home.dart' as _i1;
import 'package:agichat/views/splash/view_splash.dart' as _i2;
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

abstract class $RootRouter extends _i3.RootStackRouter {
  $RootRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    RouteHome.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ViewHome(),
      );
    },
    RouteSplash.name: (routeData) {
      final args = routeData.argsAs<RouteSplashArgs>(
          orElse: () => const RouteSplashArgs());
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ViewSplash(
          key: args.key,
          isActiveLoadingIndicator: args.isActiveLoadingIndicator,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ViewHome]
class RouteHome extends _i3.PageRouteInfo<void> {
  const RouteHome({List<_i3.PageRouteInfo>? children})
      : super(
          RouteHome.name,
          initialChildren: children,
        );

  static const String name = 'RouteHome';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ViewSplash]
class RouteSplash extends _i3.PageRouteInfo<RouteSplashArgs> {
  RouteSplash({
    _i4.Key? key,
    bool? isActiveLoadingIndicator = true,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          RouteSplash.name,
          args: RouteSplashArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteSplash';

  static const _i3.PageInfo<RouteSplashArgs> page =
      _i3.PageInfo<RouteSplashArgs>(name);
}

class RouteSplashArgs {
  const RouteSplashArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final _i4.Key? key;

  final bool? isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RouteSplashArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}
