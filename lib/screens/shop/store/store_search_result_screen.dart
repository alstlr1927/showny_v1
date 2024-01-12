import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/shop/common/widgets/dropdown_widget.dart';
import 'package:showny/screens/shop/common/widgets/main_category_list_widget.dart';
import 'package:showny/screens/shop/common/widgets/sub_category_list_widget.dart';
import 'package:showny/screens/shop/store/providers/store_search_provider.dart';
import 'package:showny/screens/shop/store/widgets/store_brand_widget.dart';
import 'package:showny/screens/shop/widgets/filter_widget.dart';
import 'package:showny/screens/shop/widgets/good_item_widget.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/widgets/custom_dropdown_widget.dart';

class StoreSearchResultScreen extends StatefulWidget {
  final String? search;
  final bool isViewMainCategory;
  final int? initMainCategory;
  final int? initSubCategory;
  final BrandData? initBrand;
  final Function(StoreGoodModel)? onSelected;

  const StoreSearchResultScreen(
      {Key? key,
      this.search,
      this.onSelected,
      required this.isViewMainCategory,
      this.initMainCategory,
      this.initSubCategory,
      this.initBrand})
      : super(key: key);

  @override
  State<StoreSearchResultScreen> createState() => _StoreSearchResultScreen();
}

class _StoreSearchResultScreen extends State<StoreSearchResultScreen> {
  final List<String> mainCategoryList = [
    tr("store.main_category.men"),
    tr("store.main_category.women"),
    tr("store.main_category.brands"),
  ];

  final List<String> subCategoryList = [
    tr("store.sub_category.all"),
    tr("store.sub_category.outer"),
    tr("store.sub_category.tops"),
    tr("store.sub_category.bottoms"),
    tr("store.sub_category.shoes"),
    tr("store.sub_category.accessories"),
    tr("store.sub_category.stuff"),
  ];

  final List<String> dropdownList = [
    tr("store.dropdown_filter.filter1"),
    tr("store.dropdown_filter.filter2"),
    tr("store.dropdown_filter.filter3"),
    tr("store.dropdown_filter.filter4"),
    tr("store.dropdown_filter.filter5"),
    tr("store.dropdown_filter.filter6"),
  ];

  int mainCategoryIndex = 0;
  BrandData? brandData;

  @override
  void initState() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    if (widget.initMainCategory != null) {
      setState(() {
        mainCategoryIndex = widget.initMainCategory!;
        Provider.of<StoreSearchProvider>(context, listen: false)
            .setMainCategory(widget.initMainCategory!);
      });
    }
    if (widget.initSubCategory != null) {
      setState(() {
        Provider.of<StoreSearchProvider>(context, listen: false)
            .setSubCategory(widget.initSubCategory!);
      });
    }
    if (widget.initBrand != null) {
      setState(() {
        brandData = widget.initBrand;
      });
    }

    refreshItemsStoreSearchPage();

    // Provider.of<SearchProvider>(context, listen: false)
    //     .setIsSearch(widget.search.toString());
    // Provider.of<SearchProvider>(context, listen: false)
    //     .getGoodListSearch(user.memNo, searchController.text, "", "", "");
    super.initState();
  }

  refreshItemsStoreSearchPage() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Provider.of<StoreSearchProvider>(context, listen: false).getSearchList(
      user.memNo,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Consumer<StoreSearchProvider>(
        builder: (context, searchProvider, child) {
      return Column(
        children: [
          widget.isViewMainCategory == true
              ? MainCategoryListWidget(
                  categoryList: mainCategoryList,
                  initIndex: widget.initMainCategory,
                  onSelectCategory: (index) {
                    mainCategoryIndex = index;

                    if (index == 2) {
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilderRightLeft(
                      //       child: BrandSearchScreen(selectBrand: (selectBrandData) {
                      //         searchProvider.setBrandCd(selectBrandData.cateCd);
                      //         searchProvider.getSearchList(user.memNo);
                      //         setState(() {
                      //           brandData = selectBrandData;
                      //         });
                      //       },)));
                    } else {
                      searchProvider.setMainCategory(index);
                      searchProvider.getSearchList(user.memNo);
                    }
                  },
                )
              : const SizedBox(),
          widget.isViewMainCategory == true &&
                  mainCategoryIndex == 2 &&
                  brandData != null
              ? StoreBrandWidget(brandData: brandData!)
              : const SizedBox(),
          SubCategoryListWidget(
            categoryList: subCategoryList,
            initSubCategoryIndex: widget.initSubCategory,
            onSelectCategory: (index) {
              searchProvider.setSubCategory(index);
              searchProvider.getSearchList(user.memNo);
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: greyExtraLight,
          ),
          const SizedBox(
            height: 14,
          ),
          const SearchFilterWidget(
            iconColor: greyLight,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: searchProvider.searchText.isNotEmpty,
                  child: Text(
                    "'${searchProvider.searchText}'${tr("store.search_result")} ${searchProvider.goodsList.length}${tr("store.search_result_count")}",
                    style: ShownyStyle.caption(color: ShownyStyle.black),
                  ),
                ),
                const Spacer(),
                DropdownWidget(
                    itemList: dropdownList,
                    onSelectItem: (index) {
                      searchProvider.setSort(index);
                      searchProvider.getSearchList(user.memNo);
                    })
              ],
            ),
          ),
          Expanded(
            child: searchProvider.isSearchLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : searchProvider.goodsList.isEmpty
                    ? Center(
                        child: Text(
                          tr("search2.no_results_found"),
                          style: ShownyStyle.body2(color: ShownyStyle.gray070),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          refreshItemsStoreSearchPage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                childAspectRatio: ((size.width - 48) / 2) /
                                    (((size.width - 48) / 2) * (5 / 4) + 160),
                              ),
                              itemCount: searchProvider.goodsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GoodItemWidget(
                                    goodsData: searchProvider.goodsList[index],
                                    onSelected: (goodsData) {
                                      debugPrint(goodsData.toString());
                                      if (widget.onSelected == null) {
                                        // Navigator.push(
                                        //     context,
                                        //     PageRouteBuilderRightLeft(
                                        //       child: StoreGoodDetailScreen(
                                        //           goodsNo: goodsData.goodsNo),
                                        //     ));
                                      } else {
                                        _showBottomSheet(context, goodsData);
                                      }
                                      debugPrint(widget.onSelected.toString());
                                    });
                              }),
                        )),
          )
        ],
      );
    });
  }

  void _showBottomSheet(BuildContext context, StoreGoodModel goodsData) {
    List<String?> selectOptionList =
        List.filled(goodsData.optionList.length, null);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext buildContext) {
        return Container(
            height: 258,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Image.asset(
                      'assets/images/bottom_sheet_arrow.png',
                      width: 40,
                      height: 12,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // const Row(
                    //   children: [
                    //     Text(
                    //       "착용 사이즈",
                    //     ),
                    //     Spacer(),
                    //     Text("모르겠어요!")
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (int index = 0;
                        index < goodsData.optionList.length;
                        index++)
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            child: CustomDropDown(
                              dropDownItems: goodsData.optionList[index].value,
                              padding: const EdgeInsets.only(right: 16),
                              hintText: '옵션 선택',
                              selectedItem: selectOptionList[index],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectOptionList[index] = newValue;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    SVButton(
                        title: '선택 완료',
                        titleColor: Colors.white,
                        backgroundColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);

                          var dialog = ShownyDialog(
                            message: '상품을 아이템 태그하시겠습니까?',
                            primaryAction: () {},
                            secondaryAction: () {
                              if (widget.onSelected != null) {
                                widget.onSelected!(goodsData);
                              }
                              Navigator.pop(context);
                            },
                            primaryLabel: '취소',
                            secondaryLabel: '확인',
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return dialog;
                            },
                          );
                        }),
                  ],
                )));
      },
    );
  }
}
