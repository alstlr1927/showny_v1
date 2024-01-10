import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/screens/shop/store/providers/store_detail_filter_provider.dart';
import 'package:showny/screens/shop/widgets/filter_bottomsheet1.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/theme.dart';

class SearchFilterWidget extends StatefulWidget {
  final Color? iconColor;

  const SearchFilterWidget({
    Key? key,
    this.iconColor,
  }) : super(key: key);

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
          showFilterBottomSheet1(context);
        },
        child: Consumer<StoreDetailFilterProvider>(
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
                    color: provider.getMinPrice() != null ||
                            provider.getMaxPrice() != null
                        ? black
                        : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: provider.getMinPrice() != null ||
                              provider.getMaxPrice() != null
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.price'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: provider.getMinPrice() != null ||
                                provider.getMaxPrice() != null
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
                    color: provider.getStyleIdList().isNotEmpty ? black : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: provider.getStyleIdList().isNotEmpty
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.style'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: provider.getStyleIdList().isNotEmpty
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
                    color: provider.getFitIdList().isNotEmpty ? black : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: provider.getFitIdList().isNotEmpty
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.fit'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: provider.getFitIdList().isNotEmpty
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
                    color:
                        provider.getMaterialIdList().isNotEmpty ? black : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: provider.getMaterialIdList().isNotEmpty
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    tr('store.filter.options.main_material'),
                    style: themeData().textTheme.bodySmall?.apply(
                        color: provider.getMaterialIdList().isNotEmpty
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
                    color: provider.showRange == true ? black : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: provider.showRange == true
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('store.filter.options.flexibility'),
                      style: themeData().textTheme.bodySmall?.apply(
                          color:
                              provider.showRange == true ? white : greyLight),
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
                    color: provider.getColorIdList().isNotEmpty ? black : white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: provider.getColorIdList().isNotEmpty
                          ? black
                          : greyLight.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('store.filter.options.color'),
                      style: themeData().textTheme.bodySmall?.apply(
                          color: provider.getColorIdList().isNotEmpty
                              ? white
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
