import 'package:flutter/material.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

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
            focusColor: Colors.amber,
            dropdownColor: Colors.white,
            icon: Padding(
              padding: EdgeInsets.only(left: 6.toWidth),
              child: Image.asset(
                arrowDownIcon,
                width: 12.toWidth,
                height: 12.toWidth,
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
                      style: ShownyStyle.caption(color: Color(0xff777777)),
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
