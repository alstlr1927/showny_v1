import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/components/drag_to_dispose/drag_to_dispose.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/screens/upload/styleup/types/item_category.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class SelectItemCategory extends StatefulWidget {
  final Function(int idx) onSelect;
  const SelectItemCategory({
    super.key,
    required this.onSelect,
  });

  @override
  State<SelectItemCategory> createState() => _SelectItemCategoryState();
}

class _SelectItemCategoryState extends State<SelectItemCategory> {
  String selectCategory = '';
  int selectIdx = -1;

  @override
  Widget build(BuildContext context) {
    return DragToDispose(
      maxHeight: 450,
      dragEnable: true,
      backdropTapClosesPanel: true,
      onPageClosed: () {
        Navigator.pop(context);
      },
      panelBuilder: (sc, ac) {
        return Container();
      },
      header: Material(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: Container(
          width: ScreenUtil().screenWidth,
          height: 450,
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          decoration: const BoxDecoration(
            color: ShownyStyle.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                '카테고리',
                style: ShownyStyle.body2(
                    color: ShownyStyle.black, weight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              ...ItemCategory.values
                  .asMap()
                  .entries
                  .map(
                    (category) => _buildItem(category: category.value),
                  )
                  .superJoin(const SizedBox(height: 2)),
              const Spacer(),
              ShownyButton(
                onPressed: selectCategory.isEmpty
                    ? null
                    : () {
                        widget.onSelect(selectIdx);
                      },
                option: ShownyButtonOption.fill(
                  text: '선택하기',
                  theme: ShownyButtonFillTheme.violet,
                  style: ShownyButtonFillStyle.fullRegular,
                ),
              ),
              SizedBox(height: ShownyStyle.defaultBottomPadding()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({required ItemCategory category}) {
    bool isSelect = selectCategory == category.name;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (isSelect) {
          selectCategory = '';
          selectIdx = -1;
        } else {
          selectCategory = category.name;
          selectIdx = category.idx;
        }

        setState(() {});
      },
      child: Container(
        color: Colors.white,
        width: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          category.convertToString,
          style: ShownyStyle.body2(
              color: isSelect ? ShownyStyle.black : const Color(0xffd9d9d9),
              weight: isSelect ? FontWeight.bold : FontWeight.w400),
        ),
      ),
    );
  }
}
