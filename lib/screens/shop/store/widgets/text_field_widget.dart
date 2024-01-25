import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/showny_style.dart';

class TextFieldWidget extends StatefulWidget {
  final double? width;
  final double? height;

  final TextStyle? styleFont;

  final String? hintText;
  final TextStyle? hintStyle;

  final TextEditingController? textEditingController;
  final double? borderRadius;
  final Widget? suffix;
  final Color? borderColor;

  final bool? readOnly;
  final VoidCallback? onTap;
  final bool? isExpanded;
  final String? errorText;
  final Function(String)? onChange;
  final int? maxWord;

  final TextAlign? alignment;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  final Widget? suffixIcon;

  const TextFieldWidget({
    Key? key,
    this.width,
    this.height,
    this.hintText,
    this.hintStyle,
    this.textEditingController,
    this.borderRadius,
    this.suffix,
    this.borderColor,
    this.styleFont,
    this.readOnly,
    this.onTap,
    this.isExpanded,
    this.errorText,
    this.onChange,
    this.maxWord,
    this.alignment,
    this.textInputType,
    this.textInputAction,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidget();
}

class _TextFieldWidget extends State<TextFieldWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.textEditingController ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height ?? 48,
          child: TextFormField(
            controller: _controller,
            onTap: widget.onTap,
            onChanged: (value) {
              setState(() {});
              if (widget.onChange != null) {
                widget.onChange!(value);
              }
            },
            textAlign: widget.alignment ?? TextAlign.start,
            style: widget.styleFont ?? FontHelper.regular_14_000000,
            cursorColor: Colors.black,
            maxLength: widget.maxWord,
            maxLines: widget.isExpanded == null
                ? 1
                : widget.isExpanded == false
                    ? 1
                    : 999,
            keyboardType: widget.textInputType ?? TextInputType.name,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: widget.maxWord == null
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                  : const EdgeInsets.only(
                      left: 16, right: 48, top: 16, bottom: 16),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.transparent),
              ),
              filled: true,
              fillColor: Colors.white,
              suffix: widget.suffix,
              suffixIcon: widget.suffixIcon,
              errorMaxLines: 1,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? ShownyStyle.body2(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 16, bottom: 18),
          child: Text(
            widget.maxWord != null
                ? "${_controller.text.length}/${widget.maxWord}"
                : "",
            style: ShownyStyle.overline(),
          ),
        )
      ],
    );
  }
}
