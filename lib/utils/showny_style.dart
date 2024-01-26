import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShownyStyle {
  static const defaultDesignSize = Size(375, 667);
  static const tabletDesignSize = Size(700, 1232);
  static Size applyDesignSize = const Size(375, 667);

  static get sizeFactor => applyDesignSize.width / defaultDesignSize.width;

  static List<BoxShadow> elevation_01dp() {
    return [
      const BoxShadow(color: Color(0x14000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0),
      const BoxShadow(color: Color(0x26000000), offset: Offset(0, 0), blurRadius: 1, spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_03dp() {
    return [
      const BoxShadow(color: Color(0x14000000), offset: Offset(0, 3), blurRadius: 8, spreadRadius: 0),
      const BoxShadow(color: Color(0x08000000), offset: Offset(0, 2), blurRadius: 5, spreadRadius: 0),
      const BoxShadow(color: Color(0x26000000), offset: Offset(0, 0), blurRadius: 1, spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_04dp() {
    return [
      const BoxShadow(color: Color(0x1a000000), offset: Offset(0, 6), blurRadius: 8, spreadRadius: 0),
      const BoxShadow(color: Color(0x0d000000), offset: Offset(0, 1), blurRadius: 5, spreadRadius: 0),
      const BoxShadow(color: Color(0x26000000), offset: Offset(0, 0), blurRadius: 1, spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_06dp() {
    return [
      const BoxShadow(color: Color(0x33000000), offset: Offset(0, 3), blurRadius: 5, spreadRadius: -1),
      const BoxShadow(color: Color(0x1f000000), offset: Offset(0, 1), blurRadius: 18, spreadRadius: 0),
      const BoxShadow(color: Color(0x24000000), offset: Offset(0, 6), blurRadius: 10, spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_8dp() {
    return [
      const BoxShadow(color: Color(0x33000000), offset: Offset(0, 3), blurRadius: 5, spreadRadius: -1),
      const BoxShadow(color: Color(0x1f000000), offset: Offset(0, 1), blurRadius: 18, spreadRadius: 0),
      const BoxShadow(color: Color(0x24000000), offset: Offset(0, 6), blurRadius: 10, spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_24dp() {
    return [
      const BoxShadow(color: Color(0x33000000), offset: Offset(0, 11), blurRadius: 15, spreadRadius: -7),
      const BoxShadow(color: Color(0x1f000000), offset: Offset(0, 9), blurRadius: 46, spreadRadius: 8),
      const BoxShadow(color: Color(0x24000000), offset: Offset(0, 24), blurRadius: 38, spreadRadius: 3)
    ];
  }

  static TextStyle title({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(28),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 41 / 28,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h1({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(48),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h2({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(34),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 50 / 34,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h3({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(24),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 36 / 24,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h4({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(20),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 29 / 20,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle h5({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(18),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 27 / 18,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle body1({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(16),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 24 / 16,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle body2({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(14),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 20 / 14,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle caption({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(12),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 18 / 12,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static TextStyle overline({Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: ScreenUtil().setSp(10),
        color: color ?? const Color(0xff333333),
        fontWeight: weight ?? FontWeight.normal,
        height: 15 / 10,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
  }

  static double defaultBottomPadding() {
    if (ScreenUtil().bottomBarHeight == 0) {
      return 16.0;
    } else {
      return ScreenUtil().bottomBarHeight;
    }
  }

  static double safeAreaPadding() {
    if (ScreenUtil().bottomBarHeight == 0) {
      return 0.0;
    } else {
      return ScreenUtil().bottomBarHeight;
    }
  }

  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const mainPurple = Color(0xff5900FF);
  static const mainRed = Color(0xfff14545);

  static const lightViolet = Color(0xffece5ff);

  static const gray010 = Color(0xFFFCFCFC);
  static const gray020 = Color(0xFFFAFAFA);
  static const gray030 = Color(0xFFF5F5F5);
  static const gray040 = Color(0xFFEEEEEE);
  static const gray050 = Color(0xFFE0E0E0);
  static const gray060 = Color(0xFF9E9E9E);
  static const gray070 = Color(0xFF616161);
  static const gray080 = Color(0xFF424242);
  static const gray090 = Color(0xFF212121);
}
