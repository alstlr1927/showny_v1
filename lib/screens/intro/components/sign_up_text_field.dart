import 'package:flutter/material.dart';
import 'package:showny/components/title_text_field/text_field_theme/text_field_theme.dart';
import 'package:showny/constants.dart';
import 'package:showny/utils/showny_style.dart';

class SignUpTextField extends StatelessWidget {
  SignUpTextField({
    super.key,
    required this.hintText,
    this.error = false,
    this.errorText,
    this.suffix,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
  });

  final String hintText;
  final bool error;
  final String? errorText;
  final Widget? suffix;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;

  final outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(12.0),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: ShownyStyle.body2(
            color: TextFieldColor.textField_hint_text, weight: FontWeight.w600),
        errorText: error ? errorText : null,
        errorStyle: Constants.textFieldErrorStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: TextFieldColor.textField_default_line, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: TextFieldColor.textField_focus_line, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: TextFieldColor.textField_default_line, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: TextFieldColor.textField_focus_line, width: 1),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Center(widthFactor: 2, child: suffix),
        counterText: '',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
      style: ShownyStyle.body2(color: TextFieldColor.textField_text),
      cursorColor: Colors.black,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLength: maxLength,
    );
  }
}
