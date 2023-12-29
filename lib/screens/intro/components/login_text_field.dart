import 'package:flutter/material.dart';
import 'package:showny/constants.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField({
    super.key,
    required this.hintText,
    this.error = false,
    this.errorText,
    this.obscureText = false,
    this.onChanged,
  });

  final String hintText;
  final bool error;
  final String? errorText;
  final bool obscureText;
  final Function(String)? onChanged;

  final outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black),
    borderRadius: BorderRadius.circular(12.0),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Constants.textFieldHintStyle,
        errorText: error ? errorText : null,
        errorStyle: Constants.textFieldErrorStyle,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder,
      ),
      style: Constants.textFieldHintStyle.copyWith(color: Colors.black),
      cursorColor: Colors.black,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
