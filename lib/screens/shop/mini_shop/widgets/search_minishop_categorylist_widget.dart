import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/models/filter_minishop_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/theme.dart';

class SearchMiniShopCategoryListWidget extends StatefulWidget {
  final double? size;
  final Decoration? decoration;
  final String? searchKeyword;

  final FilterMinishopModel filterMinishopModel;
  final Function(int) selectCategoryIndex;

  const SearchMiniShopCategoryListWidget({
    Key? key,
    this.size,
    this.decoration,
    this.searchKeyword,
    required this.filterMinishopModel,
    required this.selectCategoryIndex,
  }) : super(key: key);

  @override
  State<SearchMiniShopCategoryListWidget> createState() =>
      _SearchMiniShopCategoryListWidgetState();
}

class _SearchMiniShopCategoryListWidgetState
    extends State<SearchMiniShopCategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MiniShopSearchProductsProvider>(
        builder: (BuildContext context, provider, Widget? child) {
      return SizedBox(
        height: widget.size ?? 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                widget.selectCategoryIndex(index);

                // provider.setSelectedCategory(index);
                UserProvider userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                final user = userProvider.user;
                // provider.setSearchText(widget.searchKeyword!.isNotEmpty
                //         ? widget.searchKeyword!
                //         : "");
                provider.getMiniShopProductList(
                    memNo: user.memNo,
                    keyword: widget.searchKeyword!.isNotEmpty
                        ? widget.searchKeyword!
                        : "",
                    filterMinishopModel: widget.filterMinishopModel);
              },
              child: Container(
                  width: size.width * 0.16,
                  decoration: widget.decoration,
                  child: Center(
                      child: Text(
                    provider.categoryList[index],
                    style: themeData().textTheme.bodySmall!.copyWith(
                        color: (index == widget.filterMinishopModel.categoryId)
                            ? black
                            : greyLight,
                        fontWeight:
                            (index == widget.filterMinishopModel.categoryId)
                                ? FontWeight.w700
                                : FontWeight.w400),
                  ))),
            );
          },
        ),
      );
    });
  }
}
