library showny_button;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../indicator/showny_indicator.dart';

part 'showny_button_type.dart';

class ShownyButton extends StatefulWidget {
  final Function? onPressed;
  final ShownyButtonOption option;

  ShownyButton({
    required this.option,
    this.onPressed,
  });

  @override
  ShownyButtonState createState() => ShownyButtonState();
}

class ShownyButtonState extends State<ShownyButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ShownyButtonTheme theme = widget.option.theme;
    if (theme is ShownyButtonFillTheme) {
      return _Fill(option: widget.option, onPressed: widget.onPressed);
    } else if (theme is ShownyButtonLineTheme) {
      return _Line(option: widget.option, onPressed: widget.onPressed);
    } else if (theme is ShownyButtonTextTheme) {
      return _Text(option: widget.option, onPressed: widget.onPressed);
    } else {
      return _Icon(option: widget.option, onPressed: widget.onPressed);
    }
  }
}

class _BaseButton extends StatefulWidget {
  final Function? onPressed;
  final Widget child;

  _BaseButton({
    this.onPressed,
    required this.child,
  });

  @override
  _BaseButtonState createState() => _BaseButtonState();
}

class _BaseButtonState extends State<_BaseButton>
    with SingleTickerProviderStateMixin {
  final double pressedOpacity = 0.5;
  final Duration kFadeOutDuration = Duration(milliseconds: 50);
  final Duration kFadeInDuration = Duration(milliseconds: 300);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(_BaseButton old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = pressedOpacity;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) return;
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0,
            duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : _animationController.animateTo(0.0,
            duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.onPressed != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: enabled
          ? () async {
              await widget.onPressed?.call();
            }
          : null,
      child: FadeTransition(opacity: _opacityAnimation, child: widget.child),
    );
  }
}

class _Fill extends StatefulWidget {
  final Function? onPressed;
  final ShownyButtonOption option;

  _Fill({
    required this.option,
    this.onPressed,
  });

  @override
  _FillState createState() => _FillState();
}

class _FillState extends State<_Fill> with SingleTickerProviderStateMixin {
  bool inProgress = false;

  void setProgress({required bool inProgress}) {
    if (mounted) {
      setState(() {
        this.inProgress = inProgress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ShownyButtonFillTheme theme = widget.option.theme as ShownyButtonFillTheme;
    ShownyButtonFillStyle style = widget.option.style as ShownyButtonFillStyle;

    bool enabled = widget.onPressed != null && !inProgress;

    Color backgroundColor = enabled ? theme.baseColor : theme.disabledBaseColor;
    double borderRadius = style.borderRadius;
    double? minWidth = style.minWidth;
    double height = style.height;
    EdgeInsets padding = style.padding;
    String? text = widget.option.text;
    TextStyle textStyle = style.textStyle
        .copyWith(color: enabled ? theme.textColor : theme.disabledTextColor);

    return _BaseButton(
        onPressed: enabled
            ? () async {
                setProgress(inProgress: true);
                await widget.onPressed?.call();
                setProgress(inProgress: false);
              }
            : null,
        child: Container(
          constraints: minWidth == null
              ? BoxConstraints.expand(height: height)
              : BoxConstraints(
                  minHeight: height,
                  minWidth: minWidth,
                ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: padding,
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 100),
                  child: inProgress
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            if (text != null) ...{
                              Text(
                                '$text',
                                style: textStyle.copyWith(
                                    color: Colors.transparent),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            },
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CupertinoTheme(
                                      data: const CupertinoThemeData(
                                        brightness: Brightness.light,
                                      ),
                                      child: ShownyIndicator(
                                        animating: true,
                                        radius: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              if (text != null) ...{
                                Text(
                                  text.isEmpty ? ' ' : text,
                                  style: textStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              },
                            ],
                          ),
                        )),
            ),
          ),
        ));
  }
}

class _Line extends StatefulWidget {
  final Function? onPressed;
  final ShownyButtonOption option;

  _Line({
    required this.option,
    this.onPressed,
  });

  @override
  _LineState createState() => _LineState();
}

class _LineState extends State<_Line> with SingleTickerProviderStateMixin {
  bool inProgress = false;

  void setProgress({required bool inProgress}) {
    if (mounted) {
      setState(() {
        this.inProgress = inProgress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ShownyButtonLineTheme theme = widget.option.theme as ShownyButtonLineTheme;
    ShownyButtonLineStyle style = widget.option.style as ShownyButtonLineStyle;

    bool enabled = widget.onPressed != null && !inProgress;

    Color backgroundColor = enabled ? theme.baseColor : theme.disabledBaseColor;
    Color borderColor = enabled ? theme.lineColor : theme.disabledLineColor;
    double borderRadius = style.borderRadius;
    double? minWidth = style.minWidth;
    double height = style.height;
    EdgeInsets padding = style.padding;
    String? text = widget.option.text;
    TextStyle textStyle = style.textStyle
        .copyWith(color: enabled ? theme.textColor : theme.disabledTextColor);
    return _BaseButton(
        onPressed: enabled
            ? () async {
                setProgress(inProgress: true);
                await widget.onPressed?.call();
                setProgress(inProgress: false);
              }
            : null,
        child: Container(
          constraints: minWidth == null
              ? BoxConstraints.expand(height: height)
              : BoxConstraints(
                  minHeight: height,
                  minWidth: minWidth,
                ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1),
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: padding,
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 100),
                  child: inProgress
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            if (text != null) ...{
                              Text(
                                '$text',
                                style: textStyle.copyWith(
                                    color: Colors.transparent),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            },
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CupertinoTheme(
                                      data: CupertinoThemeData(
                                        brightness: Brightness.light,
                                      ),
                                      child: ShownyIndicator(
                                        animating: true,
                                        radius: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (text != null) ...{
                                Text(
                                  '$text',
                                  style: textStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              },
                            ],
                          ),
                        )),
            ),
          ),
        ));
  }
}

class _Icon extends StatefulWidget {
  final Function? onPressed;
  final ShownyButtonOption option;

  _Icon({
    required this.option,
    this.onPressed,
  });

  @override
  _IconState createState() => _IconState();
}

class _IconState extends State<_Icon> with SingleTickerProviderStateMixin {
  bool inProgress = false;

  void setProgress({required bool inProgress}) {
    if (mounted) {
      setState(() {
        this.inProgress = inProgress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ShownyButtonIconTheme theme = widget.option.theme as ShownyButtonIconTheme;
    ShownyButtonIconStyle style = widget.option.style as ShownyButtonIconStyle;

    bool enabled = widget.onPressed != null && !inProgress;

    double size = style.size;
    Color backgroundColor = enabled ? theme.textColor : theme.disabledTextColor;
    IconData? icon = widget.option.icon;
    return _BaseButton(
        onPressed: enabled
            ? () async {
                setProgress(inProgress: true);
                await widget.onPressed?.call();
                setProgress(inProgress: false);
              }
            : null,
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            child: inProgress
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      if (icon != null) ...{
                        Icon(icon, size: size, color: Colors.transparent)
                      },
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoTheme(
                            data: CupertinoThemeData(
                              brightness: Brightness.light,
                            ),
                            child: ShownyIndicator(
                              animating: true,
                              radius: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : FittedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...{
                          Icon(icon, size: size, color: backgroundColor)
                        },
                      ],
                    ),
                  )));
  }
}

class _Text extends StatefulWidget {
  final Function? onPressed;
  final ShownyButtonOption option;

  _Text({
    required this.option,
    this.onPressed,
  });

  @override
  _TextState createState() => _TextState();
}

class _TextState extends State<_Text> with SingleTickerProviderStateMixin {
  bool inProgress = false;

  void setProgress({required bool inProgress}) {
    if (mounted) {
      setState(() {
        this.inProgress = inProgress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ShownyButtonTextTheme theme = widget.option.theme as ShownyButtonTextTheme;
    ShownyButtonTextStyle style = widget.option.style as ShownyButtonTextStyle;

    bool enabled = widget.onPressed != null && !inProgress;

    Color backgroundColor = Colors.transparent;
    double borderRadius = style.borderRadius;
    double height = style.height;
    double minWidth = style.minWidth;
    EdgeInsets padding = style.padding;
    String? text = widget.option.text;
    TextStyle textStyle = style.textStyle
        .copyWith(color: enabled ? theme.textColor : theme.disabledTextColor);

    return _BaseButton(
        onPressed: enabled
            ? () async {
                setProgress(inProgress: true);
                await widget.onPressed?.call();
                setProgress(inProgress: false);
              }
            : null,
        child: Container(
          constraints: BoxConstraints(
            minHeight: height,
            minWidth: minWidth,
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: padding,
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 100),
                  child: inProgress
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            if (text != null) ...{
                              Text(
                                '$text',
                                style: textStyle.copyWith(
                                    color: Colors.transparent),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            },
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CupertinoTheme(
                                  data: CupertinoThemeData(
                                    brightness: Brightness.light,
                                  ),
                                  child: ShownyIndicator(
                                    animating: true,
                                    radius: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (text != null) ...{
                                Text(
                                  '$text',
                                  style: textStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              },
                            ],
                          ),
                        )),
            ),
          ),
        ));
  }
}
