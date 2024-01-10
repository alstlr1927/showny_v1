part of showny_button;

abstract class ShownyButtonStyle {
  ShownyButtonStyle();
}

abstract class ShownyButtonTheme {
  ShownyButtonTheme();
}

class ShownyButtonOption {
  final String? text;
  final IconData? icon;
  final ShownyButtonTheme theme;
  final ShownyButtonStyle style;

  ShownyButtonOption.fill(
      {required this.text,
      required ShownyButtonFillTheme theme,
      required ShownyButtonFillStyle style})
      : theme = theme,
        style = style,
        icon = null;

  ShownyButtonOption.line(
      {required this.text,
      required ShownyButtonLineTheme theme,
      required ShownyButtonLineStyle style})
      : theme = theme,
        style = style,
        icon = null;

  ShownyButtonOption.icon(
      {required this.icon,
      required ShownyButtonIconTheme theme,
      required ShownyButtonIconStyle style})
      : theme = theme,
        style = style,
        text = '';

  ShownyButtonOption.text(
      {required this.text,
      required ShownyButtonTextTheme theme,
      required ShownyButtonTextStyle style})
      : theme = theme,
        style = style,
        icon = null;
}

class ShownyButtonFillTheme extends ShownyButtonTheme {
  final Color baseColor;
  final Color textColor;
  final Color disabledBaseColor;
  final Color disabledTextColor;
  final Color loadingColor;

  static ShownyButtonFillTheme get violet => ShownyButtonFillTheme(
        baseColor: ShownyButtonColors.button_base_violet,
        textColor: ShownyButtonColors.button_text_white,
        disabledBaseColor: ShownyButtonColors.button_disabled_base_gray,
        disabledTextColor: ShownyButtonColors.button_disabled_text_gray,
        loadingColor: ShownyButtonColors.button_loading_base_gray,
      );

  static ShownyButtonFillTheme get lightViolet => ShownyButtonFillTheme(
        baseColor: ShownyButtonColors.button_base_lightViolet,
        textColor: ShownyButtonColors.button_text_violet,
        disabledBaseColor: ShownyButtonColors.button_disabled_base_gray,
        disabledTextColor: ShownyButtonColors.button_disabled_text_gray,
        loadingColor: ShownyButtonColors.button_loading_base_gray,
      );

  static ShownyButtonFillTheme get gray => ShownyButtonFillTheme(
        baseColor: ShownyButtonColors.button_base_gray,
        textColor: ShownyButtonColors.button_text_gray,
        disabledBaseColor: ShownyButtonColors.button_disabled_base_gray,
        disabledTextColor: ShownyButtonColors.button_disabled_text_gray,
        loadingColor: ShownyButtonColors.button_loading_base_gray,
      );

  static ShownyButtonFillTheme custom({
    required Color baseColor,
    required Color textColor,
  }) =>
      ShownyButtonFillTheme(
        baseColor: baseColor,
        textColor: textColor,
        disabledBaseColor: ShownyButtonColors.button_disabled_base_gray,
        disabledTextColor: ShownyButtonColors.button_disabled_text_gray,
        loadingColor: ShownyButtonColors.button_loading_base_gray,
      );

  ShownyButtonFillTheme(
      {required this.baseColor,
      required this.textColor,
      required this.disabledBaseColor,
      required this.disabledTextColor,
      required this.loadingColor});
}

class ShownyButtonFillStyle extends ShownyButtonStyle {
  final double height;
  final double? minWidth;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double borderRadius;

  static ShownyButtonFillStyle get fullLarge => ShownyButtonFillStyle(
        height: 56.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        borderRadius: 8,
        textStyle: ShownyStyle.body1(weight: FontWeight.w600),
      );

  static ShownyButtonFillStyle get large => ShownyButtonFillStyle(
        height: 56.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        minWidth: 88.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.body1(weight: FontWeight.w600),
      );

  static ShownyButtonFillStyle get xsmall => ShownyButtonFillStyle(
        height: 28.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minWidth: 73.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.caption(weight: FontWeight.w600),
      );

  static ShownyButtonFillStyle get small => ShownyButtonFillStyle(
        height: 36.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minWidth: 52.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.body2(weight: FontWeight.w600),
      );

  static ShownyButtonFillStyle get fullSmall => ShownyButtonFillStyle(
        height: 36.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 8,
        textStyle: ShownyStyle.body2(weight: FontWeight.w600),
      );

  static ShownyButtonFillStyle get regular => ShownyButtonFillStyle(
        height: 48.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minWidth: 88.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.body2(weight: FontWeight.w600),
      );

  static ShownyButtonFillStyle get fullRegular => ShownyButtonFillStyle(
        height: 48.toWidth,
        padding: EdgeInsets.zero,
        borderRadius: 8,
        textStyle: ShownyStyle.body2(weight: FontWeight.w600),
      );

  ShownyButtonFillStyle({
    required this.height,
    this.minWidth,
    required this.padding,
    required this.textStyle,
    required this.borderRadius,
  });

  ShownyButtonFillStyle copyWith({
    double? height,
    double? minWidth,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? borderRadius,
  }) {
    return ShownyButtonFillStyle(
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

class ShownyButtonLineTheme extends ShownyButtonTheme {
  final Color baseColor;
  final Color textColor;
  final Color lineColor;
  final Color disabledBaseColor;
  final Color disabledTextColor;
  final Color disabledLineColor;
  final Color loadingColor;

  static ShownyButtonLineTheme get negationRed => ShownyButtonLineTheme(
      baseColor: ShownyButtonColors.button_base_white,
      textColor: ShownyButtonColors.button_text_negationRed,
      lineColor: ShownyButtonColors.button_line_negationRed,
      disabledBaseColor: ShownyButtonColors.button_base_white,
      disabledTextColor: ShownyButtonColors.button_disabled_text_gray,
      disabledLineColor: ShownyButtonColors.button_disabled_line_gray,
      loadingColor: ShownyButtonColors.button_loading_line_gray);

  static ShownyButtonLineTheme get deepGray => ShownyButtonLineTheme(
      baseColor: ShownyStyle.white,
      textColor: ShownyStyle.gray090,
      lineColor: ShownyStyle.gray050,
      disabledBaseColor: ShownyStyle.white,
      disabledTextColor: ShownyStyle.gray060,
      disabledLineColor: ShownyStyle.gray050,
      loadingColor: ShownyStyle.gray050);

  ShownyButtonLineTheme(
      {required this.baseColor,
      required this.textColor,
      required this.lineColor,
      required this.disabledBaseColor,
      required this.disabledTextColor,
      required this.disabledLineColor,
      required this.loadingColor});
}

class ShownyButtonLineStyle extends ShownyButtonStyle {
  final double height;
  final double? minWidth;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double borderRadius;

  static ShownyButtonLineStyle get large => ShownyButtonLineStyle(
        height: 56.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        minWidth: 88.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.body1(weight: FontWeight.w600),
      );

  static ShownyButtonLineStyle get regular => ShownyButtonLineStyle(
        height: 48.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minWidth: 88.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.body1(weight: FontWeight.w600),
      );

  static ShownyButtonLineStyle get xsmall => ShownyButtonLineStyle(
        height: 28.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minWidth: 73.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.caption(weight: FontWeight.w600),
      );

  static ShownyButtonLineStyle get small => ShownyButtonLineStyle(
        height: 36.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minWidth: 52.toWidth,
        borderRadius: 8,
        textStyle: ShownyStyle.body2(weight: FontWeight.w600),
      );

  static ShownyButtonLineStyle get fullSmall => ShownyButtonLineStyle(
        height: 36.toWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 8,
        textStyle: ShownyStyle.body2(weight: FontWeight.w600),
      );

  static ShownyButtonLineStyle get fullRegular => ShownyButtonLineStyle(
        height: 48.toWidth,
        padding: EdgeInsets.zero,
        borderRadius: 8,
        textStyle: ShownyStyle.body1(weight: FontWeight.w600),
      );

  ShownyButtonLineStyle(
      {required this.height,
      this.minWidth,
      required this.padding,
      required this.textStyle,
      required this.borderRadius});

  ShownyButtonLineStyle copyWith({
    double? height,
    double? minWidth,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? borderRadius,
  }) {
    return ShownyButtonLineStyle(
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

class ShownyButtonIconTheme extends ShownyButtonTheme {
  final Color textColor;
  final Color disabledTextColor;

  static ShownyButtonIconTheme get deepGray => ShownyButtonIconTheme(
      textColor: ShownyButtonColors.button_text_deepGray,
      disabledTextColor: ShownyButtonColors.button_disabled_text_gray);

  static ShownyButtonIconTheme get white => ShownyButtonIconTheme(
      textColor: ShownyButtonColors.button_text_white,
      disabledTextColor: ShownyButtonColors.button_disabled_text_gray);

  ShownyButtonIconTheme(
      {required this.textColor, required this.disabledTextColor});

  ShownyButtonIconTheme copyWith({
    Color? textColor,
    Color? disabledTextColor,
  }) {
    return ShownyButtonIconTheme(
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
    );
  }
}

class ShownyButtonTextTheme extends ShownyButtonTheme {
  final Color textColor;
  final Color disabledTextColor;

  static ShownyButtonTextTheme get gray => ShownyButtonTextTheme(
      textColor: ShownyButtonColors.button_text_gray,
      disabledTextColor: ShownyButtonColors.button_disabled_text_gray);

  static ShownyButtonTextTheme get black => ShownyButtonTextTheme(
      textColor: ShownyButtonColors.button_text_black,
      disabledTextColor: ShownyButtonColors.button_disabled_text_gray);

  static ShownyButtonTextTheme get violet => ShownyButtonTextTheme(
      textColor: ShownyButtonColors.button_text_violet,
      disabledTextColor: ShownyButtonColors.button_disabled_text_gray);

  static ShownyButtonTextTheme get negationRed => ShownyButtonTextTheme(
      textColor: ShownyButtonColors.button_text_negationRed,
      disabledTextColor: ShownyButtonColors.button_disabled_text_gray);

  ShownyButtonTextTheme(
      {required this.textColor, required this.disabledTextColor});
}

class ShownyButtonTextStyle extends ShownyButtonStyle {
  final double height;
  final double minWidth;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double borderRadius;

  static ShownyButtonTextStyle get small => ShownyButtonTextStyle(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: 8,
        minWidth: 48.toWidth,
        height: 26.toWidth,
        textStyle: ShownyStyle.caption(weight: FontWeight.w600),
      );

  static ShownyButtonTextStyle get regular => ShownyButtonTextStyle(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: 8,
        minWidth: 52.toWidth,
        height: 28.toWidth,
        textStyle: ShownyStyle.body2(weight: FontWeight.w600),
      );

  ShownyButtonTextStyle(
      {required this.padding,
      required this.height,
      required this.minWidth,
      required this.textStyle,
      required this.borderRadius});
}

class ShownyButtonIconStyle extends ShownyButtonStyle {
  double size;

  static ShownyButtonIconStyle get small => ShownyButtonIconStyle(
        size: 16.toWidth,
      );

  static ShownyButtonIconStyle get regular => ShownyButtonIconStyle(
        size: 24.toWidth,
      );

  ShownyButtonIconStyle({required this.size});
}

class ShownyButtonColors {
  static const button_base_white = ShownyStyle.white;
  static const button_base_gray = ShownyStyle.gray040;
  static const button_base_violet = ShownyStyle.mainPurple;
  static const button_base_lightViolet = ShownyStyle.lightViolet;

  static const button_text_white = ShownyStyle.white;
  static const button_text_gray = ShownyStyle.gray070;
  static const button_text_deepGray = ShownyStyle.gray090;
  static const button_text_black = ShownyStyle.black;
  static const button_text_violet = ShownyStyle.mainPurple;
  static const button_text_negationRed = ShownyStyle.mainRed;

  static const button_disabled_text_gray = ShownyStyle.gray060;
  static const button_disabled_base_gray = ShownyStyle.gray040;
  static const button_disabled_line_gray = ShownyStyle.gray050;

  static const button_line_negationRed = ShownyStyle.mainRed;

  static const button_loading_base_gray = ShownyStyle.gray040;
  static const button_loading_line_gray = ShownyStyle.gray050;
}
