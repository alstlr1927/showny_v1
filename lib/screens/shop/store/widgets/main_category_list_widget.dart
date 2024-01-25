import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/showny_style.dart';

class MainCategoryListWidget extends StatefulWidget {
  final List<String> categoryList;
  final Function(int) onSelectCategory;
  final int? initIndex;

  const MainCategoryListWidget({
    Key? key,
    required this.categoryList,
    required this.onSelectCategory,
    this.initIndex,
  }) : super(key: key);

  @override
  State<MainCategoryListWidget> createState() => _MainCategoryListWidget();
}

class _MainCategoryListWidget extends State<MainCategoryListWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initIndex != null) {
      setState(() {
        selectedIndex = widget.initIndex!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.categoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onSelectCategory(index);
              },
              child: Row(
                children: [
                  Text(
                    widget.categoryList[index],
                    style: selectedIndex == index
                        ? FontHelper.bold_12_000000
                        : ShownyStyle.caption(),
                  ),
                  index != widget.categoryList.length - 1
                      ? const SizedBox(
                          height: 10,
                          child: VerticalDivider(
                            thickness: 1,
                            color: Color(0xFF444444),
                          ),
                        )
                      : const SizedBox()
                ],
              ));
        },
      ),
    );
  }
}
