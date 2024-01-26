import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/theme.dart';

import '../providers/mini_shop_products_provider.dart';

class MiniShopCategoryListWidget extends StatefulWidget {
  final double? size;
  final Decoration? decoration;
  final int initCategory;
  final Function(int) onSelectCategory;

  const MiniShopCategoryListWidget({
    Key? key,
    this.size,
    this.decoration,
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
    Size size = MediaQuery.of(context).size;
    return Consumer<MiniShopProductsProvider>(builder: (BuildContext context, provider, Widget? child) {
      return SizedBox(
        height: widget.size ?? 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
                widget.onSelectCategory(index);
              },
              child: Container(
                width: 64,
                decoration: widget.decoration,
                child: Center(
                  child: Text(
                    provider.categoryList[index],
                    style:
                        themeData().textTheme.bodySmall!.copyWith(color: (index == selectedCategory) ? black : greyLight, fontWeight: (index == selectedCategory) ? FontWeight.w700 : FontWeight.w400),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
