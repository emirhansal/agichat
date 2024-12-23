import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'router.gr.dart';

@AutoRouterConfig(
  generateForDir: ['lib/views', 'lib/fragments'],
  replaceInRouteName: 'View,Route',
)
class RootRouter extends $RootRouter {
  @override
  final List<AutoRoute> routes = [
    // splash
    AutoRoute(path: '/', page: RouteSplash.page),
    // auth
    CustomRoute(page: RouteHome.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 300),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

class RooterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    // log('didPush: ${route.isActive.toString()}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // log('didPop: ${route.isActive.toString()} ${previousRoute!.isActive.toString()}');
  }
}
