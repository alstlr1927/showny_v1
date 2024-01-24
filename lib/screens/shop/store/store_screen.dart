import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/shop/store/widgets/tab_store_home.dart';
import 'package:showny/screens/shop/store/widgets/tab_store_ranking.dart';
import 'package:showny/screens/shop/store/widgets/tab_store_wishlist.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';

import 'providers/store_provider.dart';
import 'providers/store_wishlist_provider.dart';
import 'store_goods_list_screen.dart';
import 'widgets/bannerSlider_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      refreshItemsMainPage();
    });
    super.initState();
    // eventBus.on<EventTabRefresh>().listen((event) {
    //   ShownyLog().e('eventbus : $event');
    //   if (event.index == 2) {
    //     setState(() {
    //       refreshItemsMainPage();
    //     });
    //   }
    // });
  }

  refreshItemsMainPage() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Provider.of<StoreProvider>(context, listen: false)
        .getStoreMainPageDataApi(user.memNo);
    Provider.of<StoreProvider>(context, listen: false)
        .getBattleInProductList(user.memNo);
    Provider.of<StoreWishListProvider>(context, listen: false)
        .getGoodsHeart(user.memNo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.toWidth),
        _buildStoreTab(),
        SizedBox(height: 10.toWidth),
        Expanded(
          child: Consumer<StoreProvider>(
            builder: (context, prov, child) {
              if (prov.indexTab == 0) {
                return TabStoreHome();
              } else if (prov.indexTab == 1) {
                return Container(
                  color: Colors.amber,
                );
              } else if (prov.indexTab == 2) {
                return TabStoreRanking();
              } else {
                return TabStoreWishList();
              }
              // return IndexedStack(
              //   index: prov.indexTab,
              //   children: [
              //     TabStoreHome(),
              //     Container(
              //       color: Colors.green,
              //     ),
              //     Container(
              //       color: Colors.red,
              //     ),
              //     Container(
              //       color: Colors.blue,
              //     ),
              //   ],
              // );
            },
          ),
        ),
      ],
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.toWidth),
          _buildStoreTab(),
          SizedBox(height: 20.toWidth),
          _buildGenderTab(),
          SizedBox(height: 24.toWidth),
          const BannerSliderWidget(index: 1),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Consumer<StoreProvider>(
                    builder: (context, provider, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // var provider =
                              //     Provider.of<StoreDetailFilterProvider>(
                              //         context,
                              //         listen: false);
                              // provider
                              //   ..setSelectedTabFilter(StoreSelectionTab.women)
                              //   ..setSelectedCategory(index + 1)
                              //   ..setSelectedBrand(null);
                              Navigator.push(
                                  context,
                                  ShownyPageRoute(
                                    builder: (context) => StoreGoodsListScreen(
                                      mainCategory: 1,
                                      subCategory: index + 1,
                                    ),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: index == 5 ? white : greyExtraLight,
                              ))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, top: 16, bottom: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      provider.categories[index],
                                      style: themeData().textTheme.bodySmall,
                                    ),
                                    const Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: provider.categories.length,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Consumer<StoreProvider>(
                    builder: (context, provider, child) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                ShownyPageRoute(
                                  builder: (context) => StoreGoodsListScreen(
                                    mainCategory: 0,
                                    subCategory: index + 1,
                                  ),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: index == 5 ? white : greyExtraLight,
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, top: 16, bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    provider.categories[index],
                                    style: themeData().textTheme.bodySmall,
                                  ),
                                  const Icon(
                                    Icons.add,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Provider.of<StoreProvider>(context, listen: false).indexTab == 0
          //     ? const StoreHomeProductsWidget()
          //     : Provider.of<StoreProvider>(context, listen: false).indexTab == 1
          //         ? const RankingWidget()
          //         : const WishListComponent(),
        ],
      ),
    );
  }

  Widget _buildStoreTab() {
    return Consumer<StoreProvider>(builder: (context, prov, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
        child: Row(
          children: [
            BaseButton(
                onPressed: () {
                  prov.updateIndex(0);
                },
                child: _storeTabText(
                    title: tr("store.tabs.home"),
                    isSelect: prov.indexTab == 0)),
            SizedBox(width: 20.toWidth),
            BaseButton(
                onPressed: () {
                  prov.updateIndex(1);
                },
                child:
                    _storeTabText(title: '카테고리', isSelect: prov.indexTab == 1)),
            SizedBox(width: 20.toWidth),
            BaseButton(
                onPressed: () {
                  prov.updateIndex(2);
                },
                child: _storeTabText(
                    title: tr('store.tabs.ranking'),
                    isSelect: prov.indexTab == 2)),
            SizedBox(width: 20.toWidth),
            BaseButton(
                onPressed: () {
                  prov.updateIndex(3);
                },
                child: _storeTabText(
                    title: tr('store.tabs.steamed'),
                    isSelect: prov.indexTab == 3)),
          ],
        ),
      );
    });
  }

  Widget _storeTabText({
    required String title,
    required bool isSelect,
  }) {
    return Text(
      title,
      style: isSelect
          ? ShownyStyle.body2(
              color: ShownyStyle.mainPurple, weight: FontWeight.w700)
          : ShownyStyle.body2(
              color: ShownyStyle.gray070, weight: FontWeight.w500),
    );
  }

  Widget _buildGenderTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
      child: Row(
        children: [
          CupertinoButton(
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
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Text(
              'WOMAN',
              style: ShownyStyle.body2(weight: FontWeight.w500),
            ),
          ),
          SizedBox(width: 16.toWidth),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoButton(
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
                  minSize: 0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    'MAN',
                    style: ShownyStyle.body2(weight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
