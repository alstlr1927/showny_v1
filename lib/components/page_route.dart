import 'package:flutter/material.dart';

const pageTransitionDuration = Duration(milliseconds: 400);

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
