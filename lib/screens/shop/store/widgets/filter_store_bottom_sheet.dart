import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:showny/models/filter_shop_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/custom_slider_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../components/showny_button/showny_button.dart';
import '../models/color_model.dart';
import '../models/style_model.dart';

void showStoreFilterBottomSheet(
    BuildContext context,
    FilterShopModel setFilterShopModel,
    Function() resetFilter,
    Function(FilterShopModel) applyFilter) {
  Size size = MediaQuery.of(context).size;

  bool isSelectPriceMode = setFilterShopModel.minPrice != null &&
      setFilterShopModel.maxPrice != null;
  SfRangeValues rangeValues = SfRangeValues(
      ((setFilterShopModel.minPrice?.toDouble()) ?? 0.0) / 10000,
      (setFilterShopModel.maxPrice?.toDouble() ?? 100.0) / 10000);
  List<int> styleIdList = [...setFilterShopModel.styleIdList];
  List<int> fitIdList = [...setFilterShopModel.fitIdList];
  List<int> materialIdList = [...setFilterShopModel.materialIdList];
  List<int> colorIdList = [...setFilterShopModel.colorList];
  double flexibility = 1;

  bool isShowFit = false;
  bool isShowMaterial = false;
  bool isShowFlexiblity = false;
  bool isShowColor = false;

  void initFilter() {
    isSelectPriceMode = false;
    rangeValues = SfRangeValues(0.0, 100.0);
    styleIdList.clear();
    fitIdList.clear();
    materialIdList.clear();
    colorIdList.clear();
    flexibility = 1;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
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
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.toWidth, vertical: 16.toWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        const Spacer(),
                        Center(
                            child: Text(
                          tr('store.filter.title'),
                          style: ShownyStyle.body2(weight: FontWeight.bold),
                        )),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tr('store.filter.options.price'),
                                style: ShownyStyle.body2(
                                    color: const Color(0xff555555),
                                    weight: FontWeight.bold),
                              ),
                              const Spacer(),
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
                                // padding: 0,
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
                          _StorePriceRangeSlider(
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
                            tr('store.filter.options.style'),
                            style: ShownyStyle.body2(
                                color: const Color(0xff555555),
                                weight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: styleData.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 84 / 35,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              bool isSelected =
                                  styleIdList.contains(styleData[index].id);
                              return BaseButton(
                                onPressed: () {
                                  newState(
                                    () {
                                      if (isSelected) {
                                        styleIdList.remove(styleData[index].id);
                                      } else {
                                        styleIdList.add(styleData[index].id);
                                      }
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: isSelected
                                        ? ShownyStyle.mainPurple
                                        : ShownyStyle.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? ShownyStyle.mainPurple
                                          : ShownyStyle.gray040,
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    tr(styleData[index].name),
                                    style: isSelected
                                        ? ShownyStyle.caption(
                                            color: ShownyStyle.white,
                                            weight: FontWeight.w500)
                                        : ShownyStyle.caption(
                                            color: const Color(0xffaaaaaa)),
                                  )),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              newState(() {
                                isShowFit = !isShowFit;
                              });
                            },
                            child: Container(
                              color: white,
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("store.filter.options.fit"),
                                    style: ShownyStyle.body2(
                                        color: const Color(0xff555555),
                                        weight: FontWeight.bold),
                                  ),
                                  AnimatedRotation(
                                    turns: isShowFit ? .5 : 1,
                                    duration: const Duration(milliseconds: 200),
                                    child: Image.asset(
                                      'assets/icons/shop/filter_tab_down_arrow.png',
                                      color: greyLight,
                                      height: 20.toWidth,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: isShowFit
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: fitData.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 84 / 35,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                    ),
                                    itemBuilder: (context, index) {
                                      bool isSelected =
                                          fitIdList.contains(fitData[index].id);
                                      return BaseButton(
                                        onPressed: () {
                                          newState(
                                            () {
                                              if (isSelected) {
                                                fitIdList
                                                    .remove(fitData[index].id);
                                              } else {
                                                fitIdList
                                                    .add(fitData[index].id);
                                              }
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: isSelected
                                                ? ShownyStyle.mainPurple
                                                : ShownyStyle.white,
                                            border: Border.all(
                                              color: isSelected
                                                  ? ShownyStyle.mainPurple
                                                  : ShownyStyle.gray040,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              tr(fitData[index].name),
                                              style: isSelected
                                                  ? ShownyStyle.caption(
                                                      color: ShownyStyle.white,
                                                      weight: FontWeight.w500)
                                                  : ShownyStyle.caption(
                                                      color: const Color(
                                                          0xffaaaaaa)),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Divider(
                                    color: greyExtraLight,
                                    thickness: 1,
                                  ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              newState(() {
                                isShowMaterial = !isShowMaterial;
                              });
                            },
                            child: Container(
                              color: white,
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("store.filter.options.main_material"),
                                    style: ShownyStyle.body2(
                                        color: const Color(0xff555555),
                                        weight: FontWeight.bold),
                                  ),
                                  AnimatedRotation(
                                    turns: isShowMaterial ? .5 : 1,
                                    duration: const Duration(milliseconds: 200),
                                    child: Image.asset(
                                      'assets/icons/shop/filter_tab_down_arrow.png',
                                      color: greyLight,
                                      height: 20.toWidth,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: isShowMaterial
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: materialData.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 84 / 35,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                    ),
                                    itemBuilder: (context, index) {
                                      bool isSelected = materialIdList
                                          .contains(materialData[index].id);
                                      return BaseButton(
                                        onPressed: () {
                                          newState(
                                            () {
                                              if (isSelected) {
                                                materialIdList.remove(
                                                    materialData[index].id);
                                              } else {
                                                materialIdList.add(
                                                    materialData[index].id);
                                              }
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: isSelected
                                                ? ShownyStyle.mainPurple
                                                : ShownyStyle.white,
                                            border: Border.all(
                                              color: isSelected
                                                  ? ShownyStyle.mainPurple
                                                  : ShownyStyle.gray040,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            tr(materialData[index].name),
                                            style: isSelected
                                                ? ShownyStyle.caption(
                                                    color: ShownyStyle.white,
                                                    weight: FontWeight.w500)
                                                : ShownyStyle.caption(
                                                    color: const Color(
                                                        0xffaaaaaa)),
                                          )),
                                        ),
                                      );
                                    },
                                  )
                                : const Divider(
                                    color: greyExtraLight,
                                    thickness: 1,
                                  ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              newState(() {
                                isShowFlexiblity = !isShowFlexiblity;
                              });
                            },
                            child: Container(
                              color: white,
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("store.filter.options.flexibility"),
                                    style: ShownyStyle.body2(
                                        color: const Color(0xff555555),
                                        weight: FontWeight.bold),
                                  ),
                                  isShowFlexiblity && flexibility == 1
                                      ? Text(
                                          tr("무관"),
                                          style: ShownyStyle.body2(
                                              weight: FontWeight.bold),
                                        )
                                      : isShowFlexiblity && flexibility == 2
                                          ? Text(
                                              tr("store.filter.options.almost_none"),
                                              style: ShownyStyle.body2(
                                                  weight: FontWeight.bold),
                                            )
                                          : isShowFlexiblity && flexibility == 3
                                              ? Text(
                                                  tr("store.filter.options.slightly_none"),
                                                  style: ShownyStyle.body2(
                                                      weight: FontWeight.bold),
                                                )
                                              : isShowFlexiblity &&
                                                      flexibility == 4
                                                  ? Text(
                                                      tr("store.filter.options.commonly"),
                                                      style: ShownyStyle.body2(
                                                          weight:
                                                              FontWeight.bold),
                                                    )
                                                  : isShowFlexiblity &&
                                                          flexibility == 5
                                                      ? Text(
                                                          tr("store.filter.options.little_bit"),
                                                          style:
                                                              ShownyStyle.body2(
                                                                  weight:
                                                                      FontWeight
                                                                          .bold),
                                                        )
                                                      : isShowFlexiblity &&
                                                              flexibility == 6
                                                          ? Text(
                                                              tr("store.filter.options.very_present"),
                                                              style: ShownyStyle.body2(
                                                                  weight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                  AnimatedRotation(
                                    turns: isShowFlexiblity ? .5 : 1,
                                    duration: const Duration(milliseconds: 200),
                                    child: Image.asset(
                                      'assets/icons/shop/filter_tab_down_arrow.png',
                                      color: greyLight,
                                      height: 20.toWidth,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: isShowFlexiblity
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomSlider(
                                        value: flexibility,
                                        onChanged: (value) {
                                          newState(
                                            () {
                                              flexibility = value;
                                            },
                                          );
                                        }),
                                  )
                                : const Divider(
                                    color: greyExtraLight,
                                    thickness: 1,
                                  ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              newState(() {
                                isShowColor = !isShowColor;
                              });
                            },
                            child: Container(
                              color: white,
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr("store.filter.options.color"),
                                    style: ShownyStyle.body2(
                                        color: const Color(0xff555555),
                                        weight: FontWeight.bold),
                                  ),
                                  AnimatedRotation(
                                    turns: isShowColor ? .5 : 1,
                                    duration: const Duration(milliseconds: 200),
                                    child: Image.asset(
                                      'assets/icons/shop/filter_tab_down_arrow.png',
                                      color: greyLight,
                                      height: 20.toWidth,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: isShowColor
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: colorData.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 1.2,
                                    ),
                                    itemBuilder: (context, index) {
                                      bool isSelected = colorIdList
                                          .contains(colorData[index].id);
                                      return GestureDetector(
                                        onTap: () {
                                          newState(
                                            () {
                                              if (isSelected) {
                                                colorIdList.remove(
                                                    colorData[index].id);
                                              } else {
                                                colorIdList
                                                    .add(colorData[index].id);
                                              }
                                            },
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: isSelected
                                                          ? black
                                                          : Colors
                                                              .transparent)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      colorData[index].colorHex,
                                                  radius: 14,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            Text(
                                              colorData[index].colorName,
                                              style: themeData()
                                                  .textTheme
                                                  .bodySmall!
                                                  .apply(
                                                      color: isSelected
                                                          ? black
                                                          : textColor),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : const Divider(
                                    color: greyExtraLight,
                                    thickness: 1,
                                  ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.toWidth, 10.toWidth,
                        16.toWidth, ShownyStyle.defaultBottomPadding()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ShownyButton(
                          onPressed: () {
                            newState(() {
                              initFilter();
                            });
                          },
                          option: ShownyButtonOption.fill(
                            text: tr("mini_shop.filter.reset"),
                            theme: ShownyButtonFillTheme.gray,
                            style: ShownyButtonFillStyle.regular,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ShownyButton(
                            onPressed: () {
                              newState(() {
                                FilterShopModel filterShopModel =
                                    FilterShopModel();
                                if (isSelectPriceMode) {
                                  filterShopModel.minPrice =
                                      (rangeValues.start as double).toInt() *
                                          10000;
                                  filterShopModel.maxPrice =
                                      (rangeValues.end as double).toInt() *
                                          10000;
                                }
                                filterShopModel.styleIdList = styleIdList;
                                filterShopModel.fitIdList = fitIdList;
                                filterShopModel.materialIdList = materialIdList;
                                filterShopModel.flexibility =
                                    flexibility.toInt();
                                filterShopModel.colorList = colorIdList;

                                applyFilter(filterShopModel);
                              });

                              Navigator.pop(context);
                            },
                            option: ShownyButtonOption.fill(
                              text: '적용',
                              theme: ShownyButtonFillTheme.violet,
                              style: ShownyButtonFillStyle.fullRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

List<StyleResponseModel> styleData = [
  StyleResponseModel(id: 1, name: "profile_edit.style_screen.dandy"),
  StyleResponseModel(id: 2, name: "profile_edit.style_screen.chic"),
  StyleResponseModel(id: 3, name: "profile_edit.style_screen.classic"),
  StyleResponseModel(id: 4, name: "profile_edit.style_screen.minima_list"),
  StyleResponseModel(id: 5, name: "profile_edit.style_screen.business"),
  StyleResponseModel(id: 6, name: "profile_edit.style_screen.lovely"),
  StyleResponseModel(id: 7, name: "profile_edit.style_screen.sexy"),
  StyleResponseModel(id: 8, name: "profile_edit.style_screen.feminine"),
  StyleResponseModel(id: 9, name: "profile_edit.style_screen.gender_less"),
  StyleResponseModel(id: 10, name: "profile_edit.style_screen.vintage"),
  StyleResponseModel(id: 11, name: "profile_edit.style_screen.retro"),
  StyleResponseModel(id: 12, name: "profile_edit.style_screen.street"),
  StyleResponseModel(id: 13, name: "profile_edit.style_screen.unique"),
  StyleResponseModel(id: 14, name: "profile_edit.style_screen.hip_hop"),
  StyleResponseModel(id: 15, name: "profile_edit.style_screen.punk"),
  StyleResponseModel(id: 16, name: "profile_edit.style_screen.goth"),
  StyleResponseModel(id: 17, name: "profile_edit.style_screen.sporty"),
  StyleResponseModel(id: 18, name: "profile_edit.style_screen.gof_core"),
  StyleResponseModel(id: 19, name: "profile_edit.style_screen.norm_core"),
  StyleResponseModel(id: 20, name: "profile_edit.style_screen.ame_kanji"),
  StyleResponseModel(id: 21, name: "profile_edit.style_screen.preppy"),
  StyleResponseModel(id: 22, name: "profile_edit.style_screen.causal"),
  StyleResponseModel(id: 23, name: "profile_edit.style_screen.city_boy"),
];

List<ColorResponseModel> colorData = [
  ColorResponseModel(
      id: 1,
      colorHex: beigeColor,
      colorName: tr("profile_edit.fav_screen.beige_color")),
  ColorResponseModel(
      id: 2,
      colorHex: khakiColor,
      colorName: tr("profile_edit.fav_screen.khaki_color")),
  ColorResponseModel(
      id: 3,
      colorHex: yellowColor,
      colorName: tr("profile_edit.fav_screen.yellow_color")),
  ColorResponseModel(
      id: 4,
      colorHex: orangeColor,
      colorName: tr("profile_edit.fav_screen.orange_color")),
  ColorResponseModel(
      id: 5,
      colorHex: redColor,
      colorName: tr("profile_edit.fav_screen.red_color")),
  ColorResponseModel(
      id: 6,
      colorHex: wineColor,
      colorName: tr("profile_edit.fav_screen.wine_color")),
  ColorResponseModel(
      id: 7,
      colorHex: brownColor,
      colorName: tr("profile_edit.fav_screen.brown_color")),
  ColorResponseModel(
      id: 8,
      colorHex: navyColor,
      colorName: tr("profile_edit.fav_screen.navy_color")),
  ColorResponseModel(
      id: 9,
      colorHex: blueColor,
      colorName: tr("profile_edit.fav_screen.blue_color")),
  ColorResponseModel(
      id: 10,
      colorHex: greenColor,
      colorName: tr("profile_edit.fav_screen.green_color")),
  ColorResponseModel(
      id: 11,
      colorHex: purpleColor,
      colorName: tr("profile_edit.fav_screen.purple_color")),
  ColorResponseModel(
      id: 12,
      colorHex: greyColor,
      colorName: tr("profile_edit.fav_screen.gray_color")),
  ColorResponseModel(
      id: 13,
      colorHex: black,
      colorName: tr("profile_edit.fav_screen.black_color")),
  ColorResponseModel(
      id: 14,
      colorHex: silverColor,
      colorName: tr("profile_edit.fav_screen.silver_color")),
  ColorResponseModel(
      id: 15,
      colorHex: goldColor,
      colorName: tr("profile_edit.fav_screen.gold_color")),
  ColorResponseModel(
      id: 16,
      colorHex: mintColor,
      colorName: tr("profile_edit.fav_screen.mint_color")),
  ColorResponseModel(
      id: 17,
      colorHex: lavenderColor,
      colorName: tr("profile_edit.fav_screen.lavender_color")),
  ColorResponseModel(
      id: 18,
      colorHex: whiteColor,
      colorName: tr("profile_edit.fav_screen.white_color")),
  ColorResponseModel(
      id: 19,
      colorHex: skyBlueColor,
      colorName: tr("profile_edit.fav_screen.sky_blue_color")),
  ColorResponseModel(
      id: 20,
      colorHex: pinkColor,
      colorName: tr("profile_edit.fav_screen.pink_color")),
];

List<StyleResponseModel> fitData = [
  StyleResponseModel(id: 1, name: tr('store.filter.fit_filters.skinny')),
  StyleResponseModel(id: 2, name: tr('store.filter.fit_filters.slim')),
  StyleResponseModel(id: 3, name: tr('store.filter.fit_filters.regular')),
  StyleResponseModel(id: 4, name: tr('store.filter.fit_filters.rouge')),
  StyleResponseModel(id: 5, name: tr('store.filter.fit_filters.oversize')),
];

List<StyleResponseModel> materialData = [
  StyleResponseModel(id: 1, name: tr('store.filter.material_filters.myeon')),
  StyleResponseModel(
      id: 2, name: tr('store.filter.material_filters.polyester')),
  StyleResponseModel(id: 3, name: tr('store.filter.material_filters.acrylic')),
  StyleResponseModel(id: 4, name: tr('store.filter.material_filters.rayon')),
  StyleResponseModel(id: 5, name: tr('store.filter.material_filters.wool')),
  StyleResponseModel(id: 6, name: tr('store.filter.material_filters.nylon')),
  StyleResponseModel(id: 7, name: tr('store.filter.material_filters.gimo')),
  StyleResponseModel(id: 8, name: tr('store.filter.material_filters.linen')),
  StyleResponseModel(id: 9, name: tr('store.filter.material_filters.spandex')),
  StyleResponseModel(id: 10, name: tr('store.filter.material_filters.tencel')),
  StyleResponseModel(id: 11, name: tr('store.filter.material_filters.knit')),
  StyleResponseModel(
      id: 12, name: tr('store.filter.material_filters.polyurethane')),
  StyleResponseModel(id: 13, name: tr('store.filter.material_filters.modal')),
  StyleResponseModel(id: 14, name: tr('store.filter.material_filters.viscose')),
  StyleResponseModel(
      id: 15, name: tr('store.filter.material_filters.cashmere')),
];

class _StorePriceRangeSlider extends StatefulWidget {
  final SfRangeValues rangeValues;
  final Function(SfRangeValues newValues)? onChanged;
  const _StorePriceRangeSlider({
    Key? key,
    required this.rangeValues,
    this.onChanged,
  }) : super(key: key);

  @override
  State<_StorePriceRangeSlider> createState() => __StorePriceRangeSliderState();
}

class __StorePriceRangeSliderState extends State<_StorePriceRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.onChanged == null
              ? '전체'
              : '${widget.rangeValues.start.round()}만원 ~ ${widget.rangeValues.end.round()}만원',
          style: ShownyStyle.caption(
            color: widget.onChanged == null
                ? const Color(0xff777777)
                : ShownyStyle.mainPurple,
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
            labelFormatterCallback:
                (dynamic actualValue, String formattedText) {
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
