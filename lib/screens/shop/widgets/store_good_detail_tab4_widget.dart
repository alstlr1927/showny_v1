import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:showny/utils/showny_style.dart';

import '../../../api/new_api/api_helper.dart';

class StoreGoodDetailTab4Widget extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailTab4Widget({
    super.key,
    required this.goodsData,
  });

  @override
  State<StoreGoodDetailTab4Widget> createState() =>
      _StoreGoodDetailTab4Widget();
}

class _StoreGoodDetailTab4Widget extends State<StoreGoodDetailTab4Widget> {
  GoodsReviewListResponseModel? goodsReviewListResponseModel;
  int currentPageGroup = 0;
  int currentPageIndex = 0;

  var isExpanded_0 = false;
  var isExpanded_1 = false;
  var isExpanded_2 = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getGoodReviewList();
    });
  }

  void toggleExpanded_0() {
    setState(() {
      isExpanded_0 = !isExpanded_0;
    });
  }

  void toggleExpanded_1() {
    setState(() {
      isExpanded_1 = !isExpanded_1;
    });
  }

  void toggleExpanded_2() {
    setState(() {
      isExpanded_2 = !isExpanded_2;
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              toggleExpanded_0();
            },
            child: Container(
              height: 40,
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "배송/교환/반품 안내",
                    style: ShownyStyle.caption(),
                  ),
                  isExpanded_0 == true
                      ? Image.asset(
                          arrowDown,
                          height: 16,
                          width: 16,
                          color: grey444,
                        )
                      : Image.asset(
                          arrowDownIcon,
                          height: 16,
                          width: 16,
                          color: grey444,
                        )
                ],
              ),
            ),
          ),
          isExpanded_0 == true
              ? Column(
                  children: [
                    Html(
                      data: """
                      <div style="font-size: 12px;">
                        ${widget.goodsData.productGuideInfo}
                      </div>
                    """,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                )
              : const Divider(
                  height: 1,
                  thickness: 1,
                  color: greyExtraLight,
                ),
          GestureDetector(
            onTap: () {
              toggleExpanded_1();
            },
            child: Container(
              height: 40,
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "상품 고시 정보",
                    style: ShownyStyle.caption(),
                  ),
                  isExpanded_1 == true
                      ? Image.asset(
                          arrowDown,
                          height: 16,
                          width: 16,
                          color: grey444,
                        )
                      : Image.asset(
                          arrowDownIcon,
                          height: 16,
                          width: 16,
                          color: grey444,
                        )
                ],
              ),
            ),
          ),
          isExpanded_1 == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemCount: widget.goodsData.productNoticeInfo.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => SizedBox(
                        height: 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.goodsData.productNoticeInfo[index].values
                                  .first,
                              style: ShownyStyle.caption(),
                            ),
                            SizedBox(width: size.width - 280),
                            Flexible(
                              child: Text(
                                widget.goodsData.productNoticeInfo[index].values
                                    .last,
                                style: ShownyStyle.caption(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Divider(
                      thickness: 1,
                      color: greyExtraLight,
                    ),
                  ],
                )
              : const Divider(
                  height: 1,
                  thickness: 1,
                  color: greyExtraLight,
                ),
          GestureDetector(
            onTap: () {
              toggleExpanded_2();
            },
            child: Container(
              height: 40,
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "판매자 정보",
                    style: ShownyStyle.caption(),
                  ),
                  isExpanded_2 == true
                      ? Image.asset(
                          arrowDown,
                          height: 16,
                          width: 16,
                          color: grey444,
                        )
                      : Image.asset(
                          arrowDownIcon,
                          height: 16,
                          width: 16,
                          color: grey444,
                        )
                ],
              ),
            ),
          ),
          isExpanded_2 == true
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ListView.builder(
                    itemCount: widget.goodsData.sellerInfo.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.goodsData.sellerInfo[index].values.first,
                            style: ShownyStyle.caption(),
                          ),
                          SizedBox(width: size.width - 280),
                          Flexible(
                            child: Text(
                              widget.goodsData.sellerInfo[index].values.last,
                              style: ShownyStyle.caption(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ])
              : const Divider(
                  height: 1,
                  thickness: 1,
                  color: greyExtraLight,
                ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
