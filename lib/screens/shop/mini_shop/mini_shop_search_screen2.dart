import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/filter_minishop_model.dart';
import 'package:showny/screens/profile/widgets/my_shop_grid_item.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_appbar_widget.dart';

import '../store/widgets/sub_category_list_widget.dart';
import 'product_page.dart';
import 'providers/minishop_search_product_provider.dart';
import 'widgets/check_box_widget.dart';
import 'widgets/search_filter_minishop.dart';

class MinishopSearch2Screen extends StatefulWidget {
  final String? search;

  const MinishopSearch2Screen({Key? key, this.search}) : super(key: key);

  @override
  State<MinishopSearch2Screen> createState() => _MinishopSearch2ScreenState();
}

class _MinishopSearch2ScreenState extends State<MinishopSearch2Screen> {
  // int selectedValue = 1;
  bool isClearVisible = false;
  // bool totalSearchVisible = true;

  TextEditingController _searchController = TextEditingController();

  final List<String> subCategoryList = [
    tr("store.sub_category.all"),
    tr("store.sub_category.outer"),
    tr("store.sub_category.tops"),
    tr("store.sub_category.bottoms"),
    tr("store.sub_category.shoes"),
    tr("store.sub_category.accessories"),
    tr("store.sub_category.stuff"),
  ];

  final List<String> _dropdownItems = [
    "추천순",
    "신상품(재입고)순",
    "낮은 가격순",
    "높은 가격순",
    "후기순",
    "판매순",
  ];

  FilterMinishopModel filterMinishopModel = FilterMinishopModel();

  @override
  void initState() {
    _searchController.text = widget.search!;
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    // Provider.of<SearchProvider>(context, listen: false)
    //     .setIsSearch(widget.search.toString());
    // Provider.of<MiniShopSearchProductsProvider>(context, listen: false)
    //     .setSearchText(_searchController.text);
    Provider.of<MiniShopSearchProductsProvider>(context, listen: false)
        .getMiniShopProductList(
            memNo: userProvider.user.memNo,
            keyword: _searchController.text,
            filterMinishopModel: filterMinishopModel);
    super.initState();
  }

  void clearVisibilityChecker() {
    if (_searchController.text.isEmpty) {
      setState(() {
        isClearVisible = false;
        // totalSearchVisible = false;
      });

      // isClearVisible = false
    } else {
      setState(() {
        isClearVisible = true;
        // totalSearchVisible = true;
      });
      // Provider.of<SearchProvider>(context, listen: false)
      //     .setIsClearVisibleMinishopSearch(true);
      // Provider.of<SearchProvider>(context, listen: false)
      //     .setIsTotalSearchVisibleMinishop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Consumer<MiniShopSearchProductsProvider>(
        builder: (context, searchProvider, child) => (Scaffold(
              backgroundColor: white,
              appBar:
                  // Provider.of<SearchProvider>(context).getIsSearchClick()
                  // ? RoundedAppBar(
                  //     bgColor: white,
                  //     shadow: 0,
                  //     icon: Padding(
                  //       padding: const EdgeInsets.all(16),
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.pop(context);
                  //           Provider.of<SearchProvider>(context, listen: false)
                  //               .setIsSearchClick(false);
                  //         },
                  //         child: Image.asset(
                  //           arrowBackward,
                  //         ),
                  //       ),
                  //     ),
                  //     titleText: "스토어",
                  //     center: true,
                  //     action: [
                  //       Padding(
                  //         padding:
                  //             const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  //         child: Image.asset(search),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(16),
                  //         child: Image.asset(shopBag),
                  //       ),
                  //     ],
                  //   ) :
                  RoundedAppBar(
                bgColor: white,
                action: [
                  SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 31),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                arrowBackward,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 298,
                              height: 48,
                              decoration: const BoxDecoration(
                                  border:
                                      Border.fromBorderSide(BorderSide.none)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 48,
                                    child: TextField(
                                        style: themeData().textTheme.bodySmall,
                                        onEditingComplete: () {
                                          // Provider.of<SearchProvider>(context,
                                          //         listen: false)
                                          //     .setIsSearch(
                                          //         widget.search.toString());
                                          // searchProvider.setSearchText(
                                          //     _searchController.text);
                                          searchProvider.initPage();
                                          searchProvider.getMiniShopProductList(
                                              memNo: userProvider.user.memNo,
                                              keyword: _searchController.text,
                                              filterMinishopModel:
                                                  filterMinishopModel);
                                        },
                                        controller: _searchController,
                                        // onChanged: (value) {
                                        //   clearVisibilityChecker();
                                        //   Provider.of<SearchProvider>(context,
                                        //           listen: false)
                                        //       .setIsSearch(
                                        //           widget.search.toString());
                                        //   searchProvider.setSearchText(
                                        //       _searchController.text);
                                        // },
                                        decoration: InputDecoration(
                                            hintText: tr('search2.hint'),
                                            hintStyle: themeData()
                                                .textTheme
                                                .bodySmall
                                                ?.apply(color: greyLight),
                                            contentPadding:
                                                const EdgeInsets.only(left: 0),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide.none))),
                                  ),
                                  Visibility(
                                    visible: isClearVisible,
                                    child: GestureDetector(
                                      onTap: () {
                                        _searchController.clear();
                                        clearVisibilityChecker();
                                        // Provider.of<SearchProvider>(context,
                                        //         listen: false)
                                        //     .setIsSearchClick(true);
                                        // log("CLICK :: ${Provider.of<SearchProvider>(context, listen: false).getIsSearchClick()}");
                                      },
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                            color: black,
                                            shape: BoxShape.circle),
                                        child: const Center(
                                          child: Icon(
                                            CupertinoIcons.clear,
                                            color: white,
                                            size: 7.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              searchProvider.initPage();
                              searchProvider.getMiniShopProductList(
                                  memNo: userProvider.user.memNo,
                                  keyword: _searchController.text,
                                  filterMinishopModel: filterMinishopModel);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ProductDetailScreen(),
                              //     ));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, left: 8),
                              child: Image.asset(search),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
                shadow: 0,
              ),
              body: Column(
                children: [
                  const SizedBox(height: 4),
                  const Divider(
                    thickness: 1,
                    color: black,
                  ),
                  SubCategoryListWidget(
                    initSubCategoryIndex: filterMinishopModel.categoryId,
                    categoryList: subCategoryList,
                    onSelectCategory: (index) {
                      setState(() {
                        filterMinishopModel.categoryId = index;
                      });
                      searchProvider.initPage();
                      searchProvider.getMiniShopProductList(
                          memNo: userProvider.user.memNo,
                          keyword: _searchController.text,
                          filterMinishopModel: filterMinishopModel);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    color: greyExtraLight,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SearchFilterWidgetMinishop(
                    iconColor: greyLight,
                    filterMinishopModel: filterMinishopModel,
                    resetFilter: () {
                      var user =
                          Provider.of<UserProvider>(context, listen: false)
                              .user;
                      setState(() {
                        filterMinishopModel.initFilter();
                        var provider =
                            Provider.of<MiniShopSearchProductsProvider>(context,
                                listen: false);
                        provider.initPage();
                        provider.getMiniShopProductList(
                            memNo: user.memNo,
                            keyword: _searchController.text,
                            filterMinishopModel: filterMinishopModel);
                      });
                    },
                    applyFilter: (newFilterShopModel) {
                      setState(() {
                        var user =
                            Provider.of<UserProvider>(context, listen: false)
                                .user;
                        filterMinishopModel = newFilterShopModel;
                        var provider =
                            Provider.of<MiniShopSearchProductsProvider>(context,
                                listen: false);
                        provider.initPage();
                        provider.getMiniShopProductList(
                            memNo: user.memNo,
                            keyword: _searchController.text,
                            filterMinishopModel: filterMinishopModel);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: size.width,
                            child: Flexible(
                              child: Visibility(
                                visible:
                                    searchProvider.getSearchText().isNotEmpty,
                                child: Text(
                                  "'${searchProvider.getSearchText()}'${tr("store.search_result")} ${searchProvider.getProducts().length}${tr("store.search_result_count")}",
                                  style: ShownyStyle.caption(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 8,
                    color: divider,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CheckBoxWidget(
                    isWearCheck: filterMinishopModel.isWear,
                    isTansaction: filterMinishopModel.isTransaction,
                    checkWear: (isWear) {
                      setState(() {
                        filterMinishopModel.isWear = isWear;
                        // var minishopProductsProvider = Provider.of<MiniShopProductsProvider>(context, listen: false);
                        // minishopProductsProvider.initPage();
                        // minishopProductsProvider.getMiniShopProductList(user.memNo, "", filterMinishopModel);
                      });
                    },
                    checkTransaction: (isTransaction) {
                      setState(() {
                        filterMinishopModel.isTransaction = isTransaction;
                        var minishopProductsProvider =
                            Provider.of<MiniShopSearchProductsProvider>(context,
                                listen: false);
                        minishopProductsProvider.initPage();
                        minishopProductsProvider.getMiniShopProductList(
                            memNo: userProvider.user.memNo,
                            keyword: _searchController.text,
                            filterMinishopModel: filterMinishopModel);
                      });
                    },
                    sort: filterMinishopModel.sort,
                    changeSort: (sortIndex) {
                      setState(() {
                        filterMinishopModel.sort = sortIndex;
                        var minishopProductsProvider =
                            Provider.of<MiniShopSearchProductsProvider>(context,
                                listen: false);
                        minishopProductsProvider.initPage();
                        minishopProductsProvider.getMiniShopProductList(
                            memNo: userProvider.user.memNo,
                            keyword: _searchController.text,
                            filterMinishopModel: filterMinishopModel);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: searchProvider.getIsProductsLoading()
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : searchProvider.getProducts().isEmpty
                            ? Center(
                                child: Text(
                                  tr("search2.no_results_found"),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: (size.width / 3) /
                                      (((size.width / 3) * 5 / 4) + 100),
                                ),
                                itemCount: searchProvider.getProducts().length,
                                itemBuilder: (BuildContext context, int index) {
                                  var product =
                                      searchProvider.getProducts()[index];
                                  var image = "";
                                  if (filterMinishopModel.isWear) {
                                    image = product.wearImageUrlList.isNotEmpty
                                        ? product.wearImageUrlList[0]
                                        : "";
                                  } else {
                                    image =
                                        product.productImageUrlList.isNotEmpty
                                            ? product.productImageUrlList[0]
                                            : "";
                                  }
                                  return MyShopGridItem(
                                    brandName: product.brand,
                                    title: product.name,
                                    price: '${product.price.formatPrice()} 원',
                                    imageUrl: image,
                                    onTap: () {
                                      String productId = product.id;
                                      if (productId == "") {
                                        return;
                                      }
                                      Navigator.push(
                                          context,
                                          ShownyPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                              productId: productId,
                                            ),
                                          ));
                                    },
                                  );
                                },
                              ),
                  ),
                ],
              ),
            )));
  }
}
