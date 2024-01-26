import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/models/filter_shop_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';

import '../providers/store_search_provider.dart';
import 'filter_store_bottom_sheet.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
      child: GestureDetector(
        onTap: () {
          showStoreFilterBottomSheet(context, widget.filterShopModel,
              widget.resetFilter, widget.applyFilter);
        },
        child: Consumer<StoreSearchProvider>(
            builder: (BuildContext context, provider, Widget? child) {
          return Row(
            children: [
              Image.asset(
                filter,
                height: 18.toWidth,
                width: 18.toWidth,
              ),
              SizedBox(width: 12.toWidth),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _filterItem(
                          title: tr('store.filter.options.price'),
                          isFocus: widget.filterShopModel.minPrice != null ||
                              widget.filterShopModel.maxPrice != null),
                      SizedBox(width: 8.toWidth),
                      _filterItem(
                          title: tr('store.filter.options.style'),
                          isFocus:
                              widget.filterShopModel.styleIdList.isNotEmpty),
                      SizedBox(width: 8.toWidth),
                      _filterItem(
                          title: tr('store.filter.options.fit'),
                          isFocus: widget.filterShopModel.fitIdList.isNotEmpty),
                      SizedBox(width: 8.toWidth),
                      _filterItem(
                          title: tr('store.filter.options.main_material'),
                          isFocus:
                              widget.filterShopModel.materialIdList.isNotEmpty),
                      SizedBox(width: 8.toWidth),
                      _filterItem(
                          title: tr('store.filter.options.flexibility'),
                          isFocus: widget.filterShopModel.flexibility == 0),
                      SizedBox(width: 8.toWidth),
                      _filterItem(
                          title: tr('store.filter.options.color'),
                          isFocus: widget.filterShopModel.colorList.isNotEmpty),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _filterItem({required String title, required bool isFocus}) {
    return Container(
      width: 64.toWidth,
      height: 24.toWidth,
      decoration: BoxDecoration(
        color: isFocus ? ShownyStyle.mainPurple : ShownyStyle.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isFocus ? ShownyStyle.mainPurple : greyLight.withOpacity(.3),
          width: 1,
        ),
      ),
      child: Center(
          child: Text(
        title,
        style: ShownyStyle.caption(
            color: isFocus ? ShownyStyle.white : Color(0xff777777)),
      )),
    );
  }
}
