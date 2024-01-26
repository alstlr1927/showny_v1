import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_appbar_widget.dart';

import 'mini_shop_search_screen2.dart';
import 'providers/minishop_search_product_provider.dart';
import 'providers/search_provider.dart';

class MinishopSearchScreen extends StatefulWidget {
  const MinishopSearchScreen({Key? key}) : super(key: key);

  @override
  State<MinishopSearchScreen> createState() => _MinishopSearchScreenState();
}

class _MinishopSearchScreenState extends State<MinishopSearchScreen> {
  int selectedValue = 1;
  TextEditingController _searchController = TextEditingController();
  FocusNode searchNode = FocusNode();

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    Provider.of<SearchProvider>(context, listen: false).getMinishopSearch(user.memNo);
    super.initState();
  }

  void clearVisibilityChecker() {
    if (_searchController.text.isEmpty) {
      // setState(() {
      //   isClearVisible = false;
      //   totalSearchVisible = false;
      // });

      Provider.of<SearchProvider>(context, listen: false).setIsClearVisibleMinishopSearch1(false);
      // Provider.of<SearchProvider>(context, listen: false)
      //     .setIsTotalSearchVisibleMinishop(false);
    } else {
      // setState(() {
      //   isClearVisible = true;
      //   totalSearchVisible = true;
      // });
      Provider.of<SearchProvider>(context, listen: false).setIsClearVisibleMinishopSearch1(true);
      // Provider.of<SearchProvider>(context, listen: false)
      //     .setIsTotalSearchVisibleMinishop(true);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    Size size = MediaQuery.of(context).size;

    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                    padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CupertinoButton(
                            onPressed: () {
                              Navigator.of(context).pop();
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
                                    onEditingComplete: () {
                                      // Provider.of<MiniShopSearchProductsProvider>(context).setSearchText(_searchController.text);
                                      Provider.of<MiniShopSearchProductsProvider>(context, listen: false)
                                          .getMiniShopProductList(memNo: userProvider.user.memNo, keyword: _searchController.text, filterMinishopModel: null);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MinishopSearch2Screen(
                                            search: _searchController.text,
                                          ),
                                        ),
                                      );
                                    },
                                    onChanged: (value) {
                                      clearVisibilityChecker();
                                    },
                                    style: themeData().textTheme.labelSmall?.apply(color: black),
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: tr('search.hint'),
                                      hintStyle: ShownyStyle.caption(color: Color(0xff777777)),
                                      contentPadding: const EdgeInsets.only(left: 0),
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Visibility(
                                    visible: Provider.of<SearchProvider>(context).getIsClearVisibleMinishopSearch1(),
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
                                          shape: BoxShape.circle,
                                        ),
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
                            Navigator.push(
                              context,
                              ShownyPageRoute(
                                builder: (context) => MinishopSearch2Screen(
                                  search: _searchController.text,
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            search,
                            height: 24.toWidth,
                            width: 24.toWidth,
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
        body: Consumer<SearchProvider>(
          builder: (context, searchProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: Text(
                    // 최근 검색어
                    tr('search.recent_search.title'),
                    style: ShownyStyle.body2(
                      weight: FontWeight.w700,
                      color: ShownyStyle.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18.toWidth,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.toWidth),
                child: SizedBox(
                  height: 28.toWidth,
                  child: searchProvider.getIsSearchLoading2()
                      ? Center(
                          child: ShownyIndicator(
                            radius: 15,
                            color: ShownyStyle.mainPurple,
                          ),
                        )
                      : searchProvider.minishopSearchModel!.data!.recentSearch!.isEmpty
                          ? Center(
                              child: Text(
                                tr("search.recent_search.no_recent_search"),
                                style: ShownyStyle.caption(
                                  color: Color(0xff777777),
                                  weight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: searchProvider.minishopSearchModel!.data!.recentSearch!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.toWidth),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: black, width: .5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                ShownyPageRoute(
                                                  builder: (context) => MinishopSearch2Screen(
                                                    search: searchProvider.minishopSearchModel!.data!.recentSearch![index].keyword,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "${searchProvider.minishopSearchModel!.data!.recentSearch![index].keyword}",
                                              style: ShownyStyle.caption(),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<SearchProvider>(context, listen: false)
                                                  .deleteMinishopSearch(user.memNo, "${searchProvider.minishopSearchModel!.data!.recentSearch![index].keyword}");
                                            },
                                            child: const Icon(
                                              CupertinoIcons.clear,
                                              size: 16,
                                            ),
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
                height: 39,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: size.width,
                  child: Text(
                    tr('search.popular_search.title'),
                    style: ShownyStyle.body2(
                      weight: FontWeight.bold,
                      color: ShownyStyle.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                      child: searchProvider.getIsSearchLoading2()
                          ? Center(
                              child: ShownyIndicator(
                                color: ShownyStyle.mainPurple,
                                radius: 15,
                              ),
                            )
                          : searchProvider.minishopSearchModel!.data!.popularSearch!.isEmpty
                              ? Center(
                                  child: Text(
                                    tr("search.popular_search.no_popular_searches"),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: searchProvider.minishopSearchModel!.data!.popularSearch!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          ShownyPageRoute(
                                            builder: (context) => MinishopSearch2Screen(
                                              search: searchProvider.minishopSearchModel!.data!.popularSearch![index].keyword,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Container(
                                          height: 40,
                                          color: white,
                                          width: size.width,
                                          child: Row(
                                            children: [
                                              Text(
                                                '${index + 1}',
                                                style: ShownyStyle.caption(
                                                  color: Color(0xFF777777),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                '${searchProvider.minishopSearchModel!.data!.popularSearch![index].keyword}',
                                                style: ShownyStyle.caption(
                                                  color: Color(0xFF777777),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
