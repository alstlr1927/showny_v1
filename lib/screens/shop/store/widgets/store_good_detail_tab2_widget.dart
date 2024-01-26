import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/helper/color_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/goods_review_list_response_model.dart';
import '../../../../models/goods_review_model.dart';

class StoreGoodDetailTab2Widget extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailTab2Widget({
    super.key,
    required this.goodsData,
  });

  @override
  State<StoreGoodDetailTab2Widget> createState() =>
      _StoreGoodDetailTab2Widget();
}

class _StoreGoodDetailTab2Widget extends State<StoreGoodDetailTab2Widget> {
  GoodsReviewListResponseModel? goodsReviewListResponseModel;
  int currentPageGroup = 0;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getGoodReviewList();
    });
  }

  getGoodReviewList() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String memNo = user.memNo;

    ApiHelper.shared.getStoreGoodsReviewList(
        memNo, widget.goodsData.goodsNo, currentPageIndex,
        (getStoreGoodsReviewListModel) {
      if (mounted) {
        setState(() {
          goodsReviewListResponseModel = getStoreGoodsReviewListModel;
        });
      }
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    if (goodsReviewListResponseModel == null) {
      return SizedBox();
    }
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 6),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.toWidth),
                child: Text(
                  "${goodsReviewListResponseModel!.reviewCount} 개의 후기",
                  style: ShownyStyle.caption(weight: FontWeight.bold),
                ),
              ),
              const Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          itemCount: goodsReviewListResponseModel!.reviewList.length > 5
              ? 5
              : goodsReviewListResponseModel!.reviewList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _ReviewListItem(
              goodsData: widget.goodsData,
              reviewItem: goodsReviewListResponseModel!.reviewList[index],
              index: index,
            );
          },
        ),
        const SizedBox(height: 24),
        SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentPageGroup = currentPageGroup - 1;
                      if (currentPageGroup < 0) {
                        currentPageGroup = 0;
                      } else {
                        ShownyLog().e('i : ${currentPageGroup}');
                        getGoodReviewList();
                      }
                    });
                  },
                  icon: Image.asset(
                    arrowBackward,
                    height: 16,
                    width: 16,
                  ),
                  disabledColor: Colors.grey,
                ),
                const Spacer(),
                ...List.generate(
                    (currentPageGroup + 1) * 4 <
                            goodsReviewListResponseModel!.reviewCount / 5
                        ? 4
                        : ((goodsReviewListResponseModel!.reviewCount / 5)
                                .ceil()) %
                            4, (index) {
                  int page = currentPageGroup * 4 + index + 1;
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPageIndex = index;
                          getGoodReviewList();
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: 48,
                        height: 40,
                        child: Center(
                          child: Text(
                            '$page',
                            style: currentPageIndex == index
                                ? ShownyStyle.overline()
                                : ShownyStyle.overline(
                                    color: Color(0xff777777)),
                          ),
                        ),
                      ));
                }),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      int maxPageGroup =
                          (goodsReviewListResponseModel!.reviewCount / 5 / 4)
                              .ceil();
                      currentPageGroup = currentPageGroup + 1;
                      if (currentPageGroup == maxPageGroup) {
                        currentPageGroup = maxPageGroup - 1;
                      } else {
                        currentPageIndex = 0;
                        getGoodReviewList();
                      }
                    });
                  },
                  icon: Image.asset(arrowForward, height: 16, width: 16),
                  disabledColor: Colors.grey,
                ),
              ],
            )),
        const SizedBox(height: 24),
        const Divider(thickness: 8, color: greyExtraLight),
      ],
    );
  }
}

class _ReviewListItem extends StatefulWidget {
  final int index;
  final GoodsReviewModel reviewItem;
  final StoreGoodModel goodsData;
  const _ReviewListItem({
    Key? key,
    required this.reviewItem,
    required this.goodsData,
    required this.index,
  }) : super(key: key);

  @override
  State<_ReviewListItem> createState() => __ReviewListItemState();
}

class __ReviewListItemState extends State<_ReviewListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileContainer.size24(
          url: widget.reviewItem.userInfo.profileImage,
        ),
        SizedBox(width: 6.toWidth),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(widget.reviewItem.userInfo.memNm,
                  style: ShownyStyle.overline(weight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 40.toWidth,
                      width: 40.toWidth,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Image.network(
                          widget.goodsData.goodsImageUrlList[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white,
                        );
                      }),
                    ),
                  ),
                  SizedBox(width: 8.toWidth),
                  SizedBox(
                    height: 40.toWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.goodsData.goodsNm,
                          maxLines: 2,
                          style: ShownyStyle.overline(color: Color(0xff777777)),
                        ),
                        // SizedBox(
                        //   height: size.height * 0.006,
                        // ),
                        // Text(
                        //   "${storeProductDetailProvider.getStoreGoodsReviewModel!.data!.reviewList![index].userInfo!.colorIdList!}",
                        //   style: themeData()
                        //       .textTheme
                        //       .headlineSmall,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/shop/grade_gray.png',
                    width: 12.toWidth,
                  ),
                  SizedBox(width: 4.toWidth),
                  Text(
                    widget.reviewItem.goodsPt,
                    style: ShownyStyle.overline(color: Color(0xff777777)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ReadMoreText(
                extractTextFromHtml(widget.reviewItem.subject),
                trimLines: 3,
                style: ShownyStyle.overline(),
                trimCollapsedText: '더보기',
                trimExpandedText: '    닫기',
                trimMode: TrimMode.Line,
                moreStyle: ShownyStyle.overline(color: Color(0xff777777)),
                lessStyle: ShownyStyle.overline(color: Color(0xff777777)),
              ),
              if (widget.index < 4)
                const SizedBox(
                  height: 16,
                )
            ],
          ),
        ),
      ],
    );
  }

  // HTML에서 텍스트를 추출하는 함수
  String extractTextFromHtml(String html) {
    final document = html_parser.parse(html);
    final buffer = StringBuffer();

    void extractText(html_dom.Node node) {
      if (node is html_dom.Text) {
        buffer.write(node.text);
      } else if (node is html_dom.Element) {
        for (final child in node.nodes) {
          extractText(child);
        }
      }
    }

    extractText(document.body!);

    return buffer.toString();
  }
}
