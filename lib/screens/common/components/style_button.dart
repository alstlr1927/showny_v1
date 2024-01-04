import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/style.dart';
import 'package:showny/utils/showny_style.dart';

class StyleButton extends StatelessWidget {
  const StyleButton({
    super.key,
    required this.selectedStyles,
    required this.style,
    required this.onPressed,
  });

  final List<Style> selectedStyles;
  final Style style;
  final Function(Style) onPressed;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedStyles.contains(style);

    return CupertinoButton(
      minSize: 0.0,
      padding: EdgeInsets.zero,
      child: Container(
        width: (MediaQuery.of(context).size.width - 56.0) / 4,
        decoration: ShapeDecoration(
          color: isSelected ? ShownyStyle.mainPurple : ShownyStyle.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color:
                  isSelected ? ShownyStyle.mainPurple : const Color(0xFFEEEEEE),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              style.converToString,
              style: Constants.defaultTextStyle.copyWith(
                color: isSelected ? ShownyStyle.white : const Color(0xFFAAAAAA),
              ),
            ),
          ),
        ),
      ),
      onPressed: () {
        onPressed(style);
        debugPrint(
            'DEBUG: ${isSelected ? 'remove' : 'add'} ${style.converToString} button');
      },
    );
  }
}
