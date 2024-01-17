import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:built_collection/built_collection.dart';

import 'package:flutter/material.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/page_route.dart';

class NavigationHistoryObserver extends NavigatorObserver {
  /// A list of all the past routes
  final List<Route<dynamic>?> _history = <Route<dynamic>?>[];

  /// Gets a clone of the navigation history as an immutable list.
  BuiltList<Route<dynamic>> get history =>
      BuiltList<Route<dynamic>>.from(_history);

  String getHistoryToString() {
    return _history
        .map((element) => element!.settings.name)
        .toList()
        .toString();
  }

  List<Route<dynamic>> classHistories = [];

  List<String> getWidgetStack() {
    try {
      List<String> stacks = [];
      classHistories.forEach((route) {
        if (route is SheetRoute) {
          stacks.add(route.builder
                  .toString()
                  .replaceAll('Closure: (BuildContext) =>', '') +
              '(${route.settings.arguments ?? ''})');
        } else if (route is ShownyPageRoute) {
          stacks.add(route.builder
                  .toString()
                  .replaceAll('Closure: (BuildContext) =>', '') +
              '(${route.settings.arguments ?? ''})');
        } else if (route is MaterialPageRoute) {
          stacks.add(route.builder
                  .toString()
                  .replaceAll('Closure: (BuildContext) =>', '') +
              '(${route.settings.arguments ?? ''})');
        }
      });
      return stacks.toList();
    } catch (e) {
      return [];
    }
  }

  List<String?> getHistories() {
    return _history.map((element) => element!.settings.name).toList();
  }

  /// Gets the top route in the navigation stack.
  Route? get top => _history.last;

  /// A list of all routes that were popped to reach the current.
  final List<Route<dynamic>?> _poppedRoutes = <Route<dynamic>?>[];

  /// Gets a clone of the popped routes as an immutable list.
  BuiltList<Route> get poppedRoutes =>
      BuiltList<Route<dynamic>>.from(_poppedRoutes);

  /// Gets the next route in the navigation history, which is the most recently popped route.
  Route? get next => _poppedRoutes.last;

  /// A stream that broadcasts whenever the navigation history changes.
  final StreamController _historyChangeStreamController =
      StreamController.broadcast();

  /// Accessor to the history change stream.
  Stream get historyChangeStream => _historyChangeStreamController.stream;

  static final NavigationHistoryObserver _singleton =
      NavigationHistoryObserver._internal();

  NavigationHistoryObserver._internal();

  factory NavigationHistoryObserver() {
    return _singleton;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _poppedRoutes.add(_history.last);

    try {
      if (route is SheetRoute) {
        classHistories.removeLast();
      } else if (route is ShownyPageRoute) {
        classHistories.removeLast();
      } else if (route is MaterialPageRoute) {
        classHistories.removeLast();
      }
    } catch (e) {}
    _history.removeLast();
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.pop,
      newRoute: route,
      oldRoute: previousRoute,
    ));
    ShownyLog().e('History Observer : didPop \n ${getHistoryToString()}');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _history.add(route);
    _poppedRoutes.remove(route);
    try {
      if (route is SheetRoute) {
        classHistories.add(route);
      } else if (route is ShownyPageRoute) {
        classHistories.add(route);
      } else if (route is MaterialPageRoute) {
        classHistories.add(route);
      }
    } catch (e) {}
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.push,
      newRoute: route,
      oldRoute: previousRoute,
    ));
    ShownyLog().e('History Observer : didPush \n ${getHistoryToString()}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _history.remove(route);
    try {
      classHistories.remove(route);
    } catch (e) {}
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.remove,
      newRoute: route,
      oldRoute: previousRoute,
    ));
    ShownyLog().e('History Observer : didRemove \n ${getHistoryToString()}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    try {
      if (newRoute is SheetRoute) {
        classHistories.removeLast();
        classHistories.add(newRoute);
      } else if (newRoute is ShownyPageRoute) {
        classHistories.removeLast();
        classHistories.add(newRoute);
      } else if (newRoute is MaterialPageRoute) {
        classHistories.removeLast();
        classHistories.add(newRoute);
      }
    } catch (e) {}
    int oldRouteIndex = _history.indexOf(oldRoute);
    _history.replaceRange(oldRouteIndex, oldRouteIndex + 1, [newRoute]);
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.replace,
      newRoute: newRoute,
      oldRoute: oldRoute,
    ));
    ShownyLog().e('History Observer : didReplace \n ${getHistoryToString()}');
  }
}

/// A class that contains all data that needs to be broadcasted through the history change stream.
class HistoryChange {
  HistoryChange({this.action, this.newRoute, this.oldRoute});

  final NavigationStackAction? action;
  final Route<dynamic>? newRoute;
  final Route<dynamic>? oldRoute;
}

enum NavigationStackAction { push, pop, remove, replace }
