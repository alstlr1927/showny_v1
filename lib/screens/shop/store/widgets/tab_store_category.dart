import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/screens/shop/store/store_goods_list_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class TabStoreCategory extends StatefulWidget {
  const TabStoreCategory({super.key});

  @override
  State<TabStoreCategory> createState() => _TabStoreCategoryState();
}

enum GenderType {
  male(0),
  female(1),
  none(-1);

  const GenderType(this.code);
  final int code;
}

enum CategoryType {
  outer('아우터', 1),
  top('상의', 2),
  bottom('하의', 3),
  shoes('신발', 4),
  accessory('악세서리', 5),
  stuff('잡화', 6);

  const CategoryType(this.name, this.code);
  final String name;
  final int code;
}

class _TabStoreCategoryState extends State<TabStoreCategory> {
  GenderType selectGender = GenderType.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, layout) {
        return Container(
          width: ScreenUtil().screenWidth,
          height: double.infinity,
          child: Stack(
            children: [
              AnimatedPositioned(
                right: _getFemalePadding(),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: GestureDetector(
                  onTap: () {
                    if (selectGender == GenderType.female) {
                      selectGender = GenderType.none;
                    } else {
                      selectGender = GenderType.female;
                    }
                    setState(() {});
                  },
                  child: _femaleBox(layout),
                ),
              ),
              AnimatedPositioned(
                left: _getMalePadding(),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: GestureDetector(
                  onTap: () {
                    if (selectGender == GenderType.male) {
                      selectGender = GenderType.none;
                    } else {
                      selectGender = GenderType.male;
                    }
                    setState(() {});
                  },
                  child: _maleBox(layout),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _femaleBox(BoxConstraints layout) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: layout.maxHeight,
      color: Color(0xffe4e4e4),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 30.toWidth),
              child: Column(
                children: [
                  const Spacer(),
                  ...CategoryType.values
                      .map((category) => _categoryItem(category))
                      .superJoin(
                        Container(
                          height: 1,
                          color: Color(0xffb6b6b6),
                        ),
                      )
                      .toList(),
                  SizedBox(height: 28.toWidth),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: AnimatedOpacity(
              opacity: selectGender == GenderType.male ? 0 : 1,
              duration: const Duration(milliseconds: 150),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'WOMAN',
                  style: ShownyStyle.body1(weight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _maleBox(BoxConstraints layout) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: layout.maxHeight,
      color: Color(0xffF7F7F7),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: AnimatedOpacity(
              opacity: selectGender == GenderType.female ? 0 : 1,
              duration: const Duration(milliseconds: 150),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'MAN',
                  style: ShownyStyle.body1(weight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: 30.toWidth),
              child: Column(
                children: [
                  const Spacer(),
                  ...CategoryType.values
                      .map((category) => _categoryItem(category))
                      .toList()
                      .superJoin(
                        Container(
                          height: 1,
                          color: Color(0xffb6b6b6),
                        ),
                      ),
                  SizedBox(height: 28.toWidth),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(CategoryType type) {
    return BaseButton(
      onPressed: () {
        Navigator.push(
            context,
            ShownyPageRoute(
              builder: (context) => StoreGoodsListScreen(
                  mainCategory: selectGender.code, subCategory: type.code),
            ));
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.toWidth),
            child: Row(
              children: [
                Text(
                  type.name,
                  style: ShownyStyle.caption(),
                ),
                const Spacer(),
                Image.asset(
                  'assets/icons/shop/shop_category_arrow.png',
                  width: 12.toWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getFemalePadding() {
    switch (selectGender) {
      case GenderType.female:
        return 0.0;
      case GenderType.male:
        return ScreenUtil().screenWidth;
      case GenderType.none:
        return ScreenUtil().screenWidth / 2;
      default:
        return ScreenUtil().screenWidth / 2;
    }
  }

  _getMalePadding() {
    switch (selectGender) {
      case GenderType.female:
        return ScreenUtil().screenWidth;
      case GenderType.male:
        return 0.0;
      case GenderType.none:
        return ScreenUtil().screenWidth / 2;
      default:
        return ScreenUtil().screenWidth / 2;
    }
  }
}
