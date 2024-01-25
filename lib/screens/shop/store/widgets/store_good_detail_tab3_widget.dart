import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:showny/utils/showny_style.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/goods_qna_list_response_model.dart';
import '../store_inquiry_screen.dart';

class StoreGoodDetailTab3Widget extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailTab3Widget({
    super.key,
    required this.goodsData,
  });

  @override
  State<StoreGoodDetailTab3Widget> createState() =>
      _StoreGoodDetailTab3Widget();
}

class _StoreGoodDetailTab3Widget extends State<StoreGoodDetailTab3Widget> {
  GoodsQnaListResponseModel? goodsQnaListResponseModel;
  int currentPageGroup = 0;
  int currentPageIndex = 0;

  List<bool> expaendList = List.filled(5, false);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getGoodQnaList();
    });
  }

  getGoodQnaList() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String memNo = user.memNo;

    ApiHelper.shared
        .getStoreGoodsQnaList(memNo, widget.goodsData.goodsNo, currentPageIndex,
            (getStoreGoodsQnaListModel) {
      if (mounted) {
        setState(() {
          goodsQnaListResponseModel = getStoreGoodsQnaListModel;
        });
      }
    }, (error) {});
  }

  void initIndex() {
    setState(() {
      expaendList = List.filled(5, false);
    });
  }

  void toggleExpandedIndex(int index) {
    setState(() {
      // if(goodsQnaListResponseModel!.qaList[index].replyStatus == "1") {
      //   expaendList[index] = false;
      // } else {
      expaendList[index] = !expaendList[index];
      // }
    });
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

    return goodsQnaListResponseModel == null
        ? const SizedBox()
        : Column(
            children: [
              SizedBox(
                height: 64,
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              "${tr("store.details.product_inquiry")}(${goodsQnaListResponseModel!.qaCount})",
                              style: FontHelper.bold_12_000000),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  ShownyPageRoute(
                                    builder: (context) => StoreInquiryScreen(
                                      goodsData: widget.goodsData,
                                      onComplete: () {
                                        currentPageGroup = 0;
                                        currentPageIndex = 0;
                                        getGoodQnaList();
                                      },
                                    ),
                                  ));
                            },
                            child: Text(tr("store.details.contactUs"),
                                style: FontHelper.bold_12_000000),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFEEEEEE),
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: goodsQnaListResponseModel!.qaList.length > 5
                    ? 5
                    : goodsQnaListResponseModel!.qaList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  String originalDateTimeString =
                      goodsQnaListResponseModel!.qaList[index].regDt;
                  DateTime originalDateTime =
                      DateTime.parse(originalDateTimeString);
                  String formattedDate =
                      "${originalDateTime.year}-${originalDateTime.month}-${originalDateTime.day}";

                  String name = goodsQnaListResponseModel!.qaList[index].nickNm;
                  if (name.length <= 2) {
                    name = name.replaceRange(name.length - 1, name.length, '*');
                  } else if (name.length <= 3) {
                    name =
                        name.replaceRange(name.length - 2, name.length, '**');
                  } else {
                    name =
                        name.replaceRange(name.length - 3, name.length, '***');
                  }

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          toggleExpandedIndex(index);
                        },
                        child: Container(
                          height: 48,
                          color: white,
                          child: Column(
                            children: [
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: goodsQnaListResponseModel!
                                                .qaList[index].replyStatus ==
                                            "1"
                                        ? Text(
                                            "답변 대기",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: ShownyStyle.caption(),
                                          )
                                        : Text(
                                            "답변 완료",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: ShownyStyle.caption(),
                                          ),
                                  ),
                                  goodsQnaListResponseModel!
                                              .qaList[index].isSecret ==
                                          "y"
                                      ? const Icon(
                                          Icons.lock_outline,
                                          color: greyLight,
                                          size: 16,
                                        )
                                      : const SizedBox(
                                          width: 18,
                                        ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      goodsQnaListResponseModel!
                                          .qaList[index].subject,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: ShownyStyle.caption(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: ShownyStyle.overline(),
                                        ),
                                        Text(
                                          name,
                                          style: ShownyStyle.overline(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: expaendList[index] == true
                                    ? Colors.black
                                    : const Color(0xFFEEEEEE),
                              ),
                            ],
                          ),
                        ),
                      ),
                      expaendList[index] == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: greyExtraLight),
                                        child: Image.network(
                                          widget.goodsData.goodsImageUrlList[0],
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.black12,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.goodsData.goodsNm,
                                            style: ShownyStyle.overline()),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  goodsQnaListResponseModel!
                                      .qaList[index].contents,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: ShownyStyle.caption(),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFFEEEEEE),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                goodsQnaListResponseModel!
                                            .qaList[index].answerSubject !=
                                        "비밀글"
                                    ? Text(
                                        goodsQnaListResponseModel!
                                            .qaList[index].answerSubject,
                                        style: ShownyStyle.caption(),
                                      )
                                    : const SizedBox(),
                                goodsQnaListResponseModel!
                                            .qaList[index].answerSubject !=
                                        "비밀글"
                                    ? const SizedBox(
                                        height: 4,
                                      )
                                    : const SizedBox(),
                                Text(
                                  extractTextFromHtml(goodsQnaListResponseModel!
                                      .qaList[index].answerContents),
                                  style: ShownyStyle.caption(),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFF000000),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
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
                              initIndex();
                              getGoodQnaList();
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
                                  goodsQnaListResponseModel!.qaCount / 5
                              ? 4
                              : ((goodsQnaListResponseModel!.qaCount / 5)
                                      .ceil()) %
                                  4, (index) {
                        int page = currentPageGroup * 4 + index + 1;
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPageIndex = index;
                                initIndex();
                                getGoodQnaList();
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
                                (goodsQnaListResponseModel!.qaCount / 5 / 4)
                                    .ceil();
                            currentPageGroup = currentPageGroup + 1;
                            if (currentPageGroup == maxPageGroup) {
                              currentPageGroup = maxPageGroup - 1;
                            } else {
                              currentPageIndex = 0;
                              initIndex();
                              getGoodQnaList();
                            }
                          });
                        },
                        icon: Image.asset(arrowForward, height: 16, width: 16),
                        disabledColor: Colors.grey,
                      ),
                    ],
                  )),
              const SizedBox(height: 16),
              const Divider(thickness: 8, color: greyExtraLight),
            ],
          );
  }
}
