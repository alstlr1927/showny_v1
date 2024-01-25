import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/screens/shop/store/models/color_model.dart';
import 'package:showny/screens/shop/store/models/style_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_button_widget.dart';
import 'package:showny/widgets/common_textfield_widget.dart';
import 'package:showny/widgets/custom_slider_widget.dart';

import '../providers/store_detail_filter_provider.dart';

void showFilterBottomSheet1(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  StoreDetailFilterProvider storeDetailFilterProvider =
      context.read<StoreDetailFilterProvider>();
  storeDetailFilterProvider =
      Provider.of<StoreDetailFilterProvider>(context, listen: false);
  TextEditingController minPriceController = TextEditingController(
      text: storeDetailFilterProvider.getMinPrice()?.toString() ?? '');
  TextEditingController maxPriceController = TextEditingController(
      text: storeDetailFilterProvider.getMaxPrice()?.toString() ?? '');
  List<int> styleIdList = storeDetailFilterProvider.getStyleIdList();
  List<int> fitIdList = storeDetailFilterProvider.getFitIdList();
  List<int> materialIdList = storeDetailFilterProvider.getMaterialIdList();
  List<int> colorIdList = storeDetailFilterProvider.getColorIdList();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return StatefulBuilder(
        builder: (context, newState) => FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Center(
                          child: Text(
                        tr('store.filter.title'),
                        style: themeData().textTheme.titleMedium,
                      )),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    tr('store.filter.options.price'),
                    style: themeData()
                        .textTheme
                        .titleMedium!
                        .copyWith(color: grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextFieldWidget2(
                          borderRadius: 10,
                          borderColor: black,
                          hintText: "0원",
                          hintStyle: themeData()
                              .textTheme
                              .bodySmall!
                              .copyWith(color: textColor),
                          textEditingController: minPriceController,
                          textInputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CommonTextFieldWidget2(
                          borderRadius: 10,
                          borderColor: black,
                          hintText: "1,000,000원",
                          hintStyle: themeData()
                              .textTheme
                              .bodySmall!
                              .copyWith(color: textColor),
                          textEditingController: maxPriceController,
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    tr('store.filter.options.style'),
                    style: themeData()
                        .textTheme
                        .titleMedium!
                        .copyWith(color: grey),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: styleData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, childAspectRatio: 1.8),
                    itemBuilder: (context, index) {
                      bool isSelected =
                          styleIdList.contains(styleData[index].id);
                      return GestureDetector(
                        onTap: () {
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
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: isSelected ? black : greyExtraLight,
                              ),
                            ),
                            child: Center(
                                child: Text(
                              tr(styleData[index].name),
                              style: themeData()
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: isSelected ? black : textColor),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Provider.of<StoreDetailFilterProvider>(context,
                              listen: false)
                          .toggleFit();
                    },
                    child: Container(
                      color: white,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr("store.filter.options.fit"),
                            style: themeData()
                                .textTheme
                                .titleMedium!
                                .copyWith(color: grey),
                          ),
                          Consumer<StoreDetailFilterProvider>(
                            builder:
                                (context, storeDetailFilterProvider, child) =>
                                    storeDetailFilterProvider.showFit
                                        ? Image.asset(
                                            arrowDown,
                                            color: greyLight,
                                            height: 20,
                                            width: 20,
                                          )
                                        : Image.asset(
                                            arrowDownIcon,
                                            color: greyLight,
                                            height: 20,
                                            width: 20,
                                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<StoreDetailFilterProvider>(
                    builder: (context, storeDetailFilterProvider, child) =>
                        storeDetailFilterProvider.showFit == true
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: fitData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1.8),
                                itemBuilder: (context, index) {
                                  bool isSelected =
                                      fitIdList.contains(fitData[index].id);
                                  return GestureDetector(
                                    onTap: () {
                                      newState(
                                        () {
                                          if (isSelected) {
                                            fitIdList.remove(fitData[index].id);
                                          } else {
                                            fitIdList.add(fitData[index].id);
                                          }
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            border: Border.all(
                                              color: isSelected
                                                  ? black
                                                  : greyExtraLight,
                                            )),
                                        child: Center(
                                          child: Text(
                                            tr(fitData[index].name),
                                            style: themeData()
                                                .textTheme
                                                .bodySmall!
                                                .apply(
                                                    color: isSelected
                                                        ? black
                                                        : textColor),
                                          ),
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
                      Provider.of<StoreDetailFilterProvider>(context,
                              listen: false)
                          .toggleMaterial();
                    },
                    child: Container(
                      color: white,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr("store.filter.options.main_material"),
                            style: themeData()
                                .textTheme
                                .titleMedium!
                                .copyWith(color: grey),
                          ),
                          Consumer<StoreDetailFilterProvider>(
                            builder:
                                (context, storeDetailFilterProvider, child) =>
                                    storeDetailFilterProvider.showMainMaterial
                                        ? Image.asset(
                                            arrowDown,
                                            color: greyLight,
                                            height: 20,
                                            width: 20,
                                          )
                                        : Image.asset(
                                            arrowDownIcon,
                                            color: greyLight,
                                            height: 20,
                                            width: 20,
                                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<StoreDetailFilterProvider>(
                    builder: (context, storeDetailFilterProvider, child) =>
                        storeDetailFilterProvider.showMainMaterial == true
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: materialData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1.8),
                                itemBuilder: (context, index) {
                                  bool isSelected = materialIdList
                                      .contains(materialData[index].id);
                                  return GestureDetector(
                                    onTap: () {
                                      newState(
                                        () {
                                          if (isSelected) {
                                            materialIdList
                                                .remove(materialData[index].id);
                                          } else {
                                            materialIdList
                                                .add(materialData[index].id);
                                          }
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            border: Border.all(
                                              color: isSelected
                                                  ? black
                                                  : greyExtraLight,
                                            )),
                                        child: Center(
                                            child: Text(
                                          tr(materialData[index].name),
                                          style: themeData()
                                              .textTheme
                                              .bodySmall!
                                              .apply(
                                                  color: isSelected
                                                      ? black
                                                      : textColor),
                                        )),
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
                      Provider.of<StoreDetailFilterProvider>(context,
                              listen: false)
                          .toggleRange();
                    },
                    child: Container(
                      color: white,
                      width: size.width,
                      child: Consumer<StoreDetailFilterProvider>(
                        builder: (context, storeDetailFilterProvider, child) =>
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr("store.filter.options.flexibility"),
                              style: themeData()
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: grey),
                            ),
                            storeDetailFilterProvider.showRange &&
                                    storeDetailFilterProvider
                                            .sliderRangeValue ==
                                        1
                                ? Text(
                                    tr("store.filter.options.almost_none"),
                                    style: themeData().textTheme.titleMedium,
                                  )
                                : storeDetailFilterProvider.showRange &&
                                        storeDetailFilterProvider
                                                .sliderRangeValue ==
                                            2
                                    ? Text(
                                        tr("store.filter.options.slightly_none"),
                                        style:
                                            themeData().textTheme.titleMedium,
                                      )
                                    : storeDetailFilterProvider.showRange &&
                                            storeDetailFilterProvider
                                                    .sliderRangeValue ==
                                                3
                                        ? Text(
                                            tr("store.filter.options.commonly"),
                                            style: themeData()
                                                .textTheme
                                                .titleMedium,
                                          )
                                        : storeDetailFilterProvider.showRange &&
                                                storeDetailFilterProvider
                                                        .sliderRangeValue ==
                                                    4
                                            ? Text(
                                                tr("store.filter.options.little_bit"),
                                                style: themeData()
                                                    .textTheme
                                                    .titleMedium,
                                              )
                                            : storeDetailFilterProvider
                                                        .showRange &&
                                                    storeDetailFilterProvider
                                                            .sliderRangeValue ==
                                                        5
                                                ? Text(
                                                    tr("store.filter.options.very_present"),
                                                    style: themeData()
                                                        .textTheme
                                                        .titleMedium,
                                                  )
                                                : const SizedBox.shrink(),
                            storeDetailFilterProvider.showRange
                                ? Image.asset(
                                    arrowDown,
                                    color: greyLight,
                                    height: 20,
                                    width: 20,
                                  )
                                : Image.asset(
                                    arrowDownIcon,
                                    color: greyLight,
                                    height: 20,
                                    width: 20,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<StoreDetailFilterProvider>(
                    builder: (context, storeDetailFilterProvider, child) =>
                        storeDetailFilterProvider.showRange
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CustomSlider(
                                    value: storeDetailFilterProvider
                                        .sliderRangeValue,
                                    onChanged: (value) {
                                      storeDetailFilterProvider
                                          .setSliderRangeValue(value);
                                      log("Rangevalue :: ${storeDetailFilterProvider.sliderRangeValue}");
                                    }),
                                // SliderTheme(
                                //   data: SliderTheme.of(context).copyWith(
                                //     trackHeight: 6.0,
                                //     trackShape: const RoundedRectSliderTrackShape(),
                                //     activeTrackColor: black,
                                //     inactiveTrackColor: black,
                                //     thumbShape: const RoundSliderThumbShape(
                                //       enabledThumbRadius: 14.0,
                                //       pressedElevation: 8.0,
                                //     ),
                                //     thumbColor: white,
                                //     overlayColor: black,
                                //     overlayShape: const RoundSliderOverlayShape(overlayRadius:32),
                                //     tickMarkShape: const RoundSliderTickMarkShape(),
                                //     activeTickMarkColor: black,
                                //     inactiveTickMarkColor:black,
                                //     valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                                //     valueIndicatorColor: black,
                                //     valueIndicatorTextStyle: const TextStyle(
                                //       color: black,
                                //       fontSize: 20.0,
                                //     ),
                                //   ),
                                //   child: Slider(
                                //     min: 0.8,
                                //     max: 1.8,
                                //     value: provider.sliderRangeValue,
                                //     divisions: 5,
                                //     onChanged: (value) {
                                //       provider.setSliderRangeValue(value);
                                //       log("Rangevalue :: ${provider.sliderRangeValue}");
                                //     },
                                //   ),
                                // ),
                                // SfSliderTheme(
                                //   data: SfSliderThemeData(
                                //     activeTrackHeight: 5,
                                //     thumbRadius: 10,
                                //     inactiveTrackHeight: 5,
                                //     activeDividerRadius: 5,
                                //     activeDividerStrokeWidth: 5,
                                //     inactiveDividerRadius: 5,
                                //     overlayColor: Colors.transparent,
                                //     thumbColor: const Color(0xff0aff6c),
                                //     activeDividerColor: Colors.grey,
                                //     activeTrackColor: Colors.grey,
                                //     overlayRadius: 100,
                                //   ),
                                //   child: SfSlider(
                                //     min: 0.0,
                                //     max: 4.0,
                                //     interval: 1,
                                //     showDividers: true,
                                //     value:  provider.sliderRangeValue,
                                //     stepSize: 1,
                                //     onChanged: (newValue) {
                                //       provider.setSliderRangeValue(newValue);
                                //     },
                                //   ),
                                // ),
                                //     Slider(
                                //   min: 0.8,
                                //   max: 1.8,
                                //   activeColor: black,
                                //   inactiveColor: black,
                                //   thumbColor: white,
                                //   value: provider.sliderRangeValue,
                                //   divisions: 5,
                                //   onChanged: (value) {
                                //     provider.setSliderRangeValue(value);
                                //     log("Rangevalue :: ${provider.sliderRangeValue}");
                                //   },
                                // ),
                              )
                            : const Divider(
                                color: greyExtraLight,
                                thickness: 1,
                              ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Provider.of<StoreDetailFilterProvider>(context,
                              listen: false)
                          .toggleColor();
                    },
                    child: Container(
                      color: white,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr("store.filter.options.color"),
                            style: themeData().textTheme.titleMedium!.copyWith(
                                  color: grey,
                                ),
                          ),
                          Consumer<StoreDetailFilterProvider>(
                            builder:
                                (context, storeDetailFilterProvider, child) =>
                                    storeDetailFilterProvider.showColor
                                        ? Image.asset(
                                            arrowDown,
                                            color: greyLight,
                                            height: 20,
                                            width: 20,
                                          )
                                        : Image.asset(
                                            arrowDownIcon,
                                            color: greyLight,
                                            height: 20,
                                            width: 20,
                                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<StoreDetailFilterProvider>(
                    builder: (context, storeDetailFilterProvider, child) =>
                        storeDetailFilterProvider.showColor == true
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: colorData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1.2),
                                itemBuilder: (context, index) {
                                  bool isSelected =
                                      colorIdList.contains(colorData[index].id);
                                  return GestureDetector(
                                    onTap: () {
                                      newState(
                                        () {
                                          if (isSelected) {
                                            colorIdList
                                                .remove(colorData[index].id);
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
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: isSelected
                                                      ? black
                                                      : Colors.transparent)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
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
                  Row(
                    children: [
                      Expanded(
                        child: CommonButtonWidget(
                          onTap: () {
                            // minPriceController.clear();
                            // maxPriceController.clear();
                            // Provider.of<BottomSheetProvider>(context,
                            //         listen: false)
                            //     .resetSelections();
                            // Provider.of<FavColorProvider>(context,
                            //         listen: false)
                            //     .resetSelections();
                            newState(() {
                              storeDetailFilterProvider.resetFilter();
                              Navigator.pop(context);
                              showFilterBottomSheet1(context);
                            });
                          },
                          text: tr("mini_shop.filter.reset"),
                          radius: 10,
                          height: size.height * 0.055,
                          width: size.width * 0.35,
                          color: greyExtraLight,
                          textcolor: grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CommonButtonWidget(
                          text: tr("mini_shop.filter.apply"),
                          radius: 10,
                          width: size.width * 0.54,
                          height: size.height * 0.055,
                          color: black,
                          textcolor: white,
                          onTap: () {
                            if (minPriceController.text.trim().isNotEmpty) {
                              storeDetailFilterProvider.setMinPrice(
                                  int.parse(minPriceController.text.trim()));
                            }
                            if (maxPriceController.text.trim().isNotEmpty) {
                              storeDetailFilterProvider.setMaxPrice(
                                  int.parse(maxPriceController.text.trim()));
                            }
                            if (styleIdList.isNotEmpty) {
                              storeDetailFilterProvider
                                  .setStyleIdList(styleIdList);
                            }
                            if (fitIdList.isNotEmpty) {
                              storeDetailFilterProvider.setFitIdList(fitIdList);
                            }
                            if (materialIdList.isNotEmpty) {
                              storeDetailFilterProvider
                                  .setMaterialIdList(materialIdList);
                            }
                            // if (storeDetailFilterProvider.sliderRangeValue > 0) {
                            //   storeDetailFilterProvider.setSliderRangeValue(
                            //       storeDetailFilterProvider.sliderRangeValue);
                            // }
                            if (colorIdList.isNotEmpty) {
                              storeDetailFilterProvider
                                  .setColorIdList(colorIdList);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
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
