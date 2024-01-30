import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/main.dart';
import 'package:showny/models/filter_minishop_model.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../store/widgets/bannerSlider_widget.dart';
import '../store/widgets/event_tab_refresh.dart';
import 'providers/mini_shop_products_provider.dart';
import 'widgets/grid_product_widget.dart';
import 'widgets/mini_shop_category_list_widget.dart';
import 'widgets/search_filter_minishop.dart';

class MiniShopScreen extends StatefulWidget {
  const MiniShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniShopScreen> createState() => _MiniShopScreenState();
}

class _MiniShopScreenState extends State<MiniShopScreen> {
  ScrollController scrollController = ScrollController();
  FilterMinishopModel filterMinishopModel = FilterMinishopModel();
  int categoryIndex = 0;

  refreshItems() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Provider.of<MiniShopProductsProvider>(context, listen: false).getMiniShopProductList(user.memNo, "", null);
    Provider.of<MiniShopProductsProvider>(context, listen: false).getRecentViewMinishopProductList(user.memNo);
  }

  @override
  void initState() {
    super.initState();
    refreshItems();
    eventBus.on<EventTabRefresh>().listen((event) {
      if (event.index == 2) {
        setState(() {
          scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
          refreshItems();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 24),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: SizedBox(
          //     width: size.width,
          //     child: Center(
          //       child: Text(
          //         tr('mini_shop.tabs.mini_shop'),
          //         style: themeData().textTheme.titleMedium,
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: SizedBox(
          //     height: 40,
          //     child: Center(
          //       child: Text(
          //         tr('mini_shop.tabs.mini_shop_description'),
          //         textAlign: TextAlign.center,
          //         style: themeData().textTheme.labelSmall!.copyWith(color: greyLight),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 24),
          const SizedBox(height: 38),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: SizedBox(
                    width: 19.toWidth,
                  ),
                ),
                TextSpan(
                  text: 'MiNi ',
                  style: ShownyStyle.h3(
                    weight: FontWeight.w700,
                    color: Color(0xFF343434),
                  ),
                ),
                TextSpan(
                  text: 'SHOP',
                  style: ShownyStyle.h3(
                    weight: FontWeight.w100,
                    color: Color(0xFF343434),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 19.toWidth),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '인플루언서들의 개인샵\n빈티지 & 중고 등의 아이템을 구매하고 싶다면',
                style: ShownyStyle.overline(
                  color: Color(0xFF343434),
                ),
              ),
            ),
          ),
          const SizedBox(height: 38),
          const BannerSliderWidget(index: 0),
          // const SizedBox(
          //   height: 16,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          //     GestureDetector(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Image.asset(
          //             search,
          //             height: 24,
          //             width: 24,
          //           )
          //         ],
          //       ),
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             ShownyPageRoute(
          //               builder: (context) => const MinishopSearchScreen(),
          //             ));
          //       },
          //     ),
          //   ]),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          MiniShopCategoryListWidget(
            onSelectCategory: (selectCategoryIndex) {
              setState(() {
                filterMinishopModel.categoryId = selectCategoryIndex;
                //       categoryIndex = selectCategoryIndex;
                Provider.of<MiniShopProductsProvider>(context, listen: false).initPage();
                Provider.of<MiniShopProductsProvider>(context, listen: false).getMiniShopProductList(user.memNo, "", filterMinishopModel);
              });
            },
            initCategory: categoryIndex,
          ),
          const Divider(
            height: 1,
            color: greyExtraLight,
          ),
          const SizedBox(
            height: 16,
          ),
          SearchFilterWidgetMinishop(
            filterMinishopModel: filterMinishopModel,
            resetFilter: () {
              setState(() {
                filterMinishopModel.initFilter();
                var provider = Provider.of<MiniShopProductsProvider>(context, listen: false);
                provider.initPage();
                provider.getMiniShopProductList(user.memNo, "", filterMinishopModel);
              });
            },
            applyFilter: (newFilterShopModel) {
              setState(() {
                filterMinishopModel = newFilterShopModel;
                var provider = Provider.of<MiniShopProductsProvider>(context, listen: false);
                provider.initPage();
                provider.getMiniShopProductList(user.memNo, "", filterMinishopModel);
              });
            },
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 8,
            thickness: 8,
            color: divider,
          ),

          // 체크박스(다른 스크린으로 이동?)
          // const SizedBox(
          //   height: 16,
          // ),
          // CheckBoxWidget(
          //   isWearCheck: filterMinishopModel.isWear,
          //   isTansaction: filterMinishopModel.isTransaction,
          //   checkWear: (isWear) {
          //     setState(() {
          //       filterMinishopModel.isWear = isWear;
          //       // var minishopProductsProvider = Provider.of<MiniShopProductsProvider>(context, listen: false);
          //       // minishopProductsProvider.initPage();
          //       // minishopProductsProvider.getMiniShopProductList(user.memNo, "", filterMinishopModel);
          //     });
          //   },
          //   checkTransaction: (isTransaction) {
          //     setState(() {
          //       filterMinishopModel.isTransaction = isTransaction;
          //       var minishopProductsProvider = Provider.of<MiniShopProductsProvider>(context, listen: false);
          //       minishopProductsProvider.initPage();
          //       minishopProductsProvider.getMiniShopProductList(user.memNo, "", filterMinishopModel);
          //     });
          //   },
          //   sort: filterMinishopModel.sort,
          //   changeSort: (sortIndex) {
          //     setState(() {
          //       filterMinishopModel.sort = sortIndex;
          //       var minishopProductsProvider = Provider.of<MiniShopProductsProvider>(context, listen: false);
          //       minishopProductsProvider.initPage();
          //       minishopProductsProvider.getMiniShopProductList(user.memNo, "", filterMinishopModel);
          //     });
          //   },
          // ),
          // const SizedBox(
          //   height: 40,
          // ),
          // 최근 본 상품(다른 스크린으로 이동?)
          // RecentProductWidget(
          //   filterMinishopModel: filterMinishopModel,
          // ),
          GridProductWidget(
            filterMinishopModel: filterMinishopModel,
          ),
        ],
      ),
    );
  }
}
