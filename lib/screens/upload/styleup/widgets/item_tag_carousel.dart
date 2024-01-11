import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showny/constants.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/screens/home/widgets/drag_item_tag.dart';

class ItemTagCarouselImageViewer extends StatefulWidget {
  const ItemTagCarouselImageViewer({
    super.key,
    this.imgFileList,
    this.onTap,
    required this.goodsDataList,
    required this.onChangePageIndex,
    required this.initIndex,
  });

  final List<XFile>? imgFileList;
  final Function()? onTap;
  final List<List<StoreGoodModel?>?> goodsDataList;
  final Function(int) onChangePageIndex;
  final int initIndex;

  @override
  State<ItemTagCarouselImageViewer> createState() =>
      _ItemTagCarouselImageViewerState();
}

class _ItemTagCarouselImageViewerState
    extends State<ItemTagCarouselImageViewer> {
  late Size viewSize;
  int currentIndex = 0;
  // List<List<StoreGoodModel?>?> goodsDataList = [];

  @override
  void initState() {
    currentIndex = widget.initIndex;
    // goodsDataList = widget.goodsDataList;
    super.initState();
  }

  void changeIndex(int index) {
    debugPrint("changeIndex");
    setState(() {
      currentIndex = index;
      widget.onChangePageIndex(currentIndex);
    });
  }

  Widget tagWidget(
      {required String goodsNm, required String price, required String size}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goodsNm,
            style: Constants.defaultTextStyle.copyWith(fontSize: 12.0),
          ),
          const SizedBox(height: 2.0),
          Text(
            '$price 원',
            style: Constants.defaultTextStyle.copyWith(
              color: const Color(0xFF444444),
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (size != "") const SizedBox(height: 2.0),
          if (size != "")
            Text(
              size,
              style: Constants.defaultTextStyle.copyWith(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      viewSize = Size(constraints.maxWidth, constraints.maxWidth * (5 / 4));
      return Stack(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                items: widget.imgFileList!.map((img) {
                  return Builder(builder: (context) {
                    return Container(
                      color: Colors.grey.withOpacity(0.5),
                      width: viewSize.width,
                      height: viewSize.height,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: widget.onTap,
                            child: SizedBox(
                              width: viewSize.width,
                              height: viewSize.height,
                              child:
                                  Image.file(File(img.path), fit: BoxFit.cover),
                            ),
                          ),
                          for (int i = 0;
                              i < widget.goodsDataList[currentIndex]!.length;
                              i++)
                            (widget.goodsDataList[currentIndex]![i] != null)
                                ? DraggableTag(
                                    goodsNm: widget
                                            .goodsDataList[currentIndex]?[i]!
                                            .brandNm ??
                                        "",
                                    price:
                                        '${(widget.goodsDataList[currentIndex]?[i]!.goodsPrice ?? 0).formatPrice()} 원',
                                    size: (widget
                                                    .goodsDataList[currentIndex]
                                                        ?[i]!
                                                    .optionList !=
                                                null &&
                                            widget
                                                    .goodsDataList[currentIndex]
                                                        ?[i]!
                                                    .optionList
                                                    .isNotEmpty ==
                                                true)
                                        ? '${widget.goodsDataList[currentIndex]?[i]!.optionList[0].name}'
                                        : '',
                                    goodsData:
                                        widget.goodsDataList[currentIndex]![i]!,
                                    viewSize: viewSize,
                                    moveTags: true,
                                    onChangePosition: (offset) {
                                      RenderBox renderBox = context
                                          .findRenderObject() as RenderBox;
                                      int viewWidth =
                                          renderBox.size.width.toInt();
                                      int viewHeight =
                                          renderBox.size.height.toInt();

                                      widget.goodsDataList[currentIndex]?[i]!
                                              .left =
                                          double.parse(((offset.dx / viewWidth))
                                              .toStringAsFixed(3));
                                      widget.goodsDataList[currentIndex]?[i]!
                                          .top = double.parse(((offset.dy /
                                              viewHeight))
                                          .toStringAsFixed(3));

                                      debugPrint(
                                          'left ${widget.goodsDataList[currentIndex]?[i]!.left}');
                                      debugPrint(
                                          'top ${widget.goodsDataList[currentIndex]?[i]!.top}');
                                    },
                                  )
                                : const SizedBox(),
                        ],
                      ),
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                  aspectRatio: 1 / (5 / 4),
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    changeIndex(index);
                  },
                ),
              ),
              // if (widget.imgFileList!.length > 1)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children:
              //         widget.imgFileList!.asMap().entries.map((entry) {
              //       return Container(
              //         width: 8.0,
              //         height: 8.0,
              //         margin: const EdgeInsets.symmetric(
              //             vertical: 16.0, horizontal: 4.0),
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: currentIndex == entry.key
              //               ? widget.primaryIndicatorColor
              //               : const Color(0xFFD9D9D9),
              //         ),
              //       );
              //     }).toList(),
              //   ),
            ],
          ),
        ],
      );
    }));
  }
}
