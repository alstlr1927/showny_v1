import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../api/new_api/api_helper.dart';
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

    ApiHelper.shared.getMemberMinishopProductList(widget.minishopProduct.memNo, 2, 0, (getMinishopProductList) {
      setState(() {
        minishopProductList.addAll(getMinishopProductList);
      });
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
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
              Container(
                height: 24,
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "${widget.minishopProduct.userInfo!.nickNm}${tr('product_detail.product_catalogue.headline')}",
                  style: ShownyStyle.body2(
                    color: ShownyStyle.black,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16, bottom: 8),
              //   child: GestureDetector(
              //     onTap: () {
              //       if (Provider.of<UserProvider>(context, listen: false).user.memNo == widget.minishopProduct.userInfo!.memNo) {
              //         Navigator.push(
              //             context,
              //             ShownyPageRoute(
              //               builder: (context) => ProfileScreen(),
              //             ));
              //       } else {
              //         Navigator.push(
              //             context,
              //             ShownyPageRoute(
              //               builder: (context) => OtherProfileScreen(
              //                 memNo: widget.minishopProduct.userInfo!.memNo,
              //                 // init tap 1
              //               ),
              //             ));
              //       }
              //     },
              //     child: Text(
              //       tr('product_detail.seller_feed.see_more'),
              //       style: ShownyStyle.caption(),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // SizedBox(
        //   width: size.width,
        //   height: 130 * (5 / 4) + 80,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: minishopProductList.length,
        //     separatorBuilder: (context, index) => SizedBox(width: 8.toWidth),
        //     itemBuilder: (context, index) {
        //       return UserSellingProduct(
        //         minishopProductList: minishopProductList,
        //         index: index,
        //       );
        //     },
        //   ),
        // ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              minishopProductList.length,
              (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < minishopProductList.length - 1 ? 8.toWidth : 0),
                  child: UserSellingProduct(
                    minishopProductList: minishopProductList,
                    index: index,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class UserSellingProduct extends StatelessWidget {
  final int index;
  final List<MinishopProductModel> minishopProductList;

  const UserSellingProduct({
    super.key,
    required this.minishopProductList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(productId: minishopProductList[index].id),
            ));
      },
      child: Container(
        width: 130,
        margin: EdgeInsets.only(
          left: index == 0 ? 16 : 0,
          right: index == minishopProductList.length - 1 ? 16 : 0,
        ),
        // height: 130 * (5 / 4) + 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.network(
                minishopProductList[index].productImageUrlList[0],
                width: 130.toWidth,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            // const SizedBox(height: 12),
            minishopProductList[index].brand.isNotEmpty
                ? Text(
                    minishopProductList[index].brand,
                    style: ShownyStyle.overline(
                      color: Color(0xFF777777),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 12),
            Text(
              minishopProductList[index].name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ShownyStyle.caption(
                color: ShownyStyle.black,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "${minishopProductList[index].price.formatPrice()} 원",
              style: ShownyStyle.caption(
                weight: FontWeight.w700,
                color: ShownyStyle.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
