import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/showny_style.dart';

import '../../../../../../../utils/theme.dart';
import '../../../../api/new_api/api_helper.dart';
import '../../../profile/other_profile_screen.dart';
import '../../../profile/profile_screen.dart';
import '../product_page.dart';

class ProductCatalogueWidget extends StatefulWidget {
  final MinishopProductModel minishopProduct;

  const ProductCatalogueWidget({
    Key? key,
    required this.minishopProduct,
  }) : super(key: key);

  @override
  State<ProductCatalogueWidget> createState() => _ProductCatalogueWidgetState();
}

class _ProductCatalogueWidgetState extends State<ProductCatalogueWidget> {
  List<MinishopProductModel> minishopProductList = [];
  List<StyleupModel> stlyeupList = [];

  @override
  void initState() {
    super.initState();

    ApiHelper.shared.getMemberMinishopProductList(
        widget.minishopProduct.memNo, 2, 0, (getMinishopProductList) {
      setState(() {
        minishopProductList.addAll(getMinishopProductList);
      });
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 24,
                    child: Text(
                      "${widget.minishopProduct.userInfo!.nickNm}${tr('product_detail.product_catalogue.headline')}",
                      style: themeData().textTheme.bodyMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .memNo ==
                          widget.minishopProduct.userInfo!.memNo) {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => ProfileScreen(),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => OtherProfileScreen(
                                memNo: widget.minishopProduct.userInfo!.memNo,
                                // init tap 1
                              ),
                            ));
                      }
                    },
                    child: Text(
                      tr('product_detail.seller_feed.see_more'),
                      style: ShownyStyle.caption(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: size.width,
            height: 130 * (5 / 4) + 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: minishopProductList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                              productId: minishopProductList[index].id),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 130,
                      height: 130 * (5 / 4) + 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Image.network(
                              minishopProductList[index].productImageUrlList[0],
                              width: 130,
                              height: (130 * (5 / 4)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          minishopProductList[index].brand != ''
                              ? Text(minishopProductList[index].brand,
                                  style: ShownyStyle.overline())
                              : const SizedBox(),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(minishopProductList[index].name,
                              style: ShownyStyle.caption(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                              "${minishopProductList[index].price.formatPrice()} 원",
                              style: FontHelper.bold_12_000000),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
