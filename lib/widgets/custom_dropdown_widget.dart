import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:showny/utils/theme.dart';

class CustomDropDown extends StatefulWidget {
  String? selectedItem;
  List<String> dropDownItems;
  String hintText;
  Function onChanged;

  CustomDropDown(
      {super.key,
        required this.dropDownItems,
        required this.hintText,
        required this.selectedItem,
        required this.onChanged});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isDropDownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.selectedItem == null ? Colors.white : Colors.black,
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
        iconStyleData: IconStyleData(
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            iconEnabledColor:
            widget.selectedItem != null ? Colors.white : Colors.black),
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
            Text(value, style: const TextStyle(color: Colors.white)))
            .toList(),
        value: widget.selectedItem,
        style: themeData().textTheme.headlineSmall,
        hint: Text(
          widget.hintText,
        ),
        decoration: InputDecoration(
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
        ),
        items: widget.dropDownItems.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
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
