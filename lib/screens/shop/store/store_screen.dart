import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/main.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';

import '../../profile/profile_screen.dart';
import 'providers/store_provider.dart';
import 'providers/store_wishlist_provider.dart';
import 'store_goods_list_screen.dart';
import 'store_search_page_screen.dart';
import 'widgets/bannerSlider_widget.dart';
import 'widgets/event_tab_refresh.dart';
import 'widgets/ranking_widget.dart';
import 'widgets/store_home_products_widget.dart';
import 'widgets/wishlist_grid_component.dart';

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
    eventBus.on<EventTabRefresh>().listen((event) {
      if (event.index == 2) {
        setState(() {
          refreshItemsMainPage();
        });
      }
    });
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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24.toWidth),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
            child: SizedBox(
              width: size.width,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<StoreProvider>(context, listen: false)
                          .updateIndex(0);
                    },
                    child: SizedBox(
                      width: size.width * 0.10,
                      child: Text(
                        tr("store.tabs.home"),
                        style: themeData().textTheme.titleLarge!.copyWith(
                              color: Provider.of<StoreProvider>(context)
                                          .indexTab ==
                                      0
                                  ? black
                                  : greyLight,
                            ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<StoreProvider>(context, listen: false)
                          .updateIndex(1);
                    },
                    child: SizedBox(
                      width: size.width * 0.15,
                      child: Text(
                        tr('store.tabs.ranking'),
                        style: themeData().textTheme.titleLarge!.copyWith(
                              color: Provider.of<StoreProvider>(context)
                                          .indexTab ==
                                      1
                                  ? black
                                  : greyLight,
                            ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<StoreProvider>(context, listen: false)
                          .updateIndex(2);
                    },
                    child: SizedBox(
                      width: size.width * 0.15,
                      child: Text(
                        tr('store.tabs.steamed'),
                        style: themeData().textTheme.titleLarge!.copyWith(
                              color: Provider.of<StoreProvider>(context)
                                          .indexTab ==
                                      2
                                  ? Colors.black
                                  : greyLight,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 24.toWidth),
          Padding(
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
                                builder: (context) =>
                                    const StoreGoodsListScreen(
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
          ),
          SizedBox(height: 24.toWidth),
          const BannerSliderWidget(index: 1),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StoreSearchScreen(),
                                ));
                          },
                          child: Image.asset(
                            search,
                            height: 24,
                            width: 24,
                          )),
                      // SizedBox(
                      //   width: size.width * 0.02,
                      // ),
                      // GestureDetector(
                      //     onTap: () {
                      //       ProfilePageCategory? category =
                      //           ProfilePageCategory.myShopping;
                      //       Navigator.push(
                      //           context,
                      //           PageRouteBuilderRightLeft(
                      //               child: const StoreSearchScreen()));
                      //     },
                      //     child: Image.asset(
                      //       search,
                      //       height: 24,
                      //       width: 24,
                      //     )),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          ProfilePageCategory? category =
                              ProfilePageCategory.myShopping;
                          Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => ProfileScreen(
                                category: category,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          shopBag,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          const SizedBox(
            height: 12,
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
                // const SizedBox(width: 15),
                // Expanded(
                //   child: Consumer<StoreProvider>(
                //       builder: (context, provider, child) => ListView.builder(
                //             shrinkWrap: true,
                //             physics: const NeverScrollableScrollPhysics(),
                //             itemCount: provider.categories.length,
                //             itemBuilder: (BuildContext context, int index) {
                //               return GestureDetector(
                //                 onTap: () {
                //                   var provider =
                //                       Provider.of<StoreDetailFilterProvider>(
                //                           context,
                //                           listen: false);
                //                   provider
                //                     ..setSelectedTabFilter(
                //                         StoreSelectionTab.men)
                //                     ..setSelectedCategory(index + 1)
                //                     ..setSelectedBrand(null);
                //                   Navigator.push(
                //                       context,
                //                       PageRouteBuilderRightLeft(
                //                           child:
                //                               const StoreDetailWithFilter()));
                //                 },
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                       border: Border(
                //                           bottom: BorderSide(
                //                     color: index == 5 ? white : greyExtraLight,
                //                   ))),
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(
                //                         right: 8, top: 16, bottom: 16),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Text(
                //                           provider.categories[index],
                //                           style:
                //                               themeData().textTheme.labelSmall,
                //                         ),
                //                         const Icon(
                //                           CupertinoIcons.add,
                //                           size: 16,
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             },
                //           )),
                // ),
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
                            // var provider =
                            //     Provider.of<StoreDetailFilterProvider>(context,
                            //         listen: false);
                            // provider
                            //   ..setSelectedTabFilter(StoreSelectionTab.men)
                            //   ..setSelectedCategory(index + 1)
                            //   ..setSelectedBrand(null);

                            Navigator.push(
                                context,
                                ShownyPageRoute(
                                  builder: (context) => StoreGoodsListScreen(
                                    mainCategory: 0,
                                    subCategory: index + 1,
                                  ),
                                ));
                            // UserProvider userProvider =
                            //     Provider.of<UserProvider>(context,
                            //         listen: false);
                            // final user = userProvider.user;
                            // Provider.of<BrandStorePageProvider>(context,
                            //         listen: false)
                            //     .updateIndex(0);
                            // Provider.of<BrandStorePageProvider>(context,
                            //         listen: false)
                            //     .updateIndexSubCat(index + 1);
                            // Provider.of<SearchProvider>(context, listen: false)
                            //     .getGoodListSearch(
                            //         user.memNo, "", "2", "$index", "");
                            //
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           const MenWomenBrandPage(),
                            //     ));
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

          const SizedBox(
            height: 40,
          ),

          const SizedBox(
            height: 24,
          ),
          Provider.of<StoreProvider>(context, listen: false).indexTab == 0
              ? const StoreHomeProductsWidget()
              : Provider.of<StoreProvider>(context, listen: false).indexTab == 1
                  ? const RankingWidget()
                  : const WishListComponent(),
          // SizedBox(
          //   height: size.height * 0.04,
          // ),
        ],
      ),
    );
  }
}
