import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../components/page_route.dart';
import '../../../../utils/showny_style.dart';
import '../store_goods_list_screen.dart';
import 'bannerSlider_widget.dart';
import 'store_home_products_widget.dart';

class TabStoreHome extends StatefulWidget {
  const TabStoreHome({super.key});

  @override
  State<TabStoreHome> createState() => _TabStoreHomeState();
}

class _TabStoreHomeState extends State<TabStoreHome> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverTween(
          child: SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20.toWidth),
                _buildGenderTab(),
                SizedBox(height: 20.toWidth),
                const BannerSliderWidget(index: 1),
                SizedBox(height: 30.toWidth),
                const StoreHomeProductsWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
      child: Row(
        children: [
          BaseButton(
            onPressed: () {
              Navigator.push(
                  context,
                  ShownyPageRoute(
                    builder: (context) => const StoreGoodsListScreen(
                      mainCategory: 1,
                      subCategory: 0,
                    ),
                  ));
            },
            child: Text(
              'WOMAN',
              style: ShownyStyle.body2(weight: FontWeight.w500),
            ),
          ),
          SizedBox(width: 16.toWidth),
          BaseButton(
            onPressed: () {
              Navigator.push(
                  context,
                  ShownyPageRoute(
                    builder: (context) => const StoreGoodsListScreen(
                      mainCategory: 0,
                      subCategory: 0,
                    ),
                  ));
            },
            child: Text(
              'MAN',
              style: ShownyStyle.body2(weight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
