import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_appbar_widget.dart';
import 'package:showny/widgets/shoping_emptyBasket_widget.dart';

import '../../../components/showny_button/showny_button.dart';
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
                              Navigator.pop(context);
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
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    onEditingComplete: () {
                                      searchProvider.getBrandSearch(
                                          user.memNo, searchController.text);
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
                            searchProvider.getBrandSearch(
                              user.memNo,
                              searchController.text,
                            );
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
                          ? Center(
                              child: ShownyIndicator(
                                radius: 15,
                                color: ShownyStyle.mainPurple,
                              ),
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
                                    childAspectRatio: 80 / 95,
                                  ),
                                  itemCount:
                                      searchProvider.brandResponse!.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _BrandGridItem(
                                      brandData: searchProvider
                                          .brandResponse!.data[index],
                                      selectBrand: widget.selectBrand,
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

class _BrandGridItem extends StatelessWidget {
  final Function(BrandData)? selectBrand;
  final BrandData brandData;
  const _BrandGridItem({
    Key? key,
    this.selectBrand,
    required this.brandData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: () {
        selectBrand!(brandData);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80.toWidth,
            width: 80.toWidth,
            decoration: BoxDecoration(
              border: Border.all(color: ShownyStyle.gray040),
              shape: BoxShape.circle,
            ),
            child: Image.network(brandData.brandImgUrl),
          ),
          SizedBox(height: 18.toWidth),
          Text(brandData.cateNm,
              style: ShownyStyle.overline(color: ShownyStyle.black)),
        ],
      ),
    );
  }
}
