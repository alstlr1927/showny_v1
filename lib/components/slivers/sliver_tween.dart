import 'package:flutter/material.dart';

class SliverTween extends StatefulWidget {
  final Widget? child;
  final Duration duration;

  SliverTween(
      {Key? key, this.child, this.duration = const Duration(milliseconds: 300)})
      : super(key: key);

  @override
  _SliverTweenState createState() => _SliverTweenState();
}

class _SliverTweenState extends State<SliverTween> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: widget.duration,
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (ctx, dynamic anim, child) => SliverOpacity(
              opacity: anim,
              sliver: widget.child,
            ));
  }
}

class WidgetTween extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final bool isReverse;

  WidgetTween(
      {Key? key,
      this.child,
      this.isReverse = false,
      this.duration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  _WidgetTweenState createState() => _WidgetTweenState();
}

class _WidgetTweenState extends State<WidgetTween> {
  @override
  Widget build(BuildContext context) {
    Tween tween = Tween(begin: 0.0, end: 1.0);
    if (widget.isReverse) {
      tween = Tween(begin: 1.0, end: 0.0);
    }
    return TweenAnimationBuilder(
        duration: widget.duration,
        tween: tween,
        builder: (ctx, dynamic anim, child) => Opacity(
              opacity: anim,
              child: widget.child,
            ));
  }
}
