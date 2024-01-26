import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
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
    return Scaffold(
      backgroundColor: white,
      appBar: RoundedAppBar(
        bgColor: white,
        shadow: 0,
        icon: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ShownyStyle.black,
          ),
        ),
        titleText: tr("mini_shop.tabs.store"),
        center: true,
        action: [
          Row(
            children: [
              BaseButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      ShownyPageRoute(
                        builder: (context) => StoreSearchScreen(),
                      ));
                },
                child: Image.asset(search, width: 24.toWidth),
              ),
              SizedBox(width: 12.toWidth),
              BaseButton(
                onPressed: () {
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
                  'assets/icons/profile/shopping_list.png',
                  width: 24.toWidth,
                ),
              ),
              SizedBox(width: 16.toWidth),
            ],
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: StoreSearchResultScreen(
          isViewMainCategory: true,
          initMainCategory: widget.mainCategory,
          initSubCategory: widget.subCategory,
          initBrand: widget.brandData,
        ),
      ),
    );
  }
}
