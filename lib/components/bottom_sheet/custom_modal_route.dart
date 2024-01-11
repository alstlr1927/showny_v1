import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class CustomPopupRoute<T> extends CustomModalRoute<T> {
  /// Initializes the [PopupRoute].
  CustomPopupRoute({
    RouteSettings? settings,
    ui.ImageFilter? filter,
  }) : super(
          filter: filter,
          settings: settings,
        );

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;
}

class _ModalScopeStatus extends InheritedWidget {
  const _ModalScopeStatus({
    Key? key,
    required this.isCurrent,
    required this.canPop,
    required this.route,
    required Widget child,
  })  : assert(isCurrent != null),
        assert(canPop != null),
        assert(route != null),
        assert(child != null),
        super(key: key, child: child);

  final bool isCurrent;
  final bool canPop;
  final Route<dynamic> route;

  @override
  bool updateShouldNotify(_ModalScopeStatus old) {
    return isCurrent != old.isCurrent ||
        canPop != old.canPop ||
        route != old.route;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(FlagProperty('isCurrent',
        value: isCurrent, ifTrue: 'active', ifFalse: 'inactive'));
    description.add(FlagProperty('canPop', value: canPop, ifTrue: 'can pop'));
  }
}

abstract class CustomModalRoute<T> extends TransitionRoute<T>
    with LocalHistoryRoute<T> {
  /// Creates a route that blocks interaction with previous routes.
  CustomModalRoute({
    RouteSettings? settings,
    ui.ImageFilter? filter,
  })  : _filter = filter,
        super(settings: settings);

  /// The filter to add to the barrier.
  ///
  /// If given, this filter will be applied to the modal barrier using
  /// [BackdropFilter]. This allows blur effects, for example.
  final ui.ImageFilter? _filter;

  // The API for general users of this class

  /// Returns the modal route most closely associated with the given context.
  ///
  /// Returns null if the given context is not associated with a modal route.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ModalRoute route = ModalRoute.of(context);
  /// ```
  ///
  /// The given [BuildContext] will be rebuilt if the state of the route changes
  /// while it is visible (specifically, if [isCurrent] or [canPop] change value).
  @optionalTypeArgs
  static ModalRoute<T?>? of<T extends Object>(BuildContext context) {
    final _ModalScopeStatus? widget =
        context.dependOnInheritedWidgetOfExactType<_ModalScopeStatus>();
    return widget?.route as ModalRoute<T?>?;
  }

  /// Schedule a call to [buildTransitions].
  ///
  /// Whenever you need to change internal state for a [ModalRoute] object, make
  /// the change in a function that you pass to [setState], as in:
  ///
  /// ```dart
  /// setState(() { myState = newValue });
  /// ```
  ///
  /// If you just change the state directly without calling [setState], then the
  /// route will not be scheduled for rebuilding, meaning that its rendering
  /// will not be updated.
  @protected
  void setState(VoidCallback fn) {
    if (_scopeKey.currentState != null) {
      _scopeKey.currentState!._routeSetState(fn);
    } else {
      // The route isn't currently visible, so we don't have to call its setState
      // method, but we do still need to call the fn callback, otherwise the state
      // in the route won't be updated!
      fn();
    }
  }

  /// Returns a predicate that's true if the route has the specified name and if
  /// popping the route will not yield the same route, i.e. if the route's
  /// [willHandlePopInternally] property is false.
  ///
  /// This function is typically used with [Navigator.popUntil()].
  static RoutePredicate withName(String name) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          route.settings.name == name;
    };
  }

  // The API for subclasses to override - used by _ModalScope

  /// Override this method to build the primary content of this route.
  ///
  /// The arguments have the following meanings:
  ///
  ///  * `context`: The context in which the route is being built.
  ///  * [animation]: The animation for this route's transition. When entering,
  ///    the animation runs forward from 0.0 to 1.0. When exiting, this animation
  ///    runs backwards from 1.0 to 0.0.
  ///  * [secondaryAnimation]: The animation for the route being pushed on top of
  ///    this route. This animation lets this route coordinate with the entrance
  ///    and exit transition of routes pushed on top of this route.
  ///
  /// This method is only called when the route is first built, and rarely
  /// thereafter. In particular, it is not automatically called again when the
  /// route's state changes unless it uses [ModalRoute.of]. For a builder that
  /// is called every time the route's state changes, consider
  /// [buildTransitions]. For widgets that change their behavior when the
  /// route's state changes, consider [ModalRoute.of] to obtain a reference to
  /// the route; this will cause the widget to be rebuilt each time the route
  /// changes state.
  ///
  /// In general, [buildPage] should be used to build the page contents, and
  /// [buildTransitions] for the widgets that change as the page is brought in
  /// and out of view. Avoid using [buildTransitions] for content that never
  /// changes; building such content once from [buildPage] is more efficient.
  Widget buildPage(BuildContext context, Animation<double>? animation,
      Animation<double>? secondaryAnimation);

  /// Override this method to wrap the [child] with one or more transition
  /// widgets that define how the route arrives on and leaves the screen.
  ///
  /// By default, the child (which contains the widget returned by [buildPage])
  /// is not wrapped in any transition widgets.
  ///
  /// The [buildTransitions] method, in contrast to [buildPage], is called each
  /// time the [Route]'s state changes while it is visible (e.g. if the value of
  /// [canPop] changes on the active route).
  ///
  /// The [buildTransitions] method is typically used to define transitions
  /// that animate the new topmost route's comings and goings. When the
  /// [Navigator] pushes a route on the top of its stack, the new route's
  /// primary [animation] runs from 0.0 to 1.0. When the Navigator pops the
  /// topmost route, e.g. because the use pressed the back button, the
  /// primary animation runs from 1.0 to 0.0.
  ///
  /// The following example uses the primary animation to drive a
  /// [SlideTransition] that translates the top of the new route vertically
  /// from the bottom of the screen when it is pushed on the Navigator's
  /// stack. When the route is popped the SlideTransition translates the
  /// route from the top of the screen back to the bottom.
  ///
  /// ```dart
  /// PageRouteBuilder(
  ///   pageBuilder: (BuildContext context,
  ///       Animation<double> animation,
  ///       Animation<double> secondaryAnimation,
  ///       Widget child,
  ///   ) {
  ///     return Scaffold(
  ///       appBar: AppBar(title: Text('Hello')),
  ///       body: Center(
  ///         child: Text('Hello World'),
  ///       ),
  ///     );
  ///   },
  ///   transitionsBuilder: (
  ///       BuildContext context,
  ///       Animation<double> animation,
  ///       Animation<double> secondaryAnimation,
  ///       Widget child,
  ///    ) {
  ///     return SlideTransition(
  ///       position: Tween<Offset>(
  ///         begin: const Offset(0.0, 1.0),
  ///         end: Offset.zero,
  ///       ).animate(animation),
  ///       child: child, // child is the value returned by pageBuilder
  ///     );
  ///   },
  /// );
  /// ```
  ///
  /// We've used [PageRouteBuilder] to demonstrate the [buildTransitions] method
  /// here. The body of an override of the [buildTransitions] method would be
  /// defined in the same way.
  ///
  /// When the [Navigator] pushes a route on the top of its stack, the
  /// [secondaryAnimation] can be used to define how the route that was on
  /// the top of the stack leaves the screen. Similarly when the topmost route
  /// is popped, the secondaryAnimation can be used to define how the route
  /// below it reappears on the screen. When the Navigator pushes a new route
  /// on the top of its stack, the old topmost route's secondaryAnimation
  /// runs from 0.0 to 1.0. When the Navigator pops the topmost route, the
  /// secondaryAnimation for the route below it runs from 1.0 to 0.0.
  ///
  /// The example below adds a transition that's driven by the
  /// [secondaryAnimation]. When this route disappears because a new route has
  /// been pushed on top of it, it translates in the opposite direction of
  /// the new route. Likewise when the route is exposed because the topmost
  /// route has been popped off.
  ///
  /// ```dart
  ///   transitionsBuilder: (
  ///       BuildContext context,
  ///       Animation<double> animation,
  ///       Animation<double> secondaryAnimation,
  ///       Widget child,
  ///   ) {
  ///     return SlideTransition(
  ///       position: AlignmentTween(
  ///         begin: const Offset(0.0, 1.0),
  ///         end: Offset.zero,
  ///       ).animate(animation),
  ///       child: SlideTransition(
  ///         position: TweenOffset(
  ///           begin: Offset.zero,
  ///           end: const Offset(0.0, 1.0),
  ///         ).animate(secondaryAnimation),
  ///         child: child,
  ///       ),
  ///     );
  ///   }
  /// ```
  ///
  /// In practice the `secondaryAnimation` is used pretty rarely.
  ///
  /// The arguments to this method are as follows:
  ///
  ///  * `context`: The context in which the route is being built.
  ///  * [animation]: When the [Navigator] pushes a route on the top of its stack,
  ///    the new route's primary [animation] runs from 0.0 to 1.0. When the [Navigator]
  ///    pops the topmost route this animation runs from 1.0 to 0.0.
  ///  * [secondaryAnimation]: When the Navigator pushes a new route
  ///    on the top of its stack, the old topmost route's [secondaryAnimation]
  ///    runs from 0.0 to 1.0. When the [Navigator] pops the topmost route, the
  ///    [secondaryAnimation] for the route below it runs from 1.0 to 0.0.
  ///  * `child`, the page contents, as returned by [buildPage].
  ///
  /// See also:
  ///
  ///  * [buildPage], which is used to describe the actual contents of the page,
  ///    and whose result is passed to the `child` argument of this method.
  Widget buildTransitions(
    BuildContext context,
    Animation<double>? animation,
    Animation<double>? secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  @override
  void install() {
    super.install();
    _animationProxy = ProxyAnimation(super.animation);
    _secondaryAnimationProxy = ProxyAnimation(super.secondaryAnimation);
  }

  @override
  TickerFuture didPush() {
    if (_scopeKey.currentState != null) {
      navigator!.focusScopeNode
          .setFirstFocus(_scopeKey.currentState!.focusScopeNode);
    }
    return super.didPush();
  }

  @override
  bool didPop(T? result) {
    return super.didPop(result);
  }

  @override
  void didAdd() {
    if (_scopeKey.currentState != null) {
      navigator!.focusScopeNode
          .setFirstFocus(_scopeKey.currentState!.focusScopeNode);
    }
    super.didAdd();
  }

  // The API for subclasses to override - used by this class

  /// {@template flutter.widgets.modalRoute.barrierDismissible}
  /// Whether you can dismiss this route by tapping the modal barrier.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  ///
  /// If [barrierDismissible] is true, then tapping this barrier will cause the
  /// current route to be popped (see [Navigator.pop]) with null as the value.
  ///
  /// If [barrierDismissible] is false, then tapping the barrier has no effect.
  ///
  /// If this getter would ever start returning a different value, the
  /// [Route.changedInternalState] should be invoked so that the change can take
  /// effect.
  ///
  /// See also:
  ///
  ///  * [barrierColor], which controls the color of the scrim for this route.
  ///  * [ModalBarrier], the widget that implements this feature.
  /// {@endtemplate}
  bool get barrierDismissible;

  /// Whether the semantics of the modal barrier are included in the
  /// semantics tree.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// If [semanticsDismissible] is true, then modal barrier semantics are
  /// included in the semantics tree.
  ///
  /// If [semanticsDismissible] is false, then modal barrier semantics are
  /// excluded from the semantics tree and tapping on the modal barrier
  /// has no effect.
  bool get semanticsDismissible => true;

  /// {@template flutter.widgets.modalRoute.barrierColor}
  /// The color to use for the modal barrier. If this is null, the barrier will
  /// be transparent.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  ///
  /// The color is ignored, and the barrier made invisible, when
  /// [ModalRoute.offstage] is true.
  ///
  /// While the route is animating into position, the color is animated from
  /// transparent to the specified color.
  /// {@endtemplate}
  ///
  /// If this getter would ever start returning a different color, the
  /// [Route.changedInternalState] should be invoked so that the change can take
  /// effect.
  ///
  /// {@tool snippet}
  ///
  /// It is safe to use `navigator.context` here. For example, to make
  /// the barrier color use the theme's background color, one could say:
  ///
  /// ```dart
  /// Color get barrierColor => Theme.of(navigator.context).backgroundColor;
  /// ```
  ///
  /// The [Navigator] causes the [ModalRoute]'s modal barrier overlay entry
  /// to rebuild any time its dependencies change.
  ///
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], the widget that implements this feature.
  Color? get barrierColor;

  /// {@template flutter.widgets.modalRoute.barrierLabel}
  /// The semantic label used for a dismissible barrier.
  ///
  /// If the barrier is dismissible, this label will be read out if
  /// accessibility tools (like VoiceOver on iOS) focus on the barrier.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  /// {@endtemplate}
  ///
  /// If this getter would ever start returning a different label, the
  /// [Route.changedInternalState] should be invoked so that the change can take
  /// effect.
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], the widget that implements this feature.
  String? get barrierLabel;

  /// The curve that is used for animating the modal barrier in and out.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  ///
  /// While the route is animating into position, the color is animated from
  /// transparent to the specified [barrierColor].
  ///
  /// If this getter would ever start returning a different curve, the
  /// [changedInternalState] should be invoked so that the change can take
  /// effect.
  ///
  /// It defaults to [Curves.ease].
  ///
  /// See also:
  ///
  ///  * [barrierColor], which determines the color that the modal transitions
  ///    to.
  ///  * [Curves] for a collection of common curves.
  ///  * [AnimatedModalBarrier], the widget that implements this feature.
  Curve get barrierCurve => Curves.ease;

  /// {@template flutter.widgets.modalRoute.maintainState}
  /// Whether the route should remain in memory when it is inactive.
  ///
  /// If this is true, then the route is maintained, so that any futures it is
  /// holding from the next route will properly resolve when the next route
  /// pops. If this is not necessary, this can be set to false to allow the
  /// framework to entirely discard the route's widget hierarchy when it is not
  /// visible.
  /// {@endtemplate}
  ///
  /// If this getter would ever start returning a different value, the
  /// [changedInternalState] should be invoked so that the change can take
  /// effect.
  bool get maintainState;

  // The API for _ModalScope and HeroController

  /// Whether this route is currently offstage.
  ///
  /// On the first frame of a route's entrance transition, the route is built
  /// [Offstage] using an animation progress of 1.0. The route is invisible and
  /// non-interactive, but each widget has its final size and position. This
  /// mechanism lets the [HeroController] determine the final local of any hero
  /// widgets being animated as part of the transition.
  ///
  /// The modal barrier, if any, is not rendered if [offstage] is true (see
  /// [barrierColor]).
  ///
  /// Whenever this changes value, [changedInternalState] is called.
  bool get offstage => _offstage;
  bool _offstage = false;

  set offstage(bool value) {
    if (_offstage == value) return;
    setState(() {
      _offstage = value;
    });
    _animationProxy!.parent =
        _offstage ? kAlwaysCompleteAnimation : super.animation;
    _secondaryAnimationProxy!.parent =
        _offstage ? kAlwaysDismissedAnimation : super.secondaryAnimation;
    changedInternalState();
  }

  /// The build context for the subtree containing the primary content of this route.
  BuildContext? get subtreeContext => _subtreeKey.currentContext;

  @override
  Animation<double>? get animation => _animationProxy;
  ProxyAnimation? _animationProxy;

  @override
  Animation<double>? get secondaryAnimation => _secondaryAnimationProxy;
  ProxyAnimation? _secondaryAnimationProxy;

  final List<WillPopCallback> _willPopCallbacks = <WillPopCallback>[];

  /// Returns [RoutePopDisposition.doNotPop] if any of callbacks added with
  /// [addScopedWillPopCallback] returns either false or null. If they all
  /// return true, the base [Route.willPop]'s result will be returned. The
  /// callbacks will be called in the order they were added, and will only be
  /// called if all previous callbacks returned true.
  ///
  /// Typically this method is not overridden because applications usually
  /// don't create modal routes directly, they use higher level primitives
  /// like [showDialog]. The scoped [WillPopCallback] list makes it possible
  /// for ModalRoute descendants to collectively define the value of `willPop`.
  ///
  /// See also:
  ///
  ///  * [Form], which provides an `onWillPop` callback that uses this mechanism.
  ///  * [addScopedWillPopCallback], which adds a callback to the list this
  ///    method checks.
  ///  * [removeScopedWillPopCallback], which removes a callback from the list
  ///    this method checks.
  @override
  Future<RoutePopDisposition> willPop() async {
    final _ModalScopeState<T> scope = _scopeKey.currentState!;
    assert(scope != null);
    for (final WillPopCallback callback
        in List<WillPopCallback>.from(_willPopCallbacks)) {
      if (await callback() != true) return RoutePopDisposition.doNotPop;
    }
    return await super.willPop();
  }

  /// Enables this route to veto attempts by the user to dismiss it.
  ///
  /// This callback is typically added using a [WillPopScope] widget. That
  /// widget finds the enclosing [ModalRoute] and uses this function to register
  /// this callback:
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return WillPopScope(
  ///     onWillPop: askTheUserIfTheyAreSure,
  ///     child: ...,
  ///   );
  /// }
  /// ```
  ///
  /// This callback runs asynchronously and it's possible that it will be called
  /// after its route has been disposed. The callback should check [State.mounted]
  /// before doing anything.
  ///
  /// A typical application of this callback would be to warn the user about
  /// unsaved [Form] data if the user attempts to back out of the form. In that
  /// case, use the [Form.onWillPop] property to register the callback.
  ///
  /// To register a callback manually, look up the enclosing [ModalRoute] in a
  /// [State.didChangeDependencies] callback:
  ///
  /// ```dart
  /// ModalRoute<dynamic> _route;
  ///
  /// @override
  /// void didChangeDependencies() {
  ///  super.didChangeDependencies();
  ///  _route?.removeScopedWillPopCallback(askTheUserIfTheyAreSure);
  ///  _route = ModalRoute.of(context);
  ///  _route?.addScopedWillPopCallback(askTheUserIfTheyAreSure);
  /// }
  /// ```
  ///
  /// If you register a callback manually, be sure to remove the callback with
  /// [removeScopedWillPopCallback] by the time the widget has been disposed. A
  /// stateful widget can do this in its dispose method (continuing the previous
  /// example):
  ///
  /// ```dart
  /// @override
  /// void dispose() {
  ///   _route?.removeScopedWillPopCallback(askTheUserIfTheyAreSure);
  ///   _route = null;
  ///   super.dispose();
  /// }
  /// ```
  ///
  /// See also:
  ///
  ///  * [WillPopScope], which manages the registration and unregistration
  ///    process automatically.
  ///  * [Form], which provides an `onWillPop` callback that uses this mechanism.
  ///  * [willPop], which runs the callbacks added with this method.
  ///  * [removeScopedWillPopCallback], which removes a callback from the list
  ///    that [willPop] checks.
  void addScopedWillPopCallback(WillPopCallback callback) {
    assert(_scopeKey.currentState != null,
        'Tried to add a willPop callback to a route that is not currently in the tree.');
    _willPopCallbacks.add(callback);
  }

  /// Remove one of the callbacks run by [willPop].
  ///
  /// See also:
  ///
  ///  * [Form], which provides an `onWillPop` callback that uses this mechanism.
  ///  * [addScopedWillPopCallback], which adds callback to the list
  ///    checked by [willPop].
  void removeScopedWillPopCallback(WillPopCallback callback) {
    assert(_scopeKey.currentState != null,
        'Tried to remove a willPop callback from a route that is not currently in the tree.');
    _willPopCallbacks.remove(callback);
  }

  /// True if one or more [WillPopCallback] callbacks exist.
  ///
  /// This method is used to disable the horizontal swipe pop gesture supported
  /// by [MaterialPageRoute] for [TargetPlatform.iOS] and
  /// [TargetPlatform.macOS]. If a pop might be vetoed, then the back gesture is
  /// disabled.
  ///
  /// The [buildTransitions] method will not be called again if this changes,
  /// since it can change during the build as descendants of the route add or
  /// remove callbacks.
  ///
  /// See also:
  ///
  ///  * [addScopedWillPopCallback], which adds a callback.
  ///  * [removeScopedWillPopCallback], which removes a callback.
  ///  * [willHandlePopInternally], which reports on another reason why
  ///    a pop might be vetoed.
  @protected
  bool get hasScopedWillPopCallback {
    return _willPopCallbacks.isNotEmpty;
  }

  @override
  void didChangePrevious(Route<dynamic>? previousRoute) {
    super.didChangePrevious(previousRoute);
    changedInternalState();
  }

  @override
  void changedInternalState() {
    super.changedInternalState();
    setState(() {
      /* internal state already changed */
    });

    _modalBarrier.markNeedsBuild();
    _modalScope.maintainState = maintainState;
  }

  @override
  void changedExternalState() {
    super.changedExternalState();
    if (_scopeKey.currentState != null)
      _scopeKey.currentState!._forceRebuildPage();
  }

  /// Whether this route can be popped.
  ///
  /// When this changes, if the route is visible, the route will
  /// rebuild, and any widgets that used [ModalRoute.of] will be
  /// notified.
  bool get canPop => !isFirst || willHandlePopInternally;

  // Internals

  final GlobalKey<_ModalScopeState<T>> _scopeKey =
      GlobalKey<_ModalScopeState<T>>();
  final GlobalKey _subtreeKey = GlobalKey();
  final PageStorageBucket _storageBucket = PageStorageBucket();
  Color _kTransparent = Color(0x00000000);

  // one of the builders
  late OverlayEntry _modalBarrier;

  Widget _buildModalBarrier(BuildContext context) {
    Widget barrier;
    if (barrierColor != null && barrierColor!.alpha != 0 && !offstage) {
      // changedInternalState is called if barrierColor or offstage updates
      assert(barrierColor != _kTransparent);
      final Animation<Color?> color = animation!.drive(
        ColorTween(
          begin: _kTransparent,
          end:
              barrierColor, // changedInternalState is called if barrierColor updates
        ).chain(CurveTween(
            curve:
                barrierCurve)), // changedInternalState is called if barrierCurve updates
      );

      barrier = AnimatedModalBarrier(
        color: color,
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
      );
    } else {
      barrier = ModalBarrier(
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
      );
    }
    if (_filter != null) {
      barrier = BackdropFilter(
        filter: _filter!,
        child: barrier,
      );
    }
    barrier = IgnorePointer(
      ignoring: animation!.status ==
              AnimationStatus
                  .reverse || // changedInternalState is called when animation.status updates
          animation!.status ==
              AnimationStatus
                  .dismissed, // dismissed is possible when doing a manual pop gesture
      child: barrier,
    );
    if (semanticsDismissible && barrierDismissible) {
      // To be sorted after the _modalScope.
      barrier = Semantics(
        sortKey: const OrdinalSortKey(1.0),
        child: barrier,
      );
    }

    return barrier;
  }

  // We cache the part of the modal scope that doesn't change from frame to
  // frame so that we minimize the amount of building that happens.
  Widget? _modalScopeCache;

  // one of the builders
  Widget _buildModalScope(BuildContext context) {
    // To be sorted before the _modalBarrier.
    return _modalScopeCache ??= Semantics(
        sortKey: const OrdinalSortKey(0.0),
        child: _ModalScope<T>(
          key: _scopeKey,
          route: this,
          // _ModalScope calls buildTransitions() and buildChild(), defined above
        ));
  }

  late OverlayEntry _modalScope;

  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    yield _modalBarrier = OverlayEntry(builder: _buildModalBarrier);
    yield _modalScope =
        OverlayEntry(builder: _buildModalScope, maintainState: maintainState);
  }

  @override
  String toString() =>
      '${objectRuntimeType(this, 'ModalRoute')}($settings, animation)';
}

class _ModalScope<T> extends StatefulWidget {
  const _ModalScope({
    Key? key,
    this.route,
  }) : super(key: key);

  final CustomModalRoute<T>? route;

  @override
  _ModalScopeState<T> createState() => _ModalScopeState<T>();
}

class _ModalScopeState<T> extends State<_ModalScope<T>> {
  // We cache the result of calling the route's buildPage, and clear the cache
  // whenever the dependencies change. This implements the contract described in
  // the documentation for buildPage, namely that it gets called once, unless
  // something like a ModalRoute.of() dependency triggers an update.
  Widget? _page;

  // This is the combination of the two animations for the route.
  late Listenable _listenable;

  /// The node this scope will use for its root [FocusScope] widget.
  final FocusScopeNode focusScopeNode =
      FocusScopeNode(debugLabel: '$_ModalScopeState Focus Scope');

  @override
  void initState() {
    super.initState();
    final List<Listenable?> animations = <Listenable?>[
      if (widget.route!.animation != null) widget.route!.animation,
      if (widget.route!.secondaryAnimation != null)
        widget.route!.secondaryAnimation,
    ];
    _listenable = Listenable.merge(animations);
    if (widget.route!.isCurrent) {
      widget.route!.navigator!.focusScopeNode.setFirstFocus(focusScopeNode);
    }
  }

  @override
  void didUpdateWidget(_ModalScope<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.route == oldWidget.route);
    if (widget.route!.isCurrent) {
      widget.route!.navigator!.focusScopeNode.setFirstFocus(focusScopeNode);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _page = null;
  }

  void _forceRebuildPage() {
    setState(() {
      _page = null;
    });
  }

  @override
  void dispose() {
    focusScopeNode.dispose();
    super.dispose();
  }

  bool get _shouldIgnoreFocusRequest {
    return widget.route!.animation?.status == AnimationStatus.reverse ||
        (widget.route!.navigator?.userGestureInProgress ?? false);
  }

  // This should be called to wrap any changes to route.isCurrent, route.canPop,
  // and route.offstage.
  void _routeSetState(VoidCallback fn) {
    if (widget.route!.isCurrent && !_shouldIgnoreFocusRequest) {
      widget.route!.navigator!.focusScopeNode.setFirstFocus(focusScopeNode);
    }
    setState(fn);
  }

  static final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{
    DismissIntent: _DismissModalAction(),
  };

  @override
  Widget build(BuildContext context) {
    return _ModalScopeStatus(
      route: widget.route!,
      isCurrent:
          widget.route!.isCurrent, // _routeSetState is called if this updates
      canPop: widget.route!.canPop, // _routeSetState is called if this updates
      child: Offstage(
        offstage:
            widget.route!.offstage, // _routeSetState is called if this updates
        child: PageStorage(
          bucket: widget.route!._storageBucket, // immutable
          child: Actions(
            actions: _actionMap,
            child: FocusScope(
              node: focusScopeNode, // immutable
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _listenable, // immutable
                  builder: (BuildContext context, Widget? child) {
                    return widget.route!.buildTransitions(
                      context,
                      widget.route!.animation,
                      widget.route!.secondaryAnimation,
                      // This additional AnimatedBuilder is include because if the
                      // value of the userGestureInProgressNotifier changes, it's
                      // only necessary to rebuild the IgnorePointer widget and set
                      // the focus node's ability to focus.
                      AnimatedBuilder(
                        animation: widget.route!.navigator
                                ?.userGestureInProgressNotifier ??
                            ValueNotifier<bool>(false),
                        builder: (BuildContext context, Widget? child) {
                          final bool ignoreEvents = _shouldIgnoreFocusRequest;
                          focusScopeNode.canRequestFocus = !ignoreEvents;
                          return IgnorePointer(
                            ignoring: ignoreEvents,
                            child: child,
                          );
                        },
                        child: child,
                      ),
                    );
                  },
                  child: _page ??= RepaintBoundary(
                    key: widget.route!._subtreeKey, // immutable
                    child: Builder(
                      builder: (BuildContext context) {
                        return widget.route!.buildPage(
                          context,
                          widget.route!.animation,
                          widget.route!.secondaryAnimation,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DismissModalAction extends DismissAction {
  @override
  Object invoke(DismissIntent intent) {
    return Navigator.of(primaryFocus!.context!).maybePop();
  }
}

class CustomModalBarrier extends StatelessWidget {
  /// Creates a widget that blocks user interaction.
  CustomModalBarrier({
    Key? key,
    this.color,
    this.onPressed,
    this.dismissible = true,
    this.semanticsLabel,
    this.barrierSemanticsDismissible = true,
  }) : super(key: key);

  /// If non-null, fill the barrier with this color.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierColor], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final Color? color;

  /// Whether touching the barrier will pop the current route off the [Navigator].
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierDismissible], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final bool dismissible;

  /// Whether the modal barrier semantics are included in the semantics tree.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.semanticsDismissible], which controls this property for
  ///    the [ModalBarrier] built by [ModalRoute] pages.
  final bool? barrierSemanticsDismissible;

  /// Semantics label used for the barrier if it is [dismissible].
  ///
  /// The semantics label is read out by accessibility tools (e.g. TalkBack
  /// on Android and VoiceOver on iOS) when the barrier is focused.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierLabel], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final String? semanticsLabel;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(!dismissible ||
        semanticsLabel == null ||
        debugCheckHasDirectionality(context));
    bool? platformSupportsDismissingBarrier;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        platformSupportsDismissingBarrier = false;
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        platformSupportsDismissingBarrier = true;
        break;
    }
    assert(platformSupportsDismissingBarrier != null);
    final bool semanticsDismissible =
        dismissible && platformSupportsDismissingBarrier;
    final bool modalBarrierSemanticsDismissible =
        barrierSemanticsDismissible ?? semanticsDismissible;
    return BlockSemantics(
      child: ExcludeSemantics(
        // On Android, the back button is used to dismiss a modal. On iOS, some
        // modal barriers are not dismissible in accessibility mode.
        excluding: !semanticsDismissible || !modalBarrierSemanticsDismissible,
        child: GestureDetector(
          onTap: onPressed ??
              () {
                if (dismissible) {
                  Navigator.maybePop(context);
                }
              },
          child: Semantics(
            label: semanticsDismissible ? semanticsLabel : null,
            textDirection: semanticsDismissible && semanticsLabel != null
                ? Directionality.of(context)
                : null,
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,
              opaque: true,
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: color == null
                    ? null
                    : DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAnimatedModalBarrier extends AnimatedWidget {
  /// Creates a widget that blocks user interaction.
  CustomAnimatedModalBarrier({
    Key? key,
    required Animation<Color?> color,
    this.dismissible = true,
    this.animationProxy,
    this.semanticsLabel,
    this.barrierSemanticsDismissible,
  }) : super(key: key, listenable: color);

  ProxyAnimation? animationProxy;

  /// If non-null, fill the barrier with this color.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierColor], which controls this property for the
  ///    [AnimatedModalBarrier] built by [ModalRoute] pages.
  Animation<Color> get color => listenable as Animation<Color>;

  /// Whether touching the barrier will pop the current route off the [Navigator].
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierDismissible], which controls this property for the
  ///    [AnimatedModalBarrier] built by [ModalRoute] pages.
  final bool dismissible;

  /// Semantics label used for the barrier if it is [dismissible].
  ///
  /// The semantics label is read out by accessibility tools (e.g. TalkBack
  /// on Android and VoiceOver on iOS) when the barrier is focused.
  /// See also:
  ///
  ///  * [ModalRoute.barrierLabel], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final String? semanticsLabel;

  /// Whether the modal barrier semantics are included in the semantics tree.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.semanticsDismissible], which controls this property for
  ///    the [ModalBarrier] built by [ModalRoute] pages.
  final bool? barrierSemanticsDismissible;

  int delay = 500;
  int lastClickTime = 0;

  @override
  Widget build(BuildContext context) {
    return CustomModalBarrier(
      onPressed: () {
        int now = DateTime.now().millisecondsSinceEpoch;

        if (now - lastClickTime > delay) {
          if (dismissible) {
            if (animationProxy?.isCompleted ?? true) {
              Navigator.of(context).maybePop();
            }
          }
          lastClickTime = now;
        }
      },
      color: color.value,
      dismissible: dismissible,
      semanticsLabel: semanticsLabel,
      barrierSemanticsDismissible: barrierSemanticsDismissible,
    );
  }
}
