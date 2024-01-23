import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/widgets/common_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'store_good_detail_bottom_sheet.dart';

class StoreGoodDetailBottomWidget extends StatefulWidget {
  final StoreGoodModel goodsData;
  final Function selectHeart;

  const StoreGoodDetailBottomWidget({
    super.key,
    required this.goodsData,
    required this.selectHeart,
  });

  @override
  State<StoreGoodDetailBottomWidget> createState() =>
      _StoreGoodDetailBottomWidget();
}

class _StoreGoodDetailBottomWidget extends State<StoreGoodDetailBottomWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 80,
      color: white,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  widget.selectHeart();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.goodsData.isHeart == true
                        ? const Icon(
                            Icons.favorite,
                            color: black,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: black,
                          ),
                    Text(
                      widget.goodsData.heartCount.toString(),
                      style: FontHelper.regular_10_000000,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CommonButtonWidget(
                  height: 48,
                  radius: 8,
                  image: widget.goodsData.memberRequestLink != ""
                      ? Image.asset(
                          "assets/icons/purchase_link.png",
                          width: 24,
                          height: 24,
                        )
                      : null,
                  text: widget.goodsData.memberRequestLink != ""
                      ? "웹사이트로 보기"
                      : tr("store.details.purchase"),
                  color: black,
                  textcolor: white,
                  onTap: () async {
                    if (widget.goodsData.memberRequestLink != "") {
                      if (await canLaunchUrl(
                          Uri.parse(widget.goodsData.memberRequestLink))) {
                        await launchUrl(
                            Uri.parse(widget.goodsData.memberRequestLink));
                      } else {
                        throw 'Could not launch ${widget.goodsData.memberRequestLink}';
                      }
                    } else {
                      Size size = MediaQuery.of(context).size;
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext bc) {
                          return StoreGoodDetailBottomSheet(
                              goodsData: widget.goodsData);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Text(widget.goodsData.memberRequestLink,
              style: ShownyStyle.overline())
        ],
      ),
    );
  }
}
