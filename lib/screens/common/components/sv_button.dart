import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class SVButton extends StatelessWidget {
  const SVButton({
    super.key,
    this.icon,
    required this.title,
    this.isLoading,
    this.titleColor,
    this.strokeColor,
    required this.backgroundColor,
    this.onPressed,
  });

  final Image? icon;
  final String title;
  final bool? isLoading;
  final Color? titleColor;
  final Color? strokeColor;
  final Color backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.toWidth,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
        side: BorderSide(color: strokeColor ?? Colors.transparent, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      )),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: backgroundColor,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            const SizedBox(width: 5),
            if (isLoading == null || isLoading == false)
              Text(
                title,
                style: FontHelper.regular_14_000000
                    .copyWith(color: titleColor ?? Colors.black, height: 1.0),
              )
            else
              const SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.white,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.icon,
    required this.title,
    this.isLoading,
    this.titleColor,
    this.strokeColor,
    required this.backgroundColor,
    this.onPressed,
  });

  final Image? icon;
  final String title;
  final bool? isLoading;
  final Color? titleColor;
  final Color? strokeColor;
  final Color backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.toWidth,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
        side: BorderSide(color: strokeColor ?? Colors.transparent, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      )),
      child: CupertinoButton(
        // padding: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
        color: backgroundColor,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (icon != null) ...{
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
            },
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                if (isLoading == null || isLoading == false)
                  Text(
                    title,
                    style: ShownyStyle.body2(
                      color: titleColor ?? Colors.black,
                      weight: FontWeight.w500,
                    ),
                  )
                else
                  const SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
