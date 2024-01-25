import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/models/filter_shop_model.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/shop/store/providers/store_search_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/widgets/common_appbar_widget.dart';

import 'store_search_result_screen.dart';

class StoreSearchScreen extends StatefulWidget {
  const StoreSearchScreen({Key? key, this.onSelected}) : super(key: key);

  final Function(StoreGoodModel)? onSelected;

  @override
  State<StoreSearchScreen> createState() => _StoreSearchScreenState();
}

class _StoreSearchScreenState extends State<StoreSearchScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();

  FilterShopModel filterShopModel = FilterShopModel();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      Provider.of<StoreSearchProvider>(context, listen: false)
          .getRecentSearchList(user.memNo);
      Provider.of<StoreSearchProvider>(context, listen: false).initParams();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Consumer<StoreSearchProvider>(
        builder: (context, searchProvider, child) {
      return GestureDetector(
        onTap: () => searchNode.unfocus(),
        child: Scaffold(
          backgroundColor: white,
          appBar: RoundedAppBar(
            bgColor: white,
            action: [
              SizedBox(
                width: ScreenUtil().screenWidth,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.toWidth, right: 16.toWidth),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CupertinoButton(
                              onPressed: () {
                                if (searchProvider.isSearched) {
                                  searchProvider.setIsSearched(false);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              minSize: 0.0,
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: ShownyStyle.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style: ShownyStyle.caption(),
                                      focusNode: searchNode,
                                      controller: searchController,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      onEditingComplete: () {
                                        searchNode.unfocus();
                                        searchProvider.setSearchText(
                                            searchController.text);
                                        searchProvider.initPage();
                                        searchProvider.setBrandCd("");
                                        searchProvider.getSearchList(
                                            userProvider.user.memNo,
                                            filterShopModel,
                                            widget.onSelected == null ? 0 : 1);
                                      },
                                      decoration: InputDecoration(
                                        hintText: tr('search.hint'),
                                        hintStyle: ShownyStyle.caption(
                                            color: Color(0xff777777)),
                                        contentPadding:
                                            const EdgeInsets.only(left: 0),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Visibility(
                                      visible:
                                          searchController.value.text.isEmpty ==
                                              false,
                                      child: GestureDetector(
                                        onTap: () {
                                          searchController.clear();
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              searchNode.unfocus();
                              searchProvider
                                  .setSearchText(searchController.text);
                              searchProvider.initPage();
                              searchProvider.setBrandCd("");
                              searchProvider.getSearchList(
                                  userProvider.user.memNo,
                                  filterShopModel,
                                  widget.onSelected == null ? 0 : 1);
                            },
                            child: Image.asset(
                              search,
                              width: 24.toWidth,
                              height: 24.toWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black,
                    )
                  ],
                ),
              )
            ],
            shadow: 0,
          ),
          body: SafeArea(
            child: !searchProvider.isSearched
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18.toWidth),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                        child: SizedBox(
                          width: ScreenUtil().screenWidth,
                          child: Text(tr('search.recent_search.title'),
                              style: ShownyStyle.body2(
                                  color: ShownyStyle.black,
                                  weight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(height: 18.toWidth),
                      Padding(
                        padding: EdgeInsets.only(left: 16.toWidth),
                        child: SizedBox(
                          height: 28.toWidth,
                          child: searchProvider.isRecentSearchLoading
                              ? Center(
                                  child: ShownyIndicator(
                                    radius: 15,
                                    color: ShownyStyle.mainPurple,
                                  ),
                                )
                              : searchProvider
                                      .recentSearchList.recentSearch.isEmpty
                                  ? Center(
                                      child: Text(
                                        tr("search.recent_search.no_recent_search"),
                                        style: ShownyStyle.caption(
                                            color: Color(0xff777777),
                                            weight: FontWeight.w500),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: searchProvider
                                          .recentSearchList.recentSearch.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        String keyword = searchProvider
                                            .recentSearchList
                                            .recentSearch[index]
                                            .keyword;

                                        return Padding(
                                          padding:
                                              EdgeInsets.only(right: 8.toWidth),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: black, width: .5),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      searchProvider
                                                          .setSearchText(
                                                              keyword);
                                                      searchProvider.initPage();
                                                      searchProvider
                                                          .setBrandCd("");
                                                      searchProvider
                                                          .getSearchList(
                                                              user.memNo,
                                                              filterShopModel,
                                                              widget.onSelected ==
                                                                      null
                                                                  ? 0
                                                                  : 1);
                                                    },
                                                    child: Text(
                                                      keyword,
                                                      style:
                                                          ShownyStyle.caption(),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.toWidth),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                        CupertinoIcons.clear,
                                                        size: 12.toWidth),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ),
                      SizedBox(height: 30.toWidth),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                        child: Text(tr('search.popular_search.title'),
                            style: ShownyStyle.body2(
                                color: ShownyStyle.black,
                                weight: FontWeight.w700)),
                      ),
                      SizedBox(height: 10.toWidth),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                          child: Container(
                              child: searchProvider.isRecentSearchLoading
                                  ? Center(
                                      child: ShownyIndicator(
                                        radius: 15,
                                        color: ShownyStyle.mainPurple,
                                      ),
                                    )
                                  : searchProvider.recentSearchList
                                          .popularSearch.isEmpty
                                      ? Center(
                                          child: Text(
                                            tr("search.popular_search.no_popular_searches"),
                                            style: ShownyStyle.caption(
                                                color: Color(0xff777777),
                                                weight: FontWeight.w500),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: searchProvider
                                              .recentSearchList
                                              .popularSearch
                                              .length,
                                          itemBuilder: (context, index) {
                                            var keyword = searchProvider
                                                .recentSearchList
                                                .popularSearch[index]
                                                .keyword;

                                            return GestureDetector(
                                              onTap: () {
                                                searchProvider
                                                    .setSearchText(keyword);
                                                searchProvider.initPage();
                                                searchProvider.setBrandCd("");
                                                searchProvider.getSearchList(
                                                    user.memNo,
                                                    filterShopModel,
                                                    widget.onSelected == null
                                                        ? 0
                                                        : 1);
                                              },
                                              child: Container(
                                                height: 48,
                                                color: Colors.white,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 18.toWidth,
                                                      child: Text(
                                                        '${index + 1}',
                                                        style:
                                                            ShownyStyle.caption(
                                                                color: Color(
                                                                    0xff777777),
                                                                weight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.toWidth),
                                                    Text(keyword,
                                                        style:
                                                            ShownyStyle.caption(
                                                                color: Color(
                                                                    0xff777777),
                                                                weight:
                                                                    FontWeight
                                                                        .w500)),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                        ),
                      )
                    ],
                  )
                : StoreSearchResultScreen(
                    onSelected: widget.onSelected,
                    isViewMainCategory: false,
                  ),
          ),
        ),
      );
    });
  }
}
