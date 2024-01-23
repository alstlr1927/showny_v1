import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/filter_shop_model.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/shop/providers/store_search_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Consumer<StoreSearchProvider>(
        builder: (context, searchProvider, child) {
      return Scaffold(
        backgroundColor: white,
        appBar: RoundedAppBar(
          bgColor: white,
          action: [
            SizedBox(
              width: size.width,
              height: 48,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
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
                          child: SizedBox(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: ShownyStyle.caption(),
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    onEditingComplete: () {
                                      searchProvider
                                          .setSearchText(searchController.text);
                                      searchProvider.initPage();
                                      searchProvider.setBrandCd("");
                                      searchProvider.getSearchList(
                                          userProvider.user.memNo,
                                          filterShopModel,
                                          widget.onSelected == null ? 0 : 1);
                                    },
                                    decoration: InputDecoration(
                                      hintText: tr('search.hint'),
                                      hintStyle: ShownyStyle.caption(),
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
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
                            searchProvider.setSearchText(searchController.text);
                            searchProvider.initPage();
                            searchProvider.setBrandCd("");
                            searchProvider.getSearchList(
                                userProvider.user.memNo,
                                filterShopModel,
                                widget.onSelected == null ? 0 : 1);
                          },
                          child: Image.asset(
                            search,
                            width: 24,
                            height: 24,
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
          child: searchProvider.isSearched == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: size.width,
                        child: Text(tr('search.recent_search.title'),
                            style: FontHelper.bold_14_000000),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        height: 32,
                        child: searchProvider.isRecentSearchLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : searchProvider
                                    .recentSearchList.recentSearch.isEmpty
                                ? Center(
                                    child: Text(
                                      tr("search.recent_search.no_recent_search"),
                                      style: ShownyStyle.caption(),
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
                                            const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: black),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, right: 8),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    searchProvider
                                                        .setSearchText(keyword);
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
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: const Icon(
                                                      CupertinoIcons.clear,
                                                      size: 16),
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
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: size.width,
                        height: 32,
                        child: Text(tr('search.popular_search.title'),
                            style: FontHelper.bold_14_000000),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                            child: searchProvider.isRecentSearchLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : searchProvider
                                        .recentSearchList.popularSearch.isEmpty
                                    ? Center(
                                        child: Text(
                                          tr("search.popular_search.no_popular_searches"),
                                          style: ShownyStyle.caption(),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
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
                                              color: white,
                                              width: size.width,
                                              child: Row(
                                                children: [
                                                  Text('${index + 1}',
                                                      style: ShownyStyle
                                                          .caption()),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(keyword,
                                                      style: ShownyStyle
                                                          .caption()),
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
      );
    });
  }
}
