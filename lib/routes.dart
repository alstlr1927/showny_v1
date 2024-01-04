import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/screens/intro/screen/input_additional_information_screen.dart';
import 'package:showny/screens/intro/screen/email_login_screen.dart';
import 'package:showny/screens/intro/screen/login_screen.dart';
import 'package:showny/screens/intro/screen/sign_up_screen.dart';
import 'package:showny/screens/root_screen.dart';
import 'package:showny/screens/tabs/profile/other_profile_screen.dart';
import 'package:showny/screens/tabs/profile/profile_screen.dart';

const pageTransitionDuration = Duration(milliseconds: 400);

final routes = {
  RootScreen.routeName: (context) => const RootScreen(),

  // Login
  LoginScreen.routeName: (context) => const LoginScreen(),
  EmailLoginScreen.routeName: (context) => const EmailLoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  InputAdditionalInfoScreen.routeName: (context) =>
      const InputAdditionalInfoScreen(),

  // Profile
  ProfileScreen.routeName: (context) => ProfileScreen(),
  OtherProfileScreen.routeName: (context) => const OtherProfileScreen(
        memNo: '',
      ),
};

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
