import 'package:flutter/material.dart';
import 'package:showny/utils/colors.dart';

import '../utils/theme.dart';

class CommonButtonWidget extends StatelessWidget {
  final String text;
  final double radius;
  final double height;
  final double? width;
  final Color? color;
  final Color? textcolor;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Widget? image;
  final Color? borderColor;
  final double? fontSize;
  final double horizontalPadding;

  const CommonButtonWidget({
    super.key,
    required this.text,
    required this.radius,
    required this.height,
    this.onTap,
    this.textStyle,
    this.color,
    this.textcolor,
    this.width,
    this.fontSize,
    this.image,
    this.borderColor,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width ?? size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: borderColor ?? Colors.transparent),
              color: color ?? white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image ?? const SizedBox(),
              SizedBox(
                width: image != null ? size.width * 0.02 : 0,
              ),
              Text(
                text.toUpperCase(),
                style: themeData().textTheme.labelMedium!.apply(
                      color: textcolor ?? black,
                      fontSizeDelta: fontSize ?? 0.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonButtonWidget2 extends StatelessWidget {
  final String text;
  final double radius;
  final double height;
  final double? width;
  final Color? color;
  final Color? textcolor;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Widget? image;
  final Color? borderColor;
  final double? fontSize;

  const CommonButtonWidget2({
    super.key,
    required this.text,
    required this.radius,
    required this.height,
    this.onTap,
    this.textStyle,
    this.color,
    this.textcolor,
    this.width,
    this.fontSize,
    this.image,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: width ?? size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: borderColor ?? Colors.transparent),
              color: color ?? white),
          child: Center(
              child: Text(
            text.toUpperCase(),
            style: themeData().textTheme.titleLarge!.copyWith(
                  color: textcolor ?? black,
                  fontSize: fontSize ?? 14,
                ),
          ))),
    );
  }
}
