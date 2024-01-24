import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/filter_minishop_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_button_widget.dart';

import '../../store/widgets/text_field_widget.dart';

class SearchFilterWidgetMinishop extends StatefulWidget {
  final Color? iconColor;
  final String? searchText;
  final FilterMinishopModel filterMinishopModel;

  final Function() resetFilter;
  final Function(FilterMinishopModel) applyFilter;

  const SearchFilterWidgetMinishop({
    Key? key,
    this.iconColor,
    this.searchText,
    required this.filterMinishopModel,
    required this.resetFilter,
    required this.applyFilter,
  }) : super(key: key);

  @override
  State<SearchFilterWidgetMinishop> createState() =>
      _SearchFilterWidgetMinishopState();
}

class _SearchFilterWidgetMinishopState
    extends State<SearchFilterWidgetMinishop> {
  final List<String> _categoryList = [
    tr('mini_shop.filter.category.outer'),
    tr('mini_shop.filter.category.tops'),
    tr('mini_shop.filter.category.bottoms'),
    tr('mini_shop.filter.category.shoes'),
    tr('mini_shop.filter.category.bags')
  ];
  final List<String> _situationList = [
    tr('mini_shop.filter.situation.situation_1'),
    tr('mini_shop.filter.situation.situation_2')
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          showDialog(
              widget.searchText == null
                  ? ""
                  : widget.searchText!.isNotEmpty
                      ? widget.searchText
                      : "",
              widget.filterMinishopModel,
              widget.resetFilter,
              widget.applyFilter);
        },
        child: Consumer<MiniShopSearchProductsProvider>(
            builder: (context, provider, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(filter, height: 20, width: 20),
              const SizedBox(
                width: 32,
              ),
              Container(
                width: 64,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: (widget.filterMinishopModel.minPrice != null ||
                            widget.filterMinishopModel.maxPrice != null)
                        ? black
                        : greyLight.withOpacity(0.3),
                  ),
                  color: (widget.filterMinishopModel.minPrice != null ||
                          widget.filterMinishopModel.maxPrice != null)
                      ? black
                      : white,
                ),
                child: Center(
                    child: Text(
                  tr('mini_shop.filter.filter1'),
                  style: themeData().textTheme.bodySmall!.apply(
                      color: (widget.filterMinishopModel.minPrice != null ||
                              widget.filterMinishopModel.maxPrice != null)
                          ? white
                          : black),
                )),
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              Container(
                width: 64,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: (widget.filterMinishopModel.categoryId != null &&
                            widget.filterMinishopModel.categoryId! > 0)
                        ? black
                        : greyLight.withOpacity(0.3),
                  ),
                  color: (widget.filterMinishopModel.categoryId != null &&
                          widget.filterMinishopModel.categoryId! > 0)
                      ? black
                      : white,
                ),
                child: Center(
                    child: Text(
                  tr('mini_shop.filter.filter2'),
                  style: themeData().textTheme.bodySmall!.apply(
                      color: (widget.filterMinishopModel.categoryId != null &&
                              widget.filterMinishopModel.categoryId! > 0)
                          ? white
                          : black),
                )),
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              Container(
                width: 64,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: (widget.filterMinishopModel.isNew != null &&
                            widget.filterMinishopModel.isNew != 2)
                        ? black
                        : greyLight.withOpacity(0.3),
                    width: 1,
                  ),
                  color: (widget.filterMinishopModel.isNew != null &&
                          widget.filterMinishopModel.isNew != 2)
                      ? black
                      : white,
                ),
                child: Center(
                    child: Text(
                  tr('mini_shop.filter.filter3'),
                  style: themeData().textTheme.bodySmall!.apply(
                      color: (widget.filterMinishopModel.isNew == null ||
                              widget.filterMinishopModel.isNew == 2)
                          ? black
                          : white),
                )),
              )
            ],
          );
        }),
      ),
    );
  }

  showDialog(String? searchKeyword, FilterMinishopModel setFilterMinishopModel,
      Function() resetFilter, Function(FilterMinishopModel) applyFilter) {
    TextEditingController minPriceController = TextEditingController(
        text: setFilterMinishopModel.minPrice?.toString() ?? '');
    TextEditingController maxPriceController = TextEditingController(
        text: setFilterMinishopModel.maxPrice?.toString() ?? '');
    int? selectedCategory = (setFilterMinishopModel.categoryId ?? 1) - 1;
    int? isNew = setFilterMinishopModel.isNew ?? 2;

    void initFilter() {
      minPriceController.text = "";
      maxPriceController.text = "";
      selectedCategory = null;
      isNew = null;
    }

    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.0),
          ),
        ),
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, newState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 24,
                          ),
                          const Spacer(),
                          Text(
                            tr('mini_shop.filter.title'),
                            style: FontHelper.bold_14_000000,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              closeIcon,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Text(tr('mini_shop.filter.filter1'),
                            style: themeData()
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextFieldWidget(
                                  borderRadius: 8,
                                  alignment: TextAlign.center,
                                  borderColor: black,
                                  textInputType: TextInputType.number,
                                  textEditingController: minPriceController,
                                  hintText: tr(
                                      'mini_shop.filter.price.price_start_range'),
                                  hintStyle: ShownyStyle.caption(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              CupertinoIcons.minus,
                              size: 8,
                              color: black,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextFieldWidget(
                                  borderRadius: 8,
                                  alignment: TextAlign.center,
                                  borderColor: black,
                                  textInputType: TextInputType.number,
                                  textEditingController: maxPriceController,
                                  hintText: tr(
                                      'mini_shop.filter.price.price_end_range'),
                                  hintStyle: ShownyStyle.caption(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Text(tr('mini_shop.filter.category.title'),
                            style: themeData()
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 130,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  childAspectRatio:
                                      ((size.width - 46) / 4) / 48,
                                  mainAxisSpacing: 10),
                          itemCount: _categoryList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                newState(() {
                                  selectedCategory = index;
                                });
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selectedCategory == index
                                          ? black
                                          : greyExtraLight),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    _categoryList[index],
                                    style: themeData()
                                        .textTheme
                                        .bodySmall!
                                        .apply(
                                            color: selectedCategory == index
                                                ? black
                                                : textColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Text(tr('mini_shop.filter.situation.title'),
                            style: themeData()
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 100,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  childAspectRatio:
                                      ((size.width - 42) / 2) / 48,
                                  mainAxisSpacing: 10),
                          itemCount: _situationList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                newState(() {
                                  if (index == 0) {
                                    isNew = 0;
                                  } else if (index == 1) {
                                    isNew = 1;
                                  }
                                });
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: (index == 0 && isNew == 0) ||
                                                (index == 1 && isNew == 1)
                                            ? black
                                            : greyExtraLight),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    _situationList[index],
                                    style: themeData()
                                        .textTheme
                                        .bodySmall
                                        ?.apply(
                                            color: (index == 0 && isNew == 0) ||
                                                    (index == 1 && isNew == 1)
                                                ? black
                                                : textColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      SafeArea(
                        child: SizedBox(
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CommonButtonWidget2(
                                    onTap: () {
                                      newState(() {
                                        initFilter();
                                      });

                                      //Navigator.pop(context);
                                    },
                                    color: greyExtraLight,
                                    text: tr('mini_shop.filter.reset'),
                                    textcolor: grey,
                                    radius: 12,
                                    height: 48),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: CommonButtonWidget2(
                                      onTap: () {
                                        FilterMinishopModel
                                            filterMinishopModel =
                                            FilterMinishopModel();
                                        if (minPriceController.text
                                            .trim()
                                            .isNotEmpty) {
                                          filterMinishopModel.minPrice =
                                              int.parse(minPriceController.text
                                                  .trim());
                                        }
                                        if (maxPriceController.text
                                            .trim()
                                            .isNotEmpty) {
                                          filterMinishopModel.maxPrice =
                                              int.parse(maxPriceController.text
                                                  .trim());
                                        }
                                        filterMinishopModel.categoryId =
                                            selectedCategory == null
                                                ? 0
                                                : selectedCategory! + 1;
                                        filterMinishopModel.isNew = isNew;

                                        applyFilter(filterMinishopModel);

                                        // provider.setSelectedCategory(
                                        //     selectedCategory + 1);
                                        // if (minPriceController.text
                                        //     .trim()
                                        //     .isNotEmpty) {
                                        //   provider.setMinPrice(int.parse(
                                        //       minPriceController.text.trim()));
                                        // }
                                        // if (maxPriceController.text
                                        //     .trim()
                                        //     .isNotEmpty) {
                                        //   provider.setMaxPrice(int.parse(
                                        //       maxPriceController.text.trim()));
                                        // }
                                        // if (productType != null) {
                                        //   provider.setProductType(productType!);
                                        // }
                                        // UserProvider userProvider =
                                        //     Provider.of<UserProvider>(context,
                                        //         listen: false);
                                        // final user = userProvider.user;
                                        // Provider.of<MiniShopSearchProductsProvider>(context, listen: false).setSearchText(searchKeyword!.isNotEmpty
                                        //       ? searchKeyword
                                        //       : "");
                                        // provider.getMiniShopProductList(
                                        //   memNo: user.memNo
                                        // );
                                        Navigator.pop(context);
                                      },
                                      color: black,
                                      text: tr('mini_shop.filter.apply'),
                                      textcolor: white,
                                      radius: 12,
                                      height: 48))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
