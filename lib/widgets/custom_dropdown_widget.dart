import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/theme.dart';

class CustomDropDown extends StatefulWidget {
  String? selectedItem;
  List<String> dropDownItems;
  String hintText;
  Function onChanged;
  EdgeInsets? padding;

  CustomDropDown(
      {super.key,
      required this.dropDownItems,
      required this.hintText,
      required this.selectedItem,
      required this.onChanged,
      this.padding});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isDropDownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isDropDownOpen
            ? const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))
            : BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField2<String>(
        onMenuStateChange: (open) {
          setState(() {
            isDropDownOpen = open;
          });
        },
        iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_sharp),
            iconEnabledColor: Colors.black),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              border: Border.all(color: Colors.black)),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        selectedItemBuilder: (BuildContext context) => widget.dropDownItems
            .map((String value) =>
                Text(value, style: const TextStyle(color: Colors.black)))
            .toList(),
        value: widget.selectedItem,
        style: themeData().textTheme.bodyMedium,
        hint: Text(
          widget.hintText,
        ),
        decoration: InputDecoration(
            contentPadding: widget.padding,
            border: OutlineInputBorder(
              borderRadius: isDropDownOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8), topRight: Radius.circular(8))
                  : BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: isDropDownOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8), topRight: Radius.circular(8))
                  : BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: isDropDownOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8), topRight: Radius.circular(8))
                  : BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
            hintStyle: themeData().textTheme.bodyMedium),
        items: widget.dropDownItems.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: themeData().textTheme.bodyMedium,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          widget.onChanged(newValue);
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
    );
  }
}

class CustomDropDown2 extends StatefulWidget {
  String? selectedItem;
  List<String> dropDownItems;
  Function onChanged;

  CustomDropDown2(
      {super.key,
      required this.dropDownItems,
      required this.selectedItem,
      required this.onChanged});

  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {
  bool isDropDownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: const BoxDecoration(
        color: white,
      ),
      child: DropdownButtonFormField2<String>(
        onMenuStateChange: (open) {
          setState(() {
            isDropDownOpen = open;
          });
        },
        iconStyleData: IconStyleData(
            icon: Image.asset(
              arrowDownIcon,
              width: 20,
              height: 20,
            ),
            iconEnabledColor: greyExtraLight),
        alignment: Alignment.topRight,
        dropdownStyleData: DropdownStyleData(
          elevation: 0,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(color: greyExtraLight, width: 2),
          ),
        ),
        selectedItemBuilder: (BuildContext context) => widget.dropDownItems
            .map(
              (String value) => Text(
                value,
                style: themeData().textTheme.bodySmall?.apply(color: textColor),
              ),
            )
            .toList(),
        value: widget.selectedItem,
        style: themeData().textTheme.bodySmall?.apply(color: textColor),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: white),
          ),
        ),
        items: widget.dropDownItems.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: themeData().textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: widget.selectedItem != value ? textColor : black),
                ),
                const Divider(
                  color: border,
                  thickness: 0.5,
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          widget.onChanged(newValue);
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
        isExpanded: true,
      ),
    );
  }
}
