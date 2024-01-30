import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/refresher/showny_refresher.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/screens/shop/store/providers/store_tab_home_provider.dart';
import 'package:showny/screens/shop/store/widgets/tab_store_category.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../utils/showny_style.dart';
import 'bannerSlider_widget.dart';
import 'newest_store_product_list.dart';
import 'store_home_products_widget.dart';

class TabStoreHome extends StatefulWidget {
  const TabStoreHome({super.key});

  @override
  State<TabStoreHome> createState() => _TabStoreHomeState();
}

class _TabStoreHomeState extends State<TabStoreHome> {
  // GenderType selectGender = GenderType.female;

  late StoreTabHomeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = StoreTabHomeProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreTabHomeProvider>.value(
      value: provider,
      builder: (context, _) {
        return ShownyRefresher(
          onRefresh: () async {
            ShownyLog().e('refresh!!');
          },
          builder: (context, Widget refresher) {
            return CustomScrollView(
              slivers: [
                refresher,
                SliverTween(
                  child: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.toWidth),
                        _buildGenderTab(),
                        SizedBox(height: 10.toWidth),
                        const BannerSliderWidget(index: 1),
                        SizedBox(height: 30.toWidth),
                        NewestStoreProductList(),
                        SizedBox(height: 30.toWidth),
                        const StoreHomeProductsWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildGenderTab() {
    return Consumer<StoreTabHomeProvider>(
      builder: (context, prov, child) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 30.toWidth, vertical: 4.toWidth),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: BaseButton(
                    onPressed: () {
                      if (prov.isMale) {
                        prov.setSelectGender(GenderType.female);
                        prov.getNewestProductList();
                      }
                    },
                    child: Text(
                      'WOMAN',
                      style: ShownyStyle.caption(
                        color: prov.isFemale
                            ? ShownyStyle.black
                            : Color(0xffdbdbdb),
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 10,
                color: Colors.black,
                margin: EdgeInsets.symmetric(horizontal: 8.toWidth),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: BaseButton(
                    onPressed: () {
                      if (prov.isFemale) {
                        prov.setSelectGender(GenderType.male);
                        prov.getNewestProductList();
                      }
                    },
                    child: Text(
                      'MAN',
                      style: ShownyStyle.caption(
                        color:
                            prov.isMale ? ShownyStyle.black : Color(0xffdbdbdb),
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
