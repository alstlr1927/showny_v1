import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_appbar_widget.dart';
import 'package:showny/widgets/shoping_emptyBasket_widget.dart';

import 'providers/search_brand_provider.dart';

class BrandSearchScreen extends StatefulWidget {
  final Function(BrandData)? selectBrand;
  const BrandSearchScreen({
    super.key,
    this.selectBrand,
  });

  @override
  State<BrandSearchScreen> createState() => _BrandSearchScreen();
}

class _BrandSearchScreen extends State<BrandSearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      refreshItemsBrand();
    });
    super.initState();
  }

  refreshItemsBrand() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Provider.of<SearchBrandProvider>(context, listen: false)
        .getBrandSearch(user.memNo, searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Consumer<SearchBrandProvider>(
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
                                    decoration: InputDecoration(
                                      hintText: tr('search.hint'),
                                      hintStyle: ShownyStyle.caption(),
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    onEditingComplete: () {
                                      searchProvider.getBrandSearch(
                                          user.memNo, searchController.text);
                                    },
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
                            searchProvider.getBrandSearch(
                              user.memNo,
                              searchController.text,
                            );
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
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 23),
                    Text(
                      tr("brand.brand_list"),
                      style: themeData().textTheme.titleMedium,
                    ),
                    const SizedBox(height: 23),
                    Expanded(
                      child: searchProvider.getIsBrandSearchLoading()
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : searchProvider.brandResponse!.data.isEmpty
                              ? ShoppingEmptyBasketWidget(
                                  emptyMessage: tr('empty_errors.no_brands'))
                              : GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 2,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount:
                                      searchProvider.brandResponse!.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // StoreDetailFilterProvider filterProvider =
                                    //     Provider.of<StoreDetailFilterProvider>(
                                    //         context);
                                    int selectedIndex = -1;
                                    return SizedBox(
                                      width: size.width * 0.3,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (widget.selectBrand != null) {
                                            widget.selectBrand!(searchProvider
                                                .brandResponse!.data[index]);
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        selectedIndex == index
                                                            ? black
                                                            : greyExtraLight),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                  searchProvider.brandResponse!
                                                      .data[index].brandImgUrl),
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Text(
                                                searchProvider.brandResponse!
                                                    .data[index].cateNm,
                                                style: themeData()
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: selectedIndex ==
                                                                index
                                                            ? black
                                                            : textColor)),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
