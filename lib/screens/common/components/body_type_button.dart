import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/body.dart';

class BodyTypeButton extends StatefulWidget {
  const BodyTypeButton({
    super.key,
    required this.bodyType,
    this.selectedBodyType,
    required this.onPressed,
    this.itemPadding = 30,
    this.itemWidth,
    this.isSelected = false,
    this.selectedBodyTypeList,
    required this.enableMultiSelect,
  });

  final BodyType bodyType;
  final BodyType? selectedBodyType;
  final List<BodyType>? selectedBodyTypeList;
  final Function(BodyType) onPressed;
  final double itemPadding;
  final double? itemWidth;
  final bool isSelected;
  final bool enableMultiSelect;

  @override
  State<BodyTypeButton> createState() => _BodyTypeButtonState();
}

class _BodyTypeButtonState extends State<BodyTypeButton> {
  @override
  Widget build(BuildContext context) {
    final containerWidth =
        widget.itemWidth ?? (MediaQuery.of(context).size.width - 48.0) / 3;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            width: containerWidth,
            height: containerWidth,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: widget.isSelected
                      ? Colors.black
                      : const Color(0xFFEEEEEE),
                  width: widget.isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.itemPadding),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    widget.isSelected ? Colors.black : const Color(0xFFAAAAAA),
                    BlendMode.srcIn),
                child: Image.asset(widget.bodyType.iconPath),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            widget.bodyType.convertToString,
            style: Constants.defaultTextStyle.copyWith(
              color: widget.isSelected ? Colors.black : const Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
      onPressed: () {
        widget.onPressed(widget.bodyType);
        debugPrint('DEBUG: tap ${widget.bodyType.convertToString} button');
      },
    );
  }
}
