import 'package:flutter/material.dart';
import 'package:showny/utils/showny_style.dart';

class RoundedAppBar extends AppBar {
  final Widget? icon;
  final String? titleText;
  final List<Widget>? action;
  final double? shadow;
  final Color? bgColor;
  final bool? center;
  final Color? textColor;

  RoundedAppBar({
    this.icon,
    this.titleText,
    this.center,
    this.action,
    this.shadow,
    this.bgColor,
    this.textColor,
    Key? key,
  }) : super(
          key: key,
          backgroundColor: bgColor,
          leading: icon,
          centerTitle: center,
          title: titleText != null
              ? Text(
                  titleText,
                  style: ShownyStyle.body2(
                      color: ShownyStyle.black, weight: FontWeight.w600),
                )
              : null,
          elevation: shadow,
          automaticallyImplyLeading: false,
          actions: action,
          scrolledUnderElevation: 0,
        );
}
