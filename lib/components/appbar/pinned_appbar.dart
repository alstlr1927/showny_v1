import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

typedef TitleWidgetBuilder = Widget Function(
    BuildContext context, double maxOffset, double offset);

const double kAppbarHeight = 48;
const double kAppbarExpandedHeight = 88;

class _FloatingAppBar extends StatefulWidget {
  const _FloatingAppBar({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  _FloatingAppBarState createState() => _FloatingAppBarState();
}

class _FloatingAppBarState extends State<_FloatingAppBar> {
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_position != null)
      _position!.isScrollingNotifier.removeListener(_isScrollingListener);
    _position = Scrollable.of(context)?.position;
    if (_position != null)
      _position!.isScrollingNotifier.addListener(_isScrollingListener);
  }

  @override
  void dispose() {
    if (_position != null)
      _position!.isScrollingNotifier.removeListener(_isScrollingListener);
    super.dispose();
  }

  RenderSliverFloatingPersistentHeader? _headerRenderer() {
    return context
        .findAncestorRenderObjectOfType<RenderSliverFloatingPersistentHeader>();
  }

  void _isScrollingListener() {
    if (_position == null) return;

    // When a scroll stops, then maybe snap the appbar into view.
    // Similarly, when a scroll starts, then maybe stop the snap animation.
    final RenderSliverFloatingPersistentHeader? header = _headerRenderer();
    if (_position!.isScrollingNotifier.value)
      header?.maybeStopSnapAnimation(_position!.userScrollDirection);
    else
      header?.maybeStartSnapAnimation(_position!.userScrollDirection);
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}

class _PinnedAppBarDelegate extends SliverPersistentHeaderDelegate {
  _PinnedAppBarDelegate({
    required this.onPop,
    required this.leading,
    required this.automaticallyImplyLeading,
    required this.builder,
    required this.actions,
    required this.flexibleSpace,
    required this.bottom,
    required this.elevation,
    required this.shadowColor,
    required this.forceElevated,
    required this.backgroundColor,
    required this.brightness,
    required this.iconTheme,
    required this.actionsIconTheme,
    required this.textTheme,
    required this.reverseBrightness,
    required this.centerTitle,
    required this.excludeHeaderSemantics,
    required this.titleSpacing,
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.topPadding,
    required this.floating,
    required this.pinned,
    required this.vsync,
    required this.snapConfiguration,
    required this.stretchConfiguration,
    required this.showOnScreenConfiguration,
    required this.shape,
    required this.toolbarHeight,
    required this.leadingWidth,
    required this.denseActionPadding,
  })  : assert(
          !floating ||
              (snapConfiguration == null &&
                  showOnScreenConfiguration == null) ||
              vsync != null,
          'vsync cannot be null when snapConfiguration or showOnScreenConfiguration is not null, and floating is true',
        ),
        _bottomHeight = bottom?.preferredSize.height ?? 0.0;

  final VoidCallback? onPop;
  final Widget? leading;
  final bool? automaticallyImplyLeading;
  final TitleWidgetBuilder? builder;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? shadowColor;
  final bool? forceElevated;
  final Color? backgroundColor;
  final Brightness? brightness;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextTheme? textTheme;
  final bool? reverseBrightness;
  final bool? centerTitle;
  final bool? excludeHeaderSemantics;
  final double? titleSpacing;
  final double? expandedHeight;
  final double? collapsedHeight;
  final double? topPadding;
  final bool floating;
  final bool? pinned;
  final ShapeBorder? shape;
  final double? toolbarHeight;
  final double? leadingWidth;
  final bool? denseActionPadding;

  final double _bottomHeight;

  @override
  double get minExtent => collapsedHeight!;

  @override
  double get maxExtent => math.max(
      topPadding! +
          (expandedHeight ?? (toolbarHeight ?? kToolbarHeight) + _bottomHeight),
      minExtent);

  @override
  final TickerProvider? vsync;

  @override
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  @override
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  @override
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double visibleMainHeight = maxExtent - shrinkOffset - topPadding!;
    final double extraToolbarHeight = math.max(
        minExtent -
            _bottomHeight -
            topPadding! -
            (toolbarHeight ?? kToolbarHeight),
        0.0);
    final double visibleToolbarHeight =
        visibleMainHeight - _bottomHeight - extraToolbarHeight;

    final bool isPinnedWithOpacityFade =
        pinned! && floating && bottom != null && extraToolbarHeight == 0.0;
    final double toolbarOpacity = !pinned! || isPinnedWithOpacityFade
        ? (visibleToolbarHeight / (toolbarHeight ?? kToolbarHeight))
            .clamp(0.0, 1.0)
        : 1.0;

    Brightness? bright;

    if (forceElevated! ||
        overlapsContent ||
        (pinned! && shrinkOffset > maxExtent - minExtent)) {
      bright = brightness;
    } else {
      if (brightness == Brightness.dark && reverseBrightness!) {
        bright = Brightness.light;
      } else if (brightness == Brightness.light && reverseBrightness!) {
        bright = Brightness.dark;
      } else {
        bright = brightness;
      }
    }

    List<Widget>? action;
    if (actions != null) {
      if (actions!.length == 1) {
        if ((denseActionPadding ?? false)) {
          action = [
            Padding(
                padding: const EdgeInsets.only(right: 8), child: actions![0])
          ];
        } else {
          action = [
            Padding(
                padding: const EdgeInsets.only(right: 16), child: actions![0])
          ];
        }
      } else {
        action = actions!
            .map((e) => Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Container(
                      child: Center(child: e),
                    ),
                  ),
                ))
            .toList()
          ..add(Container(width: 16));
      }
    } else {
      action = null;
    }

    bool hasElevation = (forceElevated! ||
            overlapsContent ||
            (pinned! && shrinkOffset > maxExtent - minExtent)) &&
        elevation != 0;

    final Widget appBar = FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      toolbarOpacity: toolbarOpacity,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          boxShadow: hasElevation ? ShownyStyle.elevation_01dp() : null,
        ),
        duration: const Duration(milliseconds: 100),
        child: Material(
          animationDuration: Duration.zero,
          color: Colors.transparent,
          clipBehavior: Clip.none,
          child: AppBar(
            leading: (automaticallyImplyLeading == true &&
                    leading == null &&
                    Navigator.canPop(context))
                ? CupertinoButton(
                    onPressed: () {
                      if (onPop == null) {
                        if (Navigator.canPop(context)) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        onPop!();
                      }
                    },
                    child: const Icon(Icons.arrow_back_ios,
                        color: ShownyStyle.black))
                : leading,
            automaticallyImplyLeading: automaticallyImplyLeading!,
            title: builder!(context, maxExtent, shrinkOffset),
            actions: action,
            flexibleSpace: (builder == null &&
                    flexibleSpace != null &&
                    !excludeHeaderSemantics!)
                ? Semantics(child: flexibleSpace, header: true)
                : flexibleSpace,
            bottom: bottom,
            elevation: 0,
            shadowColor: shadowColor,
            backgroundColor: backgroundColor,
            iconTheme: iconTheme,
            actionsIconTheme: actionsIconTheme,
            centerTitle: centerTitle,
            excludeHeaderSemantics: excludeHeaderSemantics!,
            titleSpacing: titleSpacing,
            shape: shape,
            toolbarOpacity: toolbarOpacity,
            bottomOpacity: pinned!
                ? 1.0
                : (visibleMainHeight / _bottomHeight).clamp(0.0, 1.0),
            toolbarHeight: toolbarHeight,
            leadingWidth: 44.toWidth,
          ),
        ),
      ),
    );
    return floating ? _FloatingAppBar(child: appBar) : appBar;
  }

  @override
  bool shouldRebuild(covariant _PinnedAppBarDelegate oldDelegate) {
    return leading != oldDelegate.leading ||
        automaticallyImplyLeading != oldDelegate.automaticallyImplyLeading ||
        builder != oldDelegate.builder ||
        actions != oldDelegate.actions ||
        flexibleSpace != oldDelegate.flexibleSpace ||
        bottom != oldDelegate.bottom ||
        _bottomHeight != oldDelegate._bottomHeight ||
        elevation != oldDelegate.elevation ||
        shadowColor != oldDelegate.shadowColor ||
        backgroundColor != oldDelegate.backgroundColor ||
        brightness != oldDelegate.brightness ||
        iconTheme != oldDelegate.iconTheme ||
        actionsIconTheme != oldDelegate.actionsIconTheme ||
        textTheme != oldDelegate.textTheme ||
        reverseBrightness != oldDelegate.reverseBrightness ||
        centerTitle != oldDelegate.centerTitle ||
        titleSpacing != oldDelegate.titleSpacing ||
        expandedHeight != oldDelegate.expandedHeight ||
        topPadding != oldDelegate.topPadding ||
        pinned != oldDelegate.pinned ||
        floating != oldDelegate.floating ||
        vsync != oldDelegate.vsync ||
        snapConfiguration != oldDelegate.snapConfiguration ||
        stretchConfiguration != oldDelegate.stretchConfiguration ||
        showOnScreenConfiguration != oldDelegate.showOnScreenConfiguration ||
        forceElevated != oldDelegate.forceElevated ||
        toolbarHeight != oldDelegate.toolbarHeight ||
        leadingWidth != leadingWidth;
  }

  @override
  String toString() {
    return '${describeIdentity(this)}(topPadding: ${topPadding!.toStringAsFixed(1)}, bottomHeight: ${_bottomHeight.toStringAsFixed(1)}, ...)';
  }
}

class PinnedAppBar extends StatefulWidget {
  /// Creates a material design app bar that can be placed in a [CustomScrollView].
  ///
  /// The arguments [forceElevated], [primary], [floating], [pinned], [snap]
  /// and [automaticallyImplyLeading] must not be null.
  PinnedAppBar({
    Key? key,
    this.onPop,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.builder,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.forceElevated = false,
    this.backgroundColor = ShownyStyle.white,
    this.brightness = Brightness.dark,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.reverseBrightness = false,
    this.centerTitle = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
    this.denseActionPadding = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.shape,
  })  : assert(automaticallyImplyLeading != null),
        assert(forceElevated != null),
        assert(reverseBrightness != null),
        assert(titleSpacing != null),
        assert(floating != null),
        assert(pinned != null),
        assert(snap != null),
        assert(stretch != null),
        assert(floating || !snap,
            'The "snap" argument only makes sense for floating app bars.'),
        assert(stretchTriggerOffset > 0.0),
        // assert(collapsedHeight == null || collapsedHeight > kAppbarHeight,
        //     'The "collapsedHeight" argument has to be larger than [toolbarHeight].'),
        super(key: key);

  PinnedAppBar.topClose({
    Key? key,
    this.onPop,
    this.automaticallyImplyLeading = false,
    this.builder,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.forceElevated = false,
    this.backgroundColor = ShownyStyle.white,
    this.brightness = Brightness.dark,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.reverseBrightness = false,
    this.centerTitle = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
    this.denseActionPadding = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.shape,
  }) {
    assert(automaticallyImplyLeading != null);
    assert(forceElevated != null);
    assert(reverseBrightness != null);
    assert(titleSpacing != null);
    assert(floating != null);
    assert(pinned != null);
    assert(snap != null);
    assert(stretch != null);
    assert(floating || !snap,
        'The "snap" argument only makes sense for floating app bars.');
    assert(stretchTriggerOffset > 0.0);
    this.leading = Padding(
      padding: EdgeInsets.only(left: 8.toWidth),
      child: CupertinoButton(
          onPressed: onPop ?? () {},
          child: const Icon(Icons.close, color: ShownyStyle.black)),
    );
  }

  final VoidCallback? onPop;
  Widget? leading;

  final bool automaticallyImplyLeading;

  final TitleWidgetBuilder? builder;

  final List<Widget>? actions;

  final Widget? flexibleSpace;

  final PreferredSizeWidget? bottom;

  final double? elevation;

  final Color? shadowColor;

  final bool forceElevated;

  final Color? backgroundColor;

  final Brightness brightness;

  final IconThemeData? iconTheme;

  final IconThemeData? actionsIconTheme;

  final TextTheme? textTheme;

  final bool reverseBrightness;

  final bool centerTitle;

  final bool excludeHeaderSemantics;

  final double titleSpacing;

  final double? collapsedHeight;

  final double? expandedHeight;

  final bool floating;

  final bool pinned;

  final ShapeBorder? shape;

  final bool snap;

  final bool stretch;

  final bool denseActionPadding;

  final double stretchTriggerOffset;

  final AsyncCallback? onStretchTrigger;

  double? leadingWidth;

  @override
  _PinnedAppBarState createState() => _PinnedAppBarState();
}

class _PinnedAppBarState extends State<PinnedAppBar>
    with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration? _snapConfiguration;
  OverScrollHeaderStretchConfiguration? _stretchConfiguration;
  PersistentHeaderShowOnScreenConfiguration? _showOnScreenConfiguration;

  Widget _buildWidgetTitle(
      BuildContext context, double maxOffset, double offset) {
    if (widget.builder == null) {
      return Container();
    }
    return widget.builder!(context, maxOffset, offset);
  }

  void _updateSnapConfiguration() {
    if (widget.snap && widget.floating) {
      _snapConfiguration = FloatingHeaderSnapConfiguration(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
    } else {
      _snapConfiguration = null;
    }

    _showOnScreenConfiguration = widget.floating & widget.snap
        ? const PersistentHeaderShowOnScreenConfiguration(
            minShowOnScreenExtent: double.infinity)
        : null;
  }

  void _updateStretchConfiguration() {
    if (widget.stretch) {
      _stretchConfiguration = OverScrollHeaderStretchConfiguration(
        stretchTriggerOffset: widget.stretchTriggerOffset,
        onStretchTrigger: widget.onStretchTrigger,
      );
    } else {
      _stretchConfiguration = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateSnapConfiguration();
    _updateStretchConfiguration();
  }

  @override
  void didUpdateWidget(PinnedAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.snap != oldWidget.snap || widget.floating != oldWidget.floating)
      _updateSnapConfiguration();
    if (widget.stretch != oldWidget.stretch) _updateStretchConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final double bottomHeight = widget.bottom?.preferredSize.height ?? 0.0;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double collapsedHeight = (widget.pinned &&
            widget.floating &&
            widget.bottom != null)
        ? (widget.collapsedHeight ?? 0.0) + bottomHeight + topPadding
        : (widget.collapsedHeight ?? kAppbarHeight) + bottomHeight + topPadding;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: SliverPersistentHeader(
        floating: widget.floating,
        pinned: widget.pinned,
        delegate: _PinnedAppBarDelegate(
            vsync: this,
            onPop: widget.onPop,
            leading: widget.leading,
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            builder: _buildWidgetTitle,
            actions: widget.actions,
            flexibleSpace: widget.flexibleSpace,
            bottom: widget.bottom,
            elevation: widget.elevation,
            shadowColor: widget.shadowColor,
            forceElevated: widget.forceElevated,
            backgroundColor: widget.backgroundColor,
            brightness: widget.brightness,
            iconTheme: widget.iconTheme,
            actionsIconTheme: widget.actionsIconTheme,
            textTheme: widget.textTheme,
            reverseBrightness: widget.reverseBrightness,
            centerTitle: widget.centerTitle,
            excludeHeaderSemantics: widget.excludeHeaderSemantics,
            titleSpacing: widget.titleSpacing,
            expandedHeight: widget.expandedHeight,
            collapsedHeight: collapsedHeight,
            topPadding: topPadding,
            floating: widget.floating,
            pinned: widget.pinned,
            shape: widget.shape,
            snapConfiguration: _snapConfiguration,
            stretchConfiguration: _stretchConfiguration,
            showOnScreenConfiguration: _showOnScreenConfiguration,
            toolbarHeight: kAppbarHeight,
            leadingWidth: widget.leadingWidth,
            denseActionPadding: widget.denseActionPadding),
      ),
    );
  }
}
