import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/screens/common/history_observer.dart';
import 'package:showny/screens/main/root_screen.dart';

const pageTransitionDuration = Duration(milliseconds: 400);

class PageName {
  static const String LANDING = '/Landing';
  static const String EMAIL_LOGIN = '/EmailLogin';
  static const String EMAIL_SIGNUP = '/EmailSignUp';
  static const String OTHER_PROFILE = '/OtherProfile';
  static const String MY_SHOPPING = '/MyShowpping';
  static const String RESELECT_BATTLE = '/ReselectBattle';
  static const String BATTLE_UPLOAD = '/BattleUpload';
  static const String SELECT_STYLEUP = '/SelectStyleup';
  static const String STORE_SEARCH = '/StoreSearch';
}

class ShownyRouter {
  bool isPageExist({String? pageName}) {
    return NavigationHistoryObserver().getHistories().contains(pageName);
  }

  // 해당 페이지를 포함한 모든 스택
  popWhile(context, {String? pageName}) async {
    if (NavigationHistoryObserver().getHistories().contains(pageName)) {
      debugPrint('❗️popWhile : ${NavigationHistoryObserver().getHistories()}');
      Navigator.pop(context);
      popWhile(context, pageName: pageName);
    }
    await Future.delayed(const Duration(milliseconds: 300));
  }

  // 해당 페이지를 제외한 모든 스택
  popUntil(context, {String? pageName}) {
    if (NavigationHistoryObserver().getHistories().contains(pageName)) {
      Navigator.popUntil(context, (route) => route.settings.name == pageName);
    }
  }

  // 해당 페이지만 스택에서 제거
  popOnly(context, {String? pageName}) {
    var routes = NavigationHistoryObserver().history;
    Route? route =
        routes.lastOrNullWhere((element) => element.settings.name == pageName);
    if (route != null) {
      if (route.isCurrent) {
        Navigator.pop(context);
        return;
      }
      Navigator.removeRoute(context, route);
    }
  }

  void replaceMain(context) {
    Navigator.of(context).pushAndRemoveUntil(
      FadePageRoute(
        builder: (ctx) => const MainLanding(),
        settings: const RouteSettings(name: PageName.LANDING),
      ),
      (Route<dynamic> route) => false,
    );
  }
}

class ShownyPageRoute<T> extends PageRoute<T> {
  /// Construct a DubPageRoute whose contents are defined by [builder].
  ///
  /// The values of [builder], [maintainState], and [fullScreenDialog] must not
  /// be null.
  ShownyPageRoute({
    required this.builder,
    RouteSettings? settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => pageTransitionDuration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    return previousRoute is ShownyPageRoute ||
        previousRoute is CupertinoPageRoute;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return (nextRoute is ShownyPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget result = builder(context);
    assert(() {
      if (result == null) {
        throw FlutterError(
            'The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    final PageTransitionsTheme newTheme = const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        });
    return newTheme.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }

  // @override
  // Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
  //   return FadeTransition(
  //     opacity: animation,
  //     child: builder(context),
  //   );
  // }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}

class FadePageRoute<T> extends PageRoute<T> {
  FadePageRoute({
    RouteSettings? settings,
    required this.builder,
  }) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => pageTransitionDuration;

  @override
  bool get opaque => false;

  final WidgetBuilder builder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}

class SheetRoute<T> extends PageRoute<T> {
  /// Construct a DubPageRoute whose contents are defined by [builder].
  ///
  /// The values of [builder], [maintainState], and [fullScreenDialog] must not
  /// be null.
  SheetRoute({
    required this.builder,
    RouteSettings? settings,
    Color? barrierColor,
    this.maintainState = true,
  })  : barrierColors = barrierColor ?? Colors.black38,
        assert(builder != null),
        assert(maintainState != null),
        super(settings: settings, fullscreenDialog: true);

  final Color barrierColors;

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => pageTransitionDuration;

  @override
  Color get barrierColor => barrierColors;

  @override
  String? get barrierLabel => null;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    return previousRoute is CupertinoPageRoute;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    return (nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget result = builder(context);
    assert(() {
      if (result == null) {
        throw FlutterError(
            'The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
  }

  @override
  Duration get reverseTransitionDuration => pageTransitionDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;

    final PageTransitionsTheme newTheme = const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        });

    return newTheme.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}
