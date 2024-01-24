import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_appbar_widget.dart';

class MinishopSearchScreen extends StatefulWidget {
  const MinishopSearchScreen({Key? key}) : super(key: key);

  @override
  State<MinishopSearchScreen> createState() => _MinishopSearchScreenState();
}

class _MinishopSearchScreenState extends State<MinishopSearchScreen> {
  int selectedValue = 1;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    Provider.of<SearchProvider>(context, listen: false)
        .getMinishopSearch(user.memNo);
    super.initState();
  }

  void clearVisibilityChecker() {
    if (_searchController.text.isEmpty) {
      // setState(() {
      //   isClearVisible = false;
      //   totalSearchVisible = false;
      // });

      Provider.of<SearchProvider>(context, listen: false)
          .setIsClearVisibleMinishopSearch1(false);
      // Provider.of<SearchProvider>(context, listen: false)
      //     .setIsTotalSearchVisibleMinishop(false);
    } else {
      // setState(() {
      //   isClearVisible = true;
      //   totalSearchVisible = true;
      // });
      Provider.of<SearchProvider>(context, listen: false)
          .setIsClearVisibleMinishopSearch1(true);
      // Provider.of<SearchProvider>(context, listen: false)
      //     .setIsTotalSearchVisibleMinishop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    Size size = MediaQuery.of(context).size;
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: white,
      appBar: RoundedAppBar(
        bgColor: white,
        action: [
          SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        arrowBackward,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 298,
                      height: 48,
                      decoration: const BoxDecoration(
                          border: Border.fromBorderSide(BorderSide.none)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 48,
                            width: 200,
                            child: TextField(
                              onEditingComplete: () {
                                // Provider.of<MiniShopSearchProductsProvider>(context).setSearchText(_searchController.text);
                                Provider.of<MiniShopSearchProductsProvider>(
                                        context,
                                        listen: false)
                                    .getMiniShopProductList(
                                        memNo: userProvider.user.memNo,
                                        keyword: _searchController.text,
                                        filterMinishopModel: null);

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
                              style: themeData()
                                  .textTheme
                                  .labelSmall
                                  ?.apply(color: black),
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: tr('search.hint'),
                                hintStyle: themeData()
                                    .textTheme
                                    .bodySmall
                                    ?.apply(color: greyLight),
                                contentPadding: const EdgeInsets.only(left: 0),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: Provider.of<SearchProvider>(context)
                                .getIsClearVisibleMinishopSearch1(),
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
                                    color: black, shape: BoxShape.circle),
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
                  const SizedBox(width: 10),
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
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        shadow: 0,
      ),
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            const Divider(
              thickness: 1,
              color: black,
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: size.width,
                child: Text(tr('search.recent_search.title'),
                    style: themeData().textTheme.titleMedium),
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                height: 32,
                child: searchProvider.getIsSearchLoading2()
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : searchProvider
                            .minishopSearchModel!.data!.recentSearch!.isEmpty
                        ? Center(
                            child: Text(
                              tr("search.recent_search.no_recent_search"),
                              style: const TextStyle(fontSize: 12),
                            ),
                          )
                        : ListView.builder(
                            itemCount: searchProvider.minishopSearchModel!.data!
                                .recentSearch!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: black),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 8),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              ShownyPageRoute(
                                                builder: (context) =>
                                                    MinishopSearch2Screen(
                                                  search: searchProvider
                                                      .minishopSearchModel!
                                                      .data!
                                                      .recentSearch![index]
                                                      .keyword,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "${searchProvider.minishopSearchModel!.data!.recentSearch![index].keyword}",
                                            style:
                                                themeData().textTheme.bodySmall,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Provider.of<SearchProvider>(context,
                                                    listen: false)
                                                .deleteMinishopSearch(
                                                    user.memNo,
                                                    "${searchProvider.minishopSearchModel!.data!.recentSearch![index].keyword}");
                                          },
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
              height: 39,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: size.width,
                child: Text(tr('search.popular_search.title'),
                    style: themeData().textTheme.titleMedium),
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
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : searchProvider.minishopSearchModel!.data!
                                .popularSearch!.isEmpty
                            ? Center(
                                child: Text(
                                  tr("search.popular_search.no_popular_searches"),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: searchProvider.minishopSearchModel!
                                    .data!.popularSearch!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        ShownyPageRoute(
                                          builder: (context) =>
                                              MinishopSearch2Screen(
                                            search: searchProvider
                                                .minishopSearchModel!
                                                .data!
                                                .popularSearch![index]
                                                .keyword,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        height: 40,
                                        color: white,
                                        width: size.width,
                                        child: Row(
                                          children: [
                                            Text('${index + 1}',
                                                style: themeData()
                                                    .textTheme
                                                    .bodySmall
                                                    ?.apply(color: greyLight)),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                "${searchProvider.minishopSearchModel!.data!.popularSearch![index].keyword}",
                                                style: themeData()
                                                    .textTheme
                                                    .bodySmall
                                                    ?.apply(color: greyLight)),
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
    );
  }
}
