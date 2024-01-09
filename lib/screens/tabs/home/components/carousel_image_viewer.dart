// import 'dart:io';
// import 'dart:math';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:showny/constants.dart';
// import 'package:showny/extension/ext_int.dart';
// import 'package:showny/models/goods_data.dart';
// import 'package:showny/screens/feed/widgets/drag_item_tag.dart';

// class CarouselImageViewer extends StatefulWidget {
//   const CarouselImageViewer({
//     super.key,
//     this.imgUrlList,
//     this.imgFileList,
//     this.showTags = false,
//     this.moveTags = false,
//     required this.goodsDataList,
//     this.primaryIndicatorColor = Colors.white,
//     this.onTap,
//     required this.onChangePageIndex,
//     required this.initIndex,
//   });

//   final bool showTags;
//   final bool moveTags;
//   final List<String>? imgUrlList;
//   final List<XFile>? imgFileList;

//   final List<List<GoodsData?>?> goodsDataList;
//   final Color primaryIndicatorColor;
//   final Function()? onTap;
//   final Function(int) onChangePageIndex;
//   final int initIndex;

//   @override
//   State<CarouselImageViewer> createState() => _CarouselImageViewerState();
// }

// class _CarouselImageViewerState extends State<CarouselImageViewer> {
//   late Size viewSize;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     currentIndex = widget.initIndex;
//     super.initState();
//   }

//   void changeIndex(int index) {
//     debugPrint("changeIndex");
//     setState(() {
//       currentIndex = index;
//       widget.onChangePageIndex(currentIndex);
//     });
//   }

//   Widget tagWidget(
//       {required String goodsNm, required String price, required String size}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
//       decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.6),
//           borderRadius: BorderRadius.circular(12.0)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             goodsNm,
//             style: Constants.defaultTextStyle.copyWith(fontSize: 12.0),
//           ),
//           const SizedBox(height: 2.0),
//           Text(
//             '$price 원',
//             style: Constants.defaultTextStyle.copyWith(
//               color: const Color(0xFF444444),
//               fontSize: 12.0,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           if (size != "") const SizedBox(height: 2.0),
//           if (size != "")
//             Text(
//               size,
//               style: Constants.defaultTextStyle.copyWith(
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.w700,
//               ),
//             )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: ((context, constraints) {
//       viewSize = Size(constraints.maxWidth, constraints.maxWidth * (6 / 4));
//       return CupertinoButton(
//         padding: EdgeInsets.zero,
//         onPressed: widget.onTap,
//         child: Stack(
//           children: [
//             if (widget.imgUrlList != null)
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   CarouselSlider(
//                     items: widget.imgUrlList!.map((img) {
//                       return Builder(builder: (context) {
//                         return Container(
//                           color: Colors.grey.withOpacity(0.5),
//                           width: viewSize.width,
//                           height: viewSize.height,
//                           child: Image.network(img, fit: BoxFit.cover),
//                         );
//                       });
//                     }).toList(),
//                     options: CarouselOptions(
//                       aspectRatio: 1 / (6 / 4),
//                       viewportFraction: 1,
//                       enableInfiniteScroll: false,
//                       onPageChanged: (index, reason) {
//                         changeIndex(index);
//                       },
//                     ),
//                   ),
//                   if (widget.imgUrlList!.length > 1)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: widget.imgUrlList!.asMap().entries.map((entry) {
//                         return Container(
//                           width: 8.0,
//                           height: 8.0,
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 16.0, horizontal: 4.0),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(
//                                 currentIndex == entry.key ? 1.0 : 0.3),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                 ],
//               )
//             else if (widget.imgFileList != null)
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   CarouselSlider(
//                     items: widget.imgFileList!.map((img) {
//                       return Builder(builder: (context) {
//                         return Container(
//                           color: Colors.grey.withOpacity(0.5),
//                           width: viewSize.width,
//                           height: viewSize.height,
//                           child: Stack(
//                             children: [
//                               SizedBox(
//                                 width: viewSize.width,
//                                 height: viewSize.height,
//                                 child: Image.file(File(img.path),
//                                     fit: BoxFit.cover),
//                               ),
//                               if (widget.showTags)
//                                 for (int i = 0;
//                                     i <
//                                         widget.goodsDataList[currentIndex]!
//                                             .length;
//                                     i++)
//                                   (widget.goodsDataList[currentIndex]![i] !=
//                                           null)
//                                       ? DraggableTag(
//                                           goodsNm: widget
//                                                   .goodsDataList[currentIndex]
//                                                       ?[i]!
//                                                   .brandNm ??
//                                               "",
//                                           price:
//                                               '${(widget.goodsDataList[currentIndex]?[i]!.goodsPrice ?? 0).formatPrice()} 원',
//                                           size: (widget
//                                                           .goodsDataList[
//                                                               currentIndex]?[i]!
//                                                           .options !=
//                                                       null &&
//                                                   widget
//                                                           .goodsDataList[
//                                                               currentIndex]?[i]!
//                                                           .options!
//                                                           .isNotEmpty ==
//                                                       true)
//                                               ? '${widget.goodsDataList[currentIndex]?[i]!.options![0][0].value}'
//                                               : '',
//                                           goodsData: widget
//                                               .goodsDataList[currentIndex]![i]!,
//                                           viewSize: viewSize,
//                                           moveTags: widget.moveTags,
//                                           onChangePosition: (offset) {
//                                             RenderBox renderBox =
//                                                 context.findRenderObject()
//                                                     as RenderBox;
//                                             int viewWidth =
//                                                 renderBox.size.width.toInt();
//                                             int viewHeight =
//                                                 renderBox.size.height.toInt();

//                                             widget
//                                                     .goodsDataList[currentIndex]
//                                                         ?[i]!
//                                                     .left =
//                                                 double.parse(
//                                                     ((offset.dx / viewWidth))
//                                                         .toStringAsFixed(3));
//                                             widget
//                                                     .goodsDataList[currentIndex]
//                                                         ?[i]!
//                                                     .top =
//                                                 double.parse(
//                                                     ((offset.dy / viewHeight))
//                                                         .toStringAsFixed(3));

//                                             debugPrint(
//                                                 'left ${widget.goodsDataList[currentIndex]?[i]!.left}');
//                                             debugPrint(
//                                                 'top ${widget.goodsDataList[currentIndex]?[i]!.top}');
//                                           },
//                                         )
//                                       : const SizedBox(),
//                             ],
//                           ),
//                         );
//                       });
//                     }).toList(),
//                     options: CarouselOptions(
//                       aspectRatio: 1 / (6 / 4),
//                       viewportFraction: 1,
//                       enableInfiniteScroll: false,
//                       onPageChanged: (index, reason) {
//                         changeIndex(index);
//                       },
//                     ),
//                   ),
//                   if (widget.imgFileList!.length > 1)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children:
//                           widget.imgFileList!.asMap().entries.map((entry) {
//                         return Container(
//                           width: 8.0,
//                           height: 8.0,
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 16.0, horizontal: 4.0),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: currentIndex == entry.key
//                                 ? widget.primaryIndicatorColor
//                                 : const Color(0xFFD9D9D9),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                 ],
//               ),
//           ],
//         ),
//       );
//     }));
//   }
// }
