import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final NestedNavigatorObserver nestedNavigatorObserver =
    NestedNavigatorObserver();

class NestedNavigatorObserver extends NavigatorObserver {
  final List<String> pages = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    pages.add(route.settings.name ?? '');
    print('RZ nestedNavObserver: didPush -  $pages.toString()');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute == null) return;
    final index =
        pages.indexWhere((element) => newRoute.settings.name == element);
    pages[index] = newRoute.settings.name ?? '';
    print('RZ nestedNavObserver: didReplace -  $pages.toString()');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    pages.remove(route.settings.name ?? '');
    print('RZ nestedNavObserver: didRemove - $pages.toString()');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    pages.remove(route.settings.name ?? '');
    print('RZ nestedNavObserver: didPop - $pages.toString()');
  }
}
