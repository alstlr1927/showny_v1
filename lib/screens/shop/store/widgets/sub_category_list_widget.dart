import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

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
              width: 60.toWidth,
              child: Center(
                child: Text(
                  widget.categoryList[index],
                  style: selectedIndex == index
                      ? ShownyStyle.caption(
                          color: ShownyStyle.black, weight: FontWeight.w700)
                      : ShownyStyle.caption(color: Color(0xff777777)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
