import 'package:dartx/dartx.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/filter_minishop_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../providers/minishop_search_product_provider.dart';

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
  State<SearchFilterWidgetMinishop> createState() => _SearchFilterWidgetMinishopState();
}

class _SearchFilterWidgetMinishopState extends State<SearchFilterWidgetMinishop> {
  final List<String> _categoryList = [
    tr('mini_shop.filter.category.outer'),
    tr('mini_shop.filter.category.tops'),
    tr('mini_shop.filter.category.bottoms'),
    tr('mini_shop.filter.category.shoes'),
    tr('mini_shop.filter.category.bags')
  ];

  final List<String> _situationList = [tr('mini_shop.filter.situation.situation_1'), tr('mini_shop.filter.situation.situation_2')];

  final List<String> _filterList = [
    tr('mini_shop.filter.filter1'),
    tr('mini_shop.filter.filter2'),
    tr('mini_shop.filter.filter3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          _showDialog(
            widget.searchText == null
                ? ""
                : widget.searchText!.isNotEmpty
                    ? widget.searchText
                    : "",
            widget.filterMinishopModel,
            widget.resetFilter,
            widget.applyFilter,
          );
        },
        child: Consumer<MiniShopSearchProductsProvider>(
          builder: (context, provider, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(filter, height: 20, width: 20),
                SizedBox(width: 12.toWidth),
                SizedBox(
                  height: 24,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => SizedBox(width: 8.toWidth),
                    itemCount: _filterList.length,
                    itemBuilder: (context, index) {
                      String filterText;
                      bool isActive;
                      if (index == 0) {
                        filterText = 'mini_shop.filter.filter1';
                        isActive = widget.filterMinishopModel.minPrice != null || widget.filterMinishopModel.maxPrice != null;
                      } else if (index == 1) {
                        filterText = 'mini_shop.filter.filter2';
                        isActive = widget.filterMinishopModel.categoryId != null && widget.filterMinishopModel.categoryId! > 0;
                      } else {
                        filterText = 'mini_shop.filter.filter3';
                        isActive = widget.filterMinishopModel.isNew != null && widget.filterMinishopModel.isNew != 2;
                      }
                      return _buildFilterItem(
                        filterText: filterText,
                        isActive: isActive,
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterItem({
    required String filterText,
    required bool isActive,
  }) {
    return Container(
      width: 64.toWidth,
      height: 24.toWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isActive ? ShownyStyle.mainPurple : greyLight.withOpacity(.3),
        ),
        color: isActive ? ShownyStyle.mainPurple : ShownyStyle.white,
      ),
      child: Center(
        child: Text(
          tr(filterText),
          style: ShownyStyle.caption(color: isActive ? ShownyStyle.white : Color(0xff777777)),
        ),
      ),
    );
  }

  _showDialog(String? searchKeyword, FilterMinishopModel setFilterMinishopModel, Function() resetFilter, Function(FilterMinishopModel) applyFilter) {
    // TextEditingController minPriceController = TextEditingController(text: setFilterMinishopModel.minPrice?.toString() ?? '');
    // TextEditingController maxPriceController = TextEditingController(text: setFilterMinishopModel.maxPrice?.toString() ?? '');
    int? selectedCategory = (setFilterMinishopModel.categoryId ?? 1) - 1;
    int? isNew = setFilterMinishopModel.isNew ?? 2;
    int? minPrice = setFilterMinishopModel.minPrice ?? 0;
    int? maxPrice = setFilterMinishopModel.maxPrice ?? 1000000;

    ShownyLog().i('model min : ${setFilterMinishopModel.minPrice}');
    ShownyLog().i('model max : ${setFilterMinishopModel.maxPrice}');
    // ShownyLog().i(minPrice.toString());
    // ShownyLog().i(maxPrice.toString());

    SfRangeValues rangeValues = SfRangeValues(minPrice.toDouble(), maxPrice.toDouble());

    void initFilter() {
      // minPriceController.text = "";
      // maxPriceController.text = "";
      selectedCategory = null;
      isNew = null;
      minPrice = null;
      maxPrice = null;
      rangeValues = SfRangeValues(0, 1000000);
    }

    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, newState) {
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 24.toWidth),
                          const Spacer(),
                          Text(
                            tr('mini_shop.filter.title'),
                            style: ShownyStyle.body2(
                              weight: FontWeight.w700,
                              color: ShownyStyle.black,
                            ),
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
                      const SizedBox(height: 30),
                      SizedBox(
                        width: size.width,
                        child: Text(
                          tr('mini_shop.filter.filter1'),
                          style: ShownyStyle.body2(
                            weight: FontWeight.w700,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // SizedBox(
                      //   width: size.width,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Expanded(
                      //         child: SizedBox(
                      //           height: 48,
                      //           child: TextFieldWidget(
                      //             borderRadius: 8,
                      //             alignment: TextAlign.center,
                      //             borderColor: black,
                      //             textInputType: TextInputType.number,
                      //             textEditingController: minPriceController,
                      //             hintText: tr('mini_shop.filter.price.price_start_range'),
                      //             hintStyle: ShownyStyle.caption(),
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 4,
                      //       ),
                      //       const Icon(
                      //         CupertinoIcons.minus,
                      //         size: 8,
                      //         color: black,
                      //       ),
                      //       const SizedBox(
                      //         width: 4,
                      //       ),
                      //       Expanded(
                      //         child: SizedBox(
                      //           height: 48,
                      //           child: TextFieldWidget(
                      //             borderRadius: 8,
                      //             alignment: TextAlign.center,
                      //             borderColor: black,
                      //             textInputType: TextInputType.number,
                      //             textEditingController: maxPriceController,
                      //             hintText: tr('mini_shop.filter.price.price_end_range'),
                      //             hintStyle: ShownyStyle.caption(),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // RangeSlider(
                      //   values: RangeValues(
                      //     rangeMinValue.toDouble(),
                      //     rangeMaxValue.toDouble(),
                      //   ),
                      //   min: 0,
                      //   max: 100,
                      //   divisions: 5,
                      //   labels: RangeLabels('0', '100'),
                      //   activeColor: ShownyStyle.mainPurple,
                      //   // overlayColor: MaterialStatePropertyAll(
                      //   //   ShownyStyle.mainPurple,
                      //   // ),
                      //   onChanged: (value) {},
                      // ),
                      // PriceRangeSlider(rangeValues: rangeValues),
                      Column(
                        children: [
                          Text(
                            rangeValues.start == 0 && rangeValues.end == 1000000 ? '전체' : '${(rangeValues.start / 10000).round()}만원 ~ ${(rangeValues.end / 10000).round()}만원',
                            style: ShownyStyle.caption(
                              color: ShownyStyle.mainPurple,
                              weight: FontWeight.bold,
                            ),
                          ),
                          SfRangeSliderTheme(
                            data: SfRangeSliderThemeData(
                              activeLabelStyle: ShownyStyle.caption(),
                              inactiveLabelStyle: ShownyStyle.caption(),
                              inactiveTickColor: Color(0xffcacdcd),
                              inactiveMinorTickColor: Color(0xffcacdcd),
                              activeTickColor: ShownyStyle.mainPurple,
                              activeMinorTickColor: ShownyStyle.mainPurple,
                              thumbRadius: 8,
                              trackCornerRadius: 0,
                              activeTrackHeight: 3,
                              inactiveTrackHeight: 3,
                              overlayRadius: 0,
                            ),
                            child: SfRangeSlider(
                              min: 0.0,
                              max: 1000000.0,
                              interval: 200000,
                              stepSize: 100000,
                              showTicks: true,
                              showLabels: true,
                              minorTicksPerInterval: 1,
                              activeColor: ShownyStyle.mainPurple,
                              inactiveColor: Color(0xFFCACDCD),
                              tickShape: SfTickShape(),
                              values: rangeValues,
                              onChanged: (SfRangeValues newValues) {
                                if (newValues.start < newValues.end) {
                                  newState(() {
                                    rangeValues = newValues;
                                  });
                                }
                              },
                              labelFormatterCallback: (dynamic actualValue, String formattedText) {
                                if (actualValue is double && actualValue == 1000000.0) {
                                  return '${(formattedText.toInt() / 10000).round()}만원';
                                }
                                return '${(formattedText.toInt() / 10000).round()}만';
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: size.width,
                        child: Text(
                          tr('mini_shop.filter.category.title'),
                          style: ShownyStyle.body2(
                            weight: FontWeight.w700,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 130,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            childAspectRatio: ((size.width - 46) / 4) / 48,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _categoryList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                newState(() {
                                  selectedCategory = index;
                                });
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedCategory == index ? ShownyStyle.mainPurple : Color(0xFFEEEEEE),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    _categoryList[index],
                                    style: ShownyStyle.caption(
                                      color: selectedCategory == index ? ShownyStyle.black : Color(0xFFAAAAAA),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: size.width,
                        child: Text(
                          tr('mini_shop.filter.situation.title'),
                          style: ShownyStyle.body2(
                            weight: FontWeight.w700,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 100,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            childAspectRatio: ((size.width - 42) / 2) / 48,
                            mainAxisSpacing: 10,
                          ),
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
                                    color: (index == 0 && isNew == 0) || (index == 1 && isNew == 1) ? ShownyStyle.mainPurple : Color(0xFFEEEEEE),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    _situationList[index],
                                    // style: themeData().textTheme.bodySmall?.apply(
                                    //       color: (index == 0 && isNew == 0) || (index == 1 && isNew == 1) ? black : textColor,
                                    //     ),
                                    style: ShownyStyle.caption(
                                      color: (index == 0 && isNew == 0) || (index == 1 && isNew == 1) ? black : Color(0xFFAAAAAA),
                                    ),
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
                                child: ShownyButton(
                                  onPressed: () => newState(() => initFilter()),
                                  option: ShownyButtonOption.fill(
                                    text: tr('mini_shop.filter.reset'),
                                    theme: ShownyButtonFillTheme.gray,
                                    style: ShownyButtonFillStyle.fullRegular,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.toWidth),
                              Expanded(
                                flex: 3,
                                child: ShownyButton(
                                  onPressed: () {
                                    FilterMinishopModel filterMinishopModel = FilterMinishopModel();

                                    // if (minPriceController.text.trim().isNotEmpty) {
                                    //   filterMinishopModel.minPrice = int.parse(minPriceController.text.trim());
                                    // }

                                    // if (maxPriceController.text.trim().isNotEmpty) {
                                    //   filterMinishopModel.maxPrice = int.parse(maxPriceController.text.trim());
                                    // }

                                    filterMinishopModel.categoryId = selectedCategory == null ? 0 : selectedCategory! + 1;
                                    filterMinishopModel.isNew = isNew;

                                    filterMinishopModel.minPrice = rangeValues.start.round();
                                    filterMinishopModel.maxPrice = rangeValues.end.round();

                                    applyFilter(filterMinishopModel);

                                    // 원래 주석 되어있던 부분
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
                                  option: ShownyButtonOption.fill(
                                    text: tr('mini_shop.filter.apply'),
                                    theme: ShownyButtonFillTheme.violet,
                                    style: ShownyButtonFillStyle.fullRegular,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PriceRangeSlider extends StatefulWidget {
  SfRangeValues rangeValues;
  PriceRangeSlider({
    super.key,
    required this.rangeValues,
  });

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  @override
  Widget build(BuildContext context) {
    ShownyLog().i(widget.rangeValues.start.toString());
    double startValue = widget.rangeValues.start;
    double endValue = widget.rangeValues.end;

    return Column(
      children: [
        Text(
          widget.rangeValues.start == 0 && widget.rangeValues.end == 100 ? '전체' : '${startValue.round()}만원 ~ ${endValue.round()}만원',
          style: ShownyStyle.caption(
            color: ShownyStyle.mainPurple,
            weight: FontWeight.bold,
          ),
        ),
        SfRangeSliderTheme(
          data: SfRangeSliderThemeData(
            activeLabelStyle: ShownyStyle.caption(),
            inactiveLabelStyle: ShownyStyle.caption(),
            inactiveTickColor: Color(0xffcacdcd),
            inactiveMinorTickColor: Color(0xffcacdcd),
            activeTickColor: ShownyStyle.mainPurple,
            activeMinorTickColor: ShownyStyle.mainPurple,
            thumbRadius: 8,
            trackCornerRadius: 0,
            activeTrackHeight: 3,
            inactiveTrackHeight: 3,
            overlayRadius: 0,
          ),
          child: SfRangeSlider(
            min: 0.0,
            max: 100.0,
            interval: 20,
            stepSize: 10,
            showTicks: true,
            showLabels: true,
            minorTicksPerInterval: 1,
            activeColor: ShownyStyle.mainPurple,
            inactiveColor: Color(0xFFCACDCD),
            tickShape: SfTickShape(),
            values: widget.rangeValues,
            onChanged: (SfRangeValues newValues) {
              if (newValues.start < newValues.end) {
                setState(() {
                  widget.rangeValues = newValues;
                });
              }
            },
            labelFormatterCallback: (dynamic actualValue, String formattedText) {
              if (actualValue is double && actualValue == 100.0) {
                return '${formattedText}만원';
              }
              return '${formattedText}만';
            },
          ),
        ),
      ],
    );
  }
}
