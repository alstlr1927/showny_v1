import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/widgets/common_appbar_widget.dart';

import '../../profile/profile_screen.dart';
import 'providers/store_search_provider.dart';
import 'store_search_page_screen.dart';
import 'store_search_result_screen.dart';

class StoreGoodsListScreen extends StatefulWidget {
  final int mainCategory;
  final int subCategory;
  final BrandData? brandData;

  const StoreGoodsListScreen(
      {Key? key,
      required this.mainCategory,
      required this.subCategory,
      this.brandData})
      : super(key: key);

  @override
  State<StoreGoodsListScreen> createState() => _StoreGoodsListScreen();
}

class _StoreGoodsListScreen extends State<StoreGoodsListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      Provider.of<StoreSearchProvider>(context, listen: false).initParams();

      Provider.of<StoreSearchProvider>(context, listen: false)
          .setMainCategory(widget.mainCategory);
      Provider.of<StoreSearchProvider>(context, listen: false)
          .setSubCategory(widget.subCategory);
      Provider.of<StoreSearchProvider>(context, listen: false)
          .setBrandCd(widget.brandData == null ? "" : widget.brandData!.cateCd);
      Provider.of<StoreSearchProvider>(context, listen: false)
          .getSearchList(user.memNo, null, widget.brandData == null ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: white,
      appBar: RoundedAppBar(
        bgColor: white,
        shadow: 0,
        icon: Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              arrowBackward,
            ),
          ),
        ),
        titleText: tr("mini_shop.tabs.store"),
        center: true,
        action: [
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      ShownyPageRoute(
                        builder: (context) => StoreSearchScreen(),
                      ));
                },
                child: Image.asset(search),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 16),
              child: GestureDetector(
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
                child: Image.asset(shopBag),
              )),
        ],
      ),
      body: SafeArea(
          child: StoreSearchResultScreen(
        isViewMainCategory: true,
        initMainCategory: widget.mainCategory,
        initSubCategory: widget.subCategory,
        initBrand: widget.brandData,
      )),
    );
  }
}
