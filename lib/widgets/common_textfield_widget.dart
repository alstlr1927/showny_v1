import 'package:flutter/material.dart';
import 'package:showny/utils/colors.dart';

import '../utils/theme.dart';

class CommonTextFieldWidget2 extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? textEditingController;
  Widget? prefixIcon;
  TextStyle? textStyle;
  double? borderRadius;
  TextStyle? errorStyle;
  TextStyle? hintStyle;
  TextAlign? textAlign;
  Widget? suffixIcon;
  double? size = 70;
  Widget? suffix;
  Color? borderColor;
  Color? fillColor;
  Color? shadowColors;
  bool? isFilled = false;
  Color? labelColor;
  TextInputType? textInputType = TextInputType.name;
  TextInputAction? textInputAction = TextInputAction.next;
  bool? textVisible = false;
  EdgeInsets? contentPadding;
  bool? readOnly = false;
  VoidCallback? onTap;
  int? maxLine = 1;
  String? errorText = "";
  Function(String)? onChange;
  FormFieldValidator<String>? validation;
  double? fontSize = 15;
  double? hintFontSize = 14;
  TextCapitalization? textCapitalization = TextCapitalization.none;
  int? maxWord;

  CommonTextFieldWidget2(
      {this.hintText,
      this.labelText,
      this.textEditingController,
      this.prefixIcon,
      this.borderRadius,
      this.textStyle,
      this.hintStyle,
      this.suffixIcon,
      this.textAlign,
      this.errorStyle,
      this.size,
      this.suffix,
      this.borderColor,
      this.fillColor,
      this.shadowColors,
      this.isFilled,
      this.labelColor,
      this.textInputType,
      this.textInputAction,
      this.textVisible,
      this.contentPadding,
      this.readOnly,
      this.onTap,
      this.maxLine,
      this.errorText,
      this.onChange,
      this.validation,
      this.fontSize,
      this.hintFontSize,
      this.textCapitalization,
      this.maxWord,
      super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHeight = size.height * 0.07;
    return Container(
      height: containerHeight,
      child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: textEditingController,
          maxLength: maxWord,
          textAlignVertical: TextAlignVertical.center,
          textAlign: textAlign ?? TextAlign.start,
          obscureText: textVisible ?? false,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          readOnly: readOnly ?? false,
          validator: validation,
          onTap: onTap,
          maxLines: maxLine,
          onChanged: onChange,
          style: textStyle ??
              const TextStyle(
                  color: grey,
                  fontSize: 14,
                  fontFamily: 'NotoSansKRExtraRegular',
                  fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            errorStyle: errorStyle ??
                const TextStyle(
                    color: greyLight,
                    fontSize: 12,
                    fontFamily: 'NotoSansKRExtraRegular',
                    fontWeight: FontWeight.w400),
            hintStyle: hintStyle ??
                const TextStyle(
                    color: grey,
                    fontSize: 14,
                    fontFamily: 'NotoSansKRExtraRegular',
                    fontWeight: FontWeight.w400),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: black, width: 1),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: black, width: 1),
                borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: black, width: 1),
                borderRadius: BorderRadius.circular(12)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: black, width: 1),
                borderRadius: BorderRadius.circular(12)),
            contentPadding: EdgeInsets.symmetric(
                vertical: containerHeight / 2 - 14, horizontal: 16),
            isDense: true,
          )),
    );
  }
}

class CommonTextFieldWidgetDark extends StatelessWidget {
  String? hintText;
  String? labelText;
  final double? height;
  final double? width;
  TextEditingController? textEditingController;
  Widget? prefixIcon;
  double? borderRadius;
  TextStyle? errorStyle;
  Widget? suffixIcon;
  double? size = 70;
  Widget? suffix;
  Color? borderColor;
  Color? fillColor;
  Color? shadowColors;
  bool? isFilled = false;
  Color? labelColor;
  TextInputType? textInputType = TextInputType.name;
  TextInputAction? textInputAction = TextInputAction.next;
  bool? textVisible = false;
  EdgeInsets? contentPadding;
  bool? readOnly = false;
  Color? hintColor;
  VoidCallback? onTap;
  int? maxLine = 1;
  String? errorText = "";
  Function(String)? onChange;
  FormFieldValidator<String>? validation;
  double? fontSize = 15;
  double? hintFontSize = 14;
  TextCapitalization? textCapitalization = TextCapitalization.none;

  CommonTextFieldWidgetDark(
      {this.hintText,
      this.labelText,
      this.textEditingController,
      this.prefixIcon,
      this.borderRadius,
      this.height,
      this.width,
      this.suffixIcon,
      this.hintColor,
      this.errorStyle,
      this.size,
      this.suffix,
      this.borderColor,
      this.fillColor,
      this.shadowColors,
      this.isFilled,
      this.labelColor,
      this.textInputType,
      this.textInputAction,
      this.textVisible,
      this.contentPadding,
      this.readOnly,
      this.onTap,
      this.maxLine,
      this.errorText,
      this.onChange,
      this.validation,
      this.fontSize,
      this.hintFontSize,
      this.textCapitalization,
      super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHeight = size.height * 0.07;

    return Container(
      height: containerHeight,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textEditingController,
        obscureText: textVisible ?? false,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        readOnly: readOnly ?? false,
        validator: validation,
        onTap: onTap,
        maxLines: maxLine,
        onChanged: onChange,
        style: TextStyle(
            color: grey,
            fontSize: 14,
            fontFamily: 'NotoSansKRExtraRegular',
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: TextStyle(
              color: greyLight,
              fontSize: 12,
              fontFamily: 'NotoSansKRExtraRegular',
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
              color: hintColor != null ? hintColor : grey,
              fontSize: 14,
              fontFamily: 'NotoSansKRExtraRegular',
              fontWeight: FontWeight.w400),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.height * 0.09 / 2 - 16, horizontal: 16),
          isDense: true,
          fillColor: fillColor != 'null' ? fillColor : greyExtraLight,
        ),
      ),
    );
  }
}

class CommonTextFieldWidget extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? textEditingController;
  Widget? prefixIcon;
  double? borderRadius;
  Widget? suffixIcon;
  double? size = 70;
  Widget? suffix;
  Color? borderColor;
  Color? fillColor;
  Color? shadowColors;
  bool? isFilled = false;
  Color? labelColor;
  TextInputType? textInputType = TextInputType.name;
  TextInputAction? textInputAction = TextInputAction.next;
  bool? textVisible = false;
  EdgeInsets? contentPadding;
  bool? readOnly = false;
  VoidCallback? onTap;
  int? maxLine = 1;
  String? errorText = "";
  Function(String)? onChange;
  FormFieldValidator<String>? validation;
  double? fontSize = 15;
  double? hintFontSize = 14;
  int? maxWord;
  TextCapitalization? textCapitalization = TextCapitalization.none;
  TextStyle? hintStyle;
  TextStyle? styleFont;
  TextAlign? alignment;
  String? counter;
  String? counterText;

  CommonTextFieldWidget(
      {this.hintText,
      this.labelText,
      this.textEditingController,
      this.prefixIcon,
      this.borderRadius,
      this.suffixIcon,
      this.size,
      this.suffix,
      this.borderColor,
      this.fillColor,
      this.shadowColors,
      this.isFilled,
      this.labelColor,
      this.textInputType,
      this.textInputAction,
      this.textVisible,
      this.contentPadding,
      this.readOnly,
      this.onTap,
      this.maxLine,
      this.errorText,
      this.onChange,
      this.validation,
      this.fontSize,
      this.hintFontSize,
      this.textCapitalization,
      this.maxWord,
      this.hintStyle,
      this.styleFont,
      this.alignment,
      this.counter,
      this.counterText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
      obscureText: textVisible ?? false,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textAlign: alignment ?? TextAlign.start,
      cursorColor: black,
      readOnly: readOnly ?? false,
      validator: validation,
      onTap: onTap,
      maxLines: maxLine ?? 1,
      onChanged: onChange,
      maxLength: maxWord,
      style: styleFont ?? themeData().textTheme.headlineSmall,
      decoration: InputDecoration(
        enabled: readOnly ?? true,
        // counter: Text("50"),
        counterText: counterText,
        contentPadding: contentPadding,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
            borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
            borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
            borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? 4,
            ),
            borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
        filled: true,
        fillColor: fillColor ?? white,
        labelText: labelText,
        labelStyle: const TextStyle(
            // color: labelColor ?? appTheme.primaryTheme,
            fontWeight: FontWeight.w600),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffix: suffix,
        errorMaxLines: 1,
        // errorText: (isNullEmptyOrFalse(errorText)) ? null : errorText,
        hintText: hintText,
        hintStyle: hintStyle ??
            themeData().textTheme.headlineSmall!.apply(color: grey777),
      ),
    );
  }
}
