import 'package:flutter/material.dart';
import 'package:showny/constants.dart';

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
        hintStyle: Constants.textFieldHintStyle.copyWith(
          color: const Color(0xFF555555),
        ),
        errorText: error ? errorText : null,
        errorStyle: Constants.textFieldErrorStyle,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder,
        filled: true,
        fillColor: const Color(0xFFEEEEEE),
        suffixIcon: Center(widthFactor: 2, child: suffix),
        counterText: '',
      ),
      style: Constants.textFieldHintStyle.copyWith(color: Colors.black),
      cursorColor: Colors.black,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLength: maxLength,
    );
  }
}
