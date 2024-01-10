import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/showny_style.dart';

class SubCategoryListWidget extends StatefulWidget {
  final int? initSubCategoryIndex;
  final List<String> categoryList;
  final Function(int) onSelectCategory;

  const SubCategoryListWidget({
    Key? key,
    required this.categoryList,
    required this.onSelectCategory,
    this.initSubCategoryIndex,
  }) : super(key: key);

  @override
  State<SubCategoryListWidget> createState() => _SubCategoryListWidget();
}

class _SubCategoryListWidget extends State<SubCategoryListWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initSubCategoryIndex != null) {
      setState(() {
        selectedIndex = widget.initSubCategoryIndex!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            child: SizedBox(
                width: 64,
                child: Center(
                    child: Text(
                  widget.categoryList[index],
                  style: selectedIndex == index
                      ? FontHelper.bold_12_000000
                      : ShownyStyle.caption(color: ShownyStyle.gray070),
                ))),
          );
        },
      ),
    );
  }
}
