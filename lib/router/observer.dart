import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print('${previousRoute?.settings.name} --> ${route.settings.name}');
  }
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    print('${previousRoute?.path} --> ${route.path}');
  }
  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    print('${previousRoute.path} --> ${route.path}');
  }
}