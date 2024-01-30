import 'package:dartx/dartx.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:logger/logger.dart';
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

  final List<String> _situationList = [
    tr('mini_shop.filter.situation.situation_1'),
    tr('mini_shop.filter.situation.situation_2'),
  ];

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

  _showDialog(
    String? searchKeyword,
    FilterMinishopModel setFilterMinishopModel,
    Function() resetFilter,
    Function(FilterMinishopModel) applyFilter,
  ) {
    // TextEditingController minPriceController = TextEditingController(text: setFilterMinishopModel.minPrice?.toString() ?? '');
    // TextEditingController maxPriceController = TextEditingController(text: setFilterMinishopModel.maxPrice?.toString() ?? '');
    int? selectedCategory = (setFilterMinishopModel.categoryId ?? 1) - 1;
    int? isNew = setFilterMinishopModel.isNew ?? 2;

    bool isSelectPriceMode = setFilterMinishopModel.minPrice != null && setFilterMinishopModel.maxPrice != null;
    SfRangeValues rangeValues = SfRangeValues(
      ((setFilterMinishopModel.minPrice?.toDouble()) ?? 0.0) / 10000,
      (setFilterMinishopModel.maxPrice?.toDouble() ?? 100.0) / 10000,
    );

    void initFilter() {
      isSelectPriceMode = false;
      selectedCategory = null;
      isNew = null;
    }

    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, newState) => FractionallySizedBox(
            heightFactor: 0.8,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 16.toWidth),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 32.toWidth),
                          const Spacer(),
                          Center(
                            child: Text(
                              tr('mini_shop.filter.title'),
                              style: ShownyStyle.body2(weight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('mini_shop.filter.filter1'),
                                  style: ShownyStyle.body2(
                                    weight: FontWeight.w700,
                                    color: Color(0xFF555555),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '가격 설정',
                                  style: ShownyStyle.overline(
                                    color: Color(0xff777777),
                                  ),
                                ),
                                SizedBox(width: 6.toWidth),
                                FlutterSwitch(
                                  value: isSelectPriceMode,
                                  activeColor: ShownyStyle.mainPurple,
                                  width: 32,
                                  height: 18,
                                  padding: 2,
                                  toggleSize: 14,
                                  borderRadius: 30,
                                  onToggle: (value) {
                                    isSelectPriceMode = value;
                                    rangeValues = SfRangeValues(0.0, 100.0);
                                    newState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _PriceRangeSlider(
                              rangeValues: rangeValues,
                              onChanged: isSelectPriceMode
                                  ? (newValues) {
                                      if (newValues.start < newValues.end) {
                                        newState(() {
                                          rangeValues = newValues;
                                        });
                                      }
                                    }
                                  : null,
                            ),
                            const SizedBox(height: 40),
                            Text(
                              tr('mini_shop.filter.category.title'),
                              style: ShownyStyle.body2(
                                weight: FontWeight.w700,
                                color: Color(0xFF555555),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 130,
                              child: GridView.builder(
                                shrinkWrap: true,
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
                              height: 50,
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
                                      height: 40,
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
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(16.toWidth, 10.toWidth, 16.toWidth, ShownyStyle.defaultBottomPadding()),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       ShownyButton(
                    //         onPressed: () => newState(() => initFilter()),
                    //         option: ShownyButtonOption.fill(
                    //           text: tr('mini_shop.filter.reset'),
                    //           theme: ShownyButtonFillTheme.gray,
                    //           style: ShownyButtonFillStyle.fullRegular,
                    //         ),
                    //       ),
                    //       SizedBox(width: 10.toWidth),
                    //       Expanded(
                    //         child: ShownyButton(
                    //           onPressed: () {
                    //             FilterMinishopModel filterMinishopModel = FilterMinishopModel();

                    //             filterMinishopModel.categoryId = selectedCategory == null ? 0 : selectedCategory! + 1;
                    //             filterMinishopModel.isNew = isNew;

                    //             if (isSelectPriceMode) {
                    //               filterMinishopModel.minPrice = (rangeValues.start as double).toInt() * 10000;
                    //               filterMinishopModel.maxPrice = (rangeValues.end as double).toInt() * 10000;
                    //             }
                    //             applyFilter(filterMinishopModel);

                    //             // 원래 주석 되어있던 부분
                    //             // provider.setSelectedCategory(
                    //             //     selectedCategory + 1);
                    //             // if (minPriceController.text
                    //             //     .trim()
                    //             //     .isNotEmpty) {
                    //             //   provider.setMinPrice(int.parse(
                    //             //       minPriceController.text.trim()));
                    //             // }
                    //             // if (maxPriceController.text
                    //             //     .trim()
                    //             //     .isNotEmpty) {
                    //             //   provider.setMaxPrice(int.parse(
                    //             //       maxPriceController.text.trim()));
                    //             // }
                    //             // if (productType != null) {
                    //             //   provider.setProductType(productType!);
                    //             // }
                    //             // UserProvider userProvider =
                    //             //     Provider.of<UserProvider>(context,
                    //             //         listen: false);
                    //             // final user = userProvider.user;
                    //             // Provider.of<MiniShopSearchProductsProvider>(context, listen: false).setSearchText(searchKeyword!.isNotEmpty
                    //             //       ? searchKeyword
                    //             //       : "");
                    //             // provider.getMiniShopProductList(
                    //             //   memNo: user.memNo
                    //             // );
                    //             Navigator.pop(context);
                    //           },
                    //           option: ShownyButtonOption.fill(
                    //             text: tr('mini_shop.filter.apply'),
                    //             theme: ShownyButtonFillTheme.violet,
                    //             style: ShownyButtonFillStyle.fullRegular,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PriceRangeSlider extends StatefulWidget {
  final SfRangeValues rangeValues;
  final Function(SfRangeValues newValues)? onChanged;

  _PriceRangeSlider({
    required this.rangeValues,
    this.onChanged,
  });

  @override
  State<_PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<_PriceRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.onChanged == null ? '전체' : '${widget.rangeValues.start.round()}만원 ~ ${widget.rangeValues.end.round()}만원',
          style: ShownyStyle.caption(
            color: widget.onChanged == null ? const Color(0xff777777) : ShownyStyle.mainPurple,
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
            onChanged: widget.onChanged,
            labelFormatterCallback: (dynamic actualValue, String formattedText) {
              Logger().i(actualValue);
              if (actualValue is double && actualValue == 100.0) {
                return '$formattedText만원';
              } else if (actualValue is double && actualValue == 0) {
                return '$formattedText원';
              } else {
                return '$formattedText만';
              }
            },
          ),
        ),
      ],
    );
  }
}
