import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../providers/mini_shop_products_provider.dart';

class MiniShopCategoryListWidget extends StatefulWidget {
  final double? size;

  final int initCategory;
  final Function(int) onSelectCategory;

  const MiniShopCategoryListWidget({
    Key? key,
    this.size,
    required this.onSelectCategory,
    required this.initCategory,
  }) : super(key: key);

  @override
  State<MiniShopCategoryListWidget> createState() => _MiniShopCategoryListWidgetState();
}

class _MiniShopCategoryListWidgetState extends State<MiniShopCategoryListWidget> {
  late int selectedCategory;

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedCategory = widget.initCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MiniShopProductsProvider>(builder: (BuildContext context, provider, Widget? child) {
      return SizedBox(
        height: widget.size ?? 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index) {
            return BaseButton(
              onPressed: () {
                setState(() {
                  selectedCategory = index;
                });
                widget.onSelectCategory(index);
              },
              child: Container(
                width: 64.toWidth,
                alignment: Alignment.center,
                child: Text(
                  provider.categoryList[index],
                  style: index == selectedCategory ? ShownyStyle.caption(weight: FontWeight.bold) : ShownyStyle.caption(color: Color(0xff777777)),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
