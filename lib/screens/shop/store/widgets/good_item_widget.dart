import 'package:flutter/material.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class GoodItemWidget extends StatefulWidget {
  final StoreGoodModel goodsData;
  final Function(StoreGoodModel) onSelected;

  GoodItemWidget({
    Key? key,
    required this.goodsData,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<GoodItemWidget> createState() => _GoodItemWidget();
}

class _GoodItemWidget extends State<GoodItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(widget.goodsData);
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.goodsData.goodsImageUrlList[0],
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.toWidth),
          Text(
            "${widget.goodsData.brandNm}",
            style: ShownyStyle.caption(
                color: ShownyStyle.black, weight: FontWeight.w600),
          ),
          SizedBox(height: 4.toWidth),
          SizedBox(
            child: Text(
              widget.goodsData.goodsNm,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ShownyStyle.caption(color: ShownyStyle.black),
            ),
          ),
          SizedBox(height: 8.toWidth),
          Text(
            "${(widget.goodsData.goodsPrice).formatPrice()} 원",
            style: ShownyStyle.body2(
                color: ShownyStyle.black, weight: FontWeight.w700),
          ),
          SizedBox(height: 2.toWidth),
          Text(
            "즉시 구매가",
            style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
          ),
          SizedBox(height: 4.toWidth),
          Row(
            children: [
              Image.asset('assets/icons/shop/heart_icon.png',
                  height: 14.toWidth, width: 14.toWidth),
              SizedBox(width: 4.toWidth),
              Text(
                "${widget.goodsData.heartCount}",
                style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
              ),
              SizedBox(width: 8.toWidth),
              Image.asset('assets/icons/shop/grade_icon.png',
                  height: 14.toWidth, width: 14.toWidth),
              SizedBox(width: 4.toWidth),
              Text(
                "${widget.goodsData.grade}(${widget.goodsData.reviewCount})",
                style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
