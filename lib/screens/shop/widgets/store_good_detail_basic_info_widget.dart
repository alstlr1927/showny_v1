import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/helper/color_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';

import '../store_goods_list_screen.dart';

class StoreGoodDetailBasicInfoWidget extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailBasicInfoWidget({super.key, required this.goodsData});

  @override
  State<StoreGoodDetailBasicInfoWidget> createState() =>
      _StoreGoodDetailBasicInfoWidget();
}

class _StoreGoodDetailBasicInfoWidget
    extends State<StoreGoodDetailBasicInfoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 140,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  var brandData = BrandData(
                      cateNm: widget.goodsData.brandNm,
                      cateCd: widget.goodsData.brandCd,
                      brandImgUrl: widget.goodsData.brandImgUrl);
                  Navigator.push(
                      context,
                      ShownyPageRoute(
                        builder: (context) => StoreGoodsListScreen(
                          mainCategory: 2,
                          subCategory: 0,
                          brandData: brandData,
                        ),
                      ));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyExtraLight,
                        ),
                        child: Image.network(widget.goodsData.brandImgUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: ColorHelper.placeholderColor,
                                )),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(widget.goodsData.brandNm,
                        style: ShownyStyle.caption()),
                    const SizedBox(width: 4),
                    Image.asset(
                      arrowForward,
                      height: 12,
                      width: 12,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.goodsData.goodsNm,
                          style: FontHelper.bold_14_000000,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        widget.goodsData.memberRequestLink != ""
                            ? const SizedBox()
                            : Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: greyLight,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(widget.goodsData.grade.toString(),
                                      style: ShownyStyle.body2()),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      widget.goodsData.goodsDiscount != 0
                          ? Text(
                              "${widget.goodsData.goodsDiscount}%",
                              style: ShownyStyle.caption(),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 4),
                      Text(
                        "${(widget.goodsData.goodsPrice).formatPrice()} 원",
                        style: FontHelper.bold_14_000000,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
