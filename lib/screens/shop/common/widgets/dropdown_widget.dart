import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> itemList;
  final Function(int) onSelectItem;

  const DropdownWidget({
    Key? key,
    required this.itemList,
    required this.onSelectItem,
  }) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidget();
}

class _DropdownWidget extends State<DropdownWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: DropdownButtonHideUnderline(
        child: Container(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(BorderSide.none),
          ),
          child: DropdownButton<String>(
            value: widget.itemList[selectedIndex],
            alignment: Alignment.centerRight,
            style: ShownyStyle.caption(color: ShownyStyle.gray060),
            icon: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Image.asset(
                arrowDownIcon,
                width: 20,
                height: 20,
              ),
            ),
            onChanged: (newValue) {
              debugPrint(newValue);
              if (newValue == null) {
                return;
              }
              setState(() {
                int findIndex = 0;
                for (var item in widget.itemList) {
                  if (item == newValue) {
                    selectedIndex = findIndex;
                    break;
                  }
                  findIndex += 1;
                }
                widget.onSelectItem(findIndex);
              });
            },
            items: widget.itemList.map((String item) {
              return DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    color: Colors.white,
                    height: 24,
                    child: Center(
                        child: Text(
                      item,
                      style: ShownyStyle.caption(color: ShownyStyle.gray060),
                    )),
                  ));
            }).toList(),
          ),
        ),
      ),

      // GestureDetector(
      //   onTap: () {

      //   },
      //   child: Row(
      //     children: [
      //       const Spacer(),
      //       Text(widget.itemList[selectedIndex]),
      //       const SizedBox(width: 4,),
      //       Image.asset(
      //         arrowDownIcon,
      //         width: 20,
      //         height: 20,
      //       )
      //     ],
      //   ),
      // )
    );
  }
}
