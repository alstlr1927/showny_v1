import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/models/filter_shop_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/theme.dart';

import '../providers/store_search_provider.dart';

class SearchFilterWidget extends StatefulWidget {
  final Color? iconColor;
  final FilterShopModel filterShopModel;

  final Function() resetFilter;
  final Function(FilterShopModel) applyFilter;

  const SearchFilterWidget(
      {Key? key,
      this.iconColor,
      required this.filterShopModel,
      required this.resetFilter,
      required this.applyFilter})
      : super(key: key);

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          showStoreFilterBottomSheet(context, widget.filterShopModel,
              widget.resetFilter, widget.applyFilter);
        },
        child: Consumer<StoreSearchProvider>(
            builder: (BuildContext context, provider, Widget? child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(filter, height: 20, width: 20),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 64,
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.filterShopModel.minPrice != null ||
                            widget.filterShopModel.maxPrice != null
                        ? black
                        : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.filterShopModel.minPrice != null ||
                              widget.filterShopModel.maxPrice != null
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.price'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: widget.filterShopModel.minPrice != null ||
                                widget.filterShopModel.maxPrice != null
                            ? white
                            : greyLight),
                  )),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Container(
                  width: 64,
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.filterShopModel.styleIdList != null
                        ? widget.filterShopModel.styleIdList!.isNotEmpty
                            ? black
                            : white
                        : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.filterShopModel.styleIdList != null
                          ? widget.filterShopModel.styleIdList!.isNotEmpty
                              ? black
                              : greyLight.withOpacity(0.3)
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.style'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: widget.filterShopModel.styleIdList != null
                            ? widget.filterShopModel.styleIdList!.isNotEmpty
                                ? white
                                : greyLight
                            : greyLight),
                  )),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Container(
                  width: 64,
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.filterShopModel.fitIdList != null
                        ? widget.filterShopModel.fitIdList!.isNotEmpty
                            ? black
                            : white
                        : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.filterShopModel.fitIdList != null
                          ? widget.filterShopModel.fitIdList!.isNotEmpty
                              ? black
                              : greyLight.withOpacity(0.3)
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.fit'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: widget.filterShopModel.fitIdList != null
                            ? widget.filterShopModel.fitIdList!.isNotEmpty
                                ? white
                                : greyLight
                            : greyLight),
                  )),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Container(
                  width: 64,
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.filterShopModel.materialIdList != null
                        ? widget.filterShopModel.materialIdList!.isNotEmpty
                            ? black
                            : white
                        : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.filterShopModel.materialIdList != null
                          ? widget.filterShopModel.materialIdList!.isNotEmpty
                              ? black
                              : greyLight.withOpacity(0.3)
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.main_material'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: widget.filterShopModel.materialIdList != null
                            ? widget.filterShopModel.materialIdList!.isNotEmpty
                                ? white
                                : greyLight
                            : greyLight),
                  )),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Container(
                  width: 64,
                  height: 24,
                  decoration: BoxDecoration(
                    color:
                        widget.filterShopModel.flexibility == 0 ? black : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.filterShopModel.flexibility == 0
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('store.filter.options.flexibility'),
                      style: themeData().textTheme.bodySmall?.apply(
                          color: widget.filterShopModel.flexibility == 0
                              ? white
                              : greyLight),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Container(
                  width: 64,
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.filterShopModel.colorList != null
                        ? widget.filterShopModel.colorList!.isNotEmpty
                            ? black
                            : white
                        : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.filterShopModel.colorList != null
                          ? widget.filterShopModel.colorList!.isNotEmpty
                              ? black
                              : greyLight.withOpacity(0.3)
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('store.filter.options.color'),
                      style: themeData().textTheme.bodySmall?.apply(
                          color: widget.filterShopModel.colorList != null
                              ? widget.filterShopModel.colorList!.isNotEmpty
                                  ? white
                                  : greyLight
                              : greyLight),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
