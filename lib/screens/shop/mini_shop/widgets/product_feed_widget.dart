import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

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

  bool isLoading = false;

  void setIsLoading(bool val) {
    isLoading = val;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setIsLoading(true);
    ApiHelper.shared.getProfileStyleupList(widget.minishopProduct.memNo, 1, 0,
        (getStyleupList) {
      setState(() {
        stlyeupList.addAll(getStyleupList);
      });
      setIsLoading(false);
    }, (error) {
      stlyeupList.clear();
      setIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: ShownyStyle.defaultBottomPadding(),
          top: 30.toWidth,
        ),
        child: ShownyIndicator(
          color: ShownyStyle.mainPurple,
          radius: 15,
        ),
      );
    }
    if (stlyeupList.isEmpty) {
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        FeedSectionHeader(size: size, widget: widget, stlyeupList: stlyeupList),
        const SizedBox(height: 16),
        // SizedBox(
        //   width: size.width,
        //   height: (130 * (5 / 4)) + 90,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: stlyeupList.length,
        //     separatorBuilder: (context, index) => SizedBox(width: 8.toWidth),
        //     itemBuilder: (context, index) {
        //       return FeedItem(
        //         stlyeupList: stlyeupList,
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
              stlyeupList.length,
              (index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: index < stlyeupList.length - 1 ? 8.toWidth : 0),
                  child: FeedItem(
                    stlyeupList: stlyeupList,
                    index: index,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 56,
        ),
      ],
    );
  }
}

class FeedSectionHeader extends StatelessWidget {
  const FeedSectionHeader({
    super.key,
    required this.size,
    required this.widget,
    required this.stlyeupList,
  });

  final Size size;
  final ProductFeedWidget widget;
  final List<StyleupModel> stlyeupList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: 24,
                child: Text(
                  "${widget.minishopProduct.userInfo!.nickNm}${tr('product_detail.seller_feed.headline')}",
                  style: ShownyStyle.body2(
                    color: ShownyStyle.black,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
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
              child: SizedBox(
                height: 24,
                child: Center(
                  child: Text(
                    tr('product_detail.seller_feed.see_more'),
                    style: ShownyStyle.caption(
                      color: Color(0xFF777777),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedItem extends StatelessWidget {
  final int index;
  const FeedItem({
    super.key,
    required this.stlyeupList,
    required this.index,
  });

  final List<StyleupModel> stlyeupList;

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        width: 130,
        margin: EdgeInsets.only(
          left: index == 0 ? 16 : 0,
          right: index == stlyeupList.length - 1 ? 16 : 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.network(
                stlyeupList[index].thumbnailUrl,
                width: 130,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: stlyeupList[index].description != "" ? 8 : 0,
            ),
            SizedBox(
              height: stlyeupList[index].description != "" ? null : 0,
              child: Text(
                stlyeupList[index].description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: ShownyStyle.overline(
                  color: black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${tr('product_detail.seller_feed.like')} ${stlyeupList[index].heartCnt}',
                  style: ShownyStyle.overline(
                    color: Color(0xFF777777),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '${tr('product_detail.seller_feed.comments')} ${stlyeupList[index].commentCnt}',
                  style: ShownyStyle.overline(
                    color: Color(0xFF777777),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
