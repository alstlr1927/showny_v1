import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/helper/color_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

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

    return Container(
      width: size.width,
      padding:
          EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 16.toWidth),
      // height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseButton(
            onPressed: () {
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
                Container(
                  height: 24.toWidth,
                  width: 24.toWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ShownyStyle.white,
                    boxShadow: ShownyStyle.elevation_01dp(),
                    image: DecorationImage(
                      image: NetworkImage(widget.goodsData.brandImgUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 4.toWidth),
                Text(
                  widget.goodsData.brandNm,
                  style: ShownyStyle.caption(),
                ),
                SizedBox(width: 4.toWidth),
                Image.asset(
                  arrowForward,
                  height: 10.toWidth,
                  width: 10.toWidth,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: ScreenUtil().screenWidth * .65,
            child: Text(
              widget.goodsData.goodsNm,
              style: ShownyStyle.body2(weight: FontWeight.w700),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 24.toWidth,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/shop/heart_empty.png',
                  width: 18.toWidth,
                ),
                SizedBox(width: 4.toWidth),
                Text(
                  '${widget.goodsData.heartCount}',
                  style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
                ),
                SizedBox(width: 22.toWidth),
                if (widget.goodsData.memberRequestLink == '') ...{
                  Image.asset(
                    'assets/icons/shop/grade_empty.png',
                    width: 18.toWidth,
                  ),
                  SizedBox(width: 4.toWidth),
                  Text(
                    '${widget.goodsData.grade}',
                    style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
                  ),
                },
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (widget.goodsData.goodsDiscount == 0)
                      Text(
                        "${widget.goodsData.goodsDiscount}%",
                        style: ShownyStyle.caption(
                            color: ShownyStyle.mainRed,
                            weight: FontWeight.bold),
                      ),
                    SizedBox(width: 4.toWidth),
                    Text(
                      "${(widget.goodsData.goodsPrice).formatPrice()} 원",
                      style: ShownyStyle.body2(
                          color: ShownyStyle.black, weight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
