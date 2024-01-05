import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/utils/showny_style.dart';

import '../../../../../constants.dart';

class SVInlineButton extends StatelessWidget {
  const SVInlineButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    required this.text,
    this.textColor = Colors.white,
    this.strokeColor,
    this.icon,
    this.constraints,
  });
  final Function()? onPressed;
  final String text;
  final double? width;
  final BoxConstraints? constraints;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Color textColor;
  final Color? strokeColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 28,
      constraints: constraints,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
        side: BorderSide(color: strokeColor ?? Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(4),
      )),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: backgroundColor,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(2),
        child: Text(
          text,
          style: ShownyStyle.caption(color: textColor),
        ),
      ),
    );
  }
}

class SVInlineColorButton extends StatelessWidget {
  const SVInlineColorButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    required this.text,
    this.textColor = Colors.white,
    this.strokeColor,
    this.icon,
    this.constraints,
  });
  final Function()? onPressed;
  final String text;
  final double? width;
  final BoxConstraints? constraints;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Color textColor;
  final Color? strokeColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 28,
      constraints: constraints,
      // decoration: BoxDecoration(),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
        side: BorderSide(color: strokeColor ?? Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(4),
      )),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: backgroundColor,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Text(
          text,
          style: ShownyStyle.caption(color: textColor),
        ),
      ),
    );
  }
}
