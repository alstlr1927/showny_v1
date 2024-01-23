import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/color_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:showny/utils/showny_style.dart';

import '../../../api/new_api/api_helper.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return goodsReviewListResponseModel == null
        ? const SizedBox()
        : Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                          "${goodsReviewListResponseModel!.reviewCount} 개의 후기",
                          style: FontHelper.bold_12_000000),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: goodsReviewListResponseModel!.reviewList.length > 5
                    ? 5
                    : goodsReviewListResponseModel!.reviewList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            goodsReviewListResponseModel!
                                .reviewList[index].userInfo.profileImage),
                        backgroundColor: ColorHelper.placeholderColor,
                        radius: 12,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                                goodsReviewListResponseModel!
                                    .reviewList[index].userInfo.memNm,
                                style: ShownyStyle.overline()),
                            const SizedBox(height: 8),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Image.network(
                                        widget.goodsData.goodsImageUrlList[0],
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover, errorBuilder:
                                            (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.white,
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.goodsData.goodsNm,
                                          maxLines: 2,
                                          style: ShownyStyle.overline()),
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
                                const Icon(
                                  Icons.star,
                                  color: greyLight,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  goodsReviewListResponseModel!
                                      .reviewList[index].goodsPt,
                                  style: ShownyStyle.overline(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              child: Text(
                                extractTextFromHtml(
                                    goodsReviewListResponseModel!
                                        .reviewList[index].subject),
                                style: FontHelper.regular_10_000000,
                              ),
                            ),
                            if (index < 4)
                              const SizedBox(
                                height: 16,
                              )
                          ],
                        ),
                      ),
                    ],
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
                              currentPageIndex = 0;
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
                                      ? FontHelper.regular_10_000000
                                      : ShownyStyle.overline(),
                                ),
                              ),
                            ));
                      }),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            int maxPageGroup =
                                (goodsReviewListResponseModel!.reviewCount /
                                        5 /
                                        4)
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
