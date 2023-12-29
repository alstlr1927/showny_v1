import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SVDropdownPicker extends StatefulWidget {
  const SVDropdownPicker({
    Key? key,
    required this.hintText,
    required this.items,
    this.selectedValue,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final List<String> items;
  final int? selectedValue;
  final Function(int)? onChanged;

  @override
  State<SVDropdownPicker> createState() => _SVDropdownPicker();
}

class _SVDropdownPicker extends State<SVDropdownPicker> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.selectedValue ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return 
            SizedBox(
              height: 248,
              child: Column(
              
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xff999999),
                        width: 0.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 5.0,
                        ),
                        child: Text(tr("common.cancel")),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          if(widget.onChanged != null) {
                            widget.onChanged!(_selectedIndex);
                          }
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 5.0,
                        ),
                        child: Text(tr("common.confirm")),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  color: const Color(0xfff7f7f7),
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: widget.selectedValue ?? 0),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    itemExtent: 40,
                    children: widget.items.map((String item) {
                      return Center(
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            );
          },
        );
      },
      child: Container(
        height: 48,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedValue == null ? widget.hintText : widget.items[widget.selectedValue!],
              style: TextStyle(
                color: widget.selectedValue != null ? Colors.black : Colors.black38,
                fontSize: 14,
                fontFamily: 'Spoqa Han Sans Neo',
              ),
            ),
            Image.asset(
              "assets/icons/arrow_dropdown.png",
              width: 12,
              height: 12,
              // 기타 이미지 설정
            ),
          ],
        ),
      ),
    );
  }
}