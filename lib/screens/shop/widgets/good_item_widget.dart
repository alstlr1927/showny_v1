import 'package:flutter/material.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';

class GoodItemWidget extends StatefulWidget {
  StoreGoodModel goodsData;
  final Function(StoreGoodModel) onSelected;

  GoodItemWidget({Key? key, required this.goodsData, required this.onSelected})
      : super(key: key);

  @override
  State<GoodItemWidget> createState() => _GoodItemWidget();
}

class _GoodItemWidget extends State<GoodItemWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = (size.width - 48) / 2;
    double height = ((size.width - 48) / 2 * (5 / 4));
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          widget.onSelected(widget.goodsData);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                width: width,
                height: height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // 둥근 정도를 나타내는 값
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
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.goodsData.brandNm}",
                        style: FontHelper.bold_12_000000),
                    const SizedBox(height: 6),
                    SizedBox(
                      child: Text(widget.goodsData.goodsNm,
                          style: ShownyStyle.caption(color: ShownyStyle.black)),
                    ),
                    const SizedBox(height: 6),
                    Text("${(widget.goodsData.goodsPrice).formatPrice()} 원",
                        style: FontHelper.bold_14_000000),
                    const SizedBox(height: 6),
                    Text("즉시 구매가",
                        style: ShownyStyle.caption(color: ShownyStyle.gray070)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          color: textColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text("${widget.goodsData.heartCount}",
                            style: ShownyStyle.caption(
                                color: ShownyStyle.gray070)),
                        const SizedBox(
                          width: 8,
                        ),
                        Image.asset(heartReport),
                        const SizedBox(
                          width: 4,
                        ),
                        Text("${widget.goodsData.reviewCount}",
                            style: ShownyStyle.caption(
                                color: ShownyStyle.gray070)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
