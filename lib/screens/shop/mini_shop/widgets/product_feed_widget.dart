import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/utils/showny_style.dart';

import '../../../../../../../utils/theme.dart';
import '../../../../api/new_api/api_helper.dart';
import '../../../home/styleup/styleup_screen.dart';

class ProductFeedWidget extends StatefulWidget {
  final MinishopProductModel minishopProduct;

  const ProductFeedWidget({
    Key? key,
    required this.minishopProduct,
  }) : super(key: key);

  @override
  State<ProductFeedWidget> createState() => _ProductFeedWidgetState();
}

class _ProductFeedWidgetState extends State<ProductFeedWidget> {
  List<StyleupModel> stlyeupList = [];

  @override
  void initState() {
    super.initState();

    ApiHelper.shared.getProfileStyleupList(widget.minishopProduct.memNo, 1, 0,
        (getStyleupList) {
      setState(() {
        stlyeupList.addAll(getStyleupList);
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
                      "${widget.minishopProduct.userInfo!.nickNm}${tr('product_detail.seller_feed.headline')}",
                      style: themeData().textTheme.bodyMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (stlyeupList.isNotEmpty) {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => StyleupScreen(
                                isMain: false,
                                initIndex: 0,
                                styleupList: stlyeupList,
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
            height: (130 * (5 / 4)) + 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stlyeupList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        ShownyPageRoute(
                          builder: (context) => StyleupScreen(
                            isMain: false,
                            initIndex: index,
                            styleupList: stlyeupList,
                          ),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 130,
                      height: (130 * (5 / 4)) + 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Image.network(
                              stlyeupList[index].thumbnailUrl,
                              width: 130,
                              height: (130 * (5 / 4)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height:
                                stlyeupList[index].description != "" ? 8 : 0,
                          ),
                          SizedBox(
                            height:
                                stlyeupList[index].description != "" ? null : 0,
                            child: Text(
                              stlyeupList[index].description,
                              style: FontHelper.regular_10_000000,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                '${tr('product_detail.seller_feed.like')} ${stlyeupList[index].heartCnt}',
                                style: ShownyStyle.caption(),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${tr('product_detail.seller_feed.comments')} ${stlyeupList[index].commentCnt}',
                                style: ShownyStyle.caption(),
                              ),
                            ],
                          ),
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
