import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/upload/styleup/providers/styleup_item_tag_provider.dart';
import 'package:showny/screens/upload/styleup/types/item_category.dart';
import 'package:showny/screens/upload/styleup/widgets/add_item_button.dart';
import 'package:showny/screens/upload/styleup/widgets/item_tag_carousel.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../shop/store/store_search_page_screen.dart';

class StyleupItemTag extends StatefulWidget {
  final String type;
  final List<List<StoreGoodModel?>?> goodsDataList;
  final Function(List<List<StoreGoodModel?>?>?) onCompleted;
  final List<XFile> imgFileList;

  const StyleupItemTag({
    super.key,
    required this.type,
    required this.goodsDataList,
    required this.onCompleted,
    this.imgFileList = const [],
  });

  @override
  State<StyleupItemTag> createState() => _StyleupItemTagState();
}

class _StyleupItemTagState extends State<StyleupItemTag> {
  late StyleupItemTagProvider provider;

  @override
  void initState() {
    super.initState();
    provider = StyleupItemTagProvider(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StyleupItemTagProvider>.value(
        value: provider,
        builder: (context, _) {
          return Consumer<StyleupItemTagProvider>(
              builder: (context, prov, child) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('아이템 태그'),
                scrolledUnderElevation: 0,
                actions: [
                  ShownyButton(
                    onPressed: () {
                      widget.onCompleted(prov.goodsDataList);
                      Navigator.pop(context);
                    },
                    option: ShownyButtonOption.text(
                      text: '완료',
                      theme: ShownyButtonTextTheme.black,
                      style: ShownyButtonTextStyle.regular,
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 24.toWidth),
                    if (widget.type == 'img') ...{
                      _buildImageArea(),
                    } else ...{
                      _buildVideoArea(),
                    },
                    SizedBox(height: 24.toWidth),
                    _buildTagItemList(),
                    SizedBox(height: ShownyStyle.defaultBottomPadding())
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget _buildImageArea() {
    return Builder(builder: (context) {
      StyleupItemTagProvider itemProv =
          Provider.of<StyleupItemTagProvider>(context, listen: false);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Column(
          children: [
            ItemTagCarouselImageViewer(
              imgFileList: widget.imgFileList,
              goodsDataList: itemProv.goodsDataList,
              initIndex: 0,
              onChangePageIndex: itemProv.imgIndexChange,
              onTap: itemProv.showItemTagSheet,
            ),
            if (widget.imgFileList.length > 1) ...{
              Consumer<StyleupItemTagProvider>(builder: (context, prov, child) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imgFileList.asMap().entries.map((entry) {
                      return Container(
                        width: 8.toWidth,
                        height: 8.toWidth,
                        margin: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: prov.imgIdx == entry.key
                              ? ShownyStyle.black
                              : const Color(0xffd9d9d9),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            }
          ],
        ),
      );
    });
  }

  Widget _buildVideoArea() {
    return Builder(builder: (context) {
      StyleupItemTagProvider itemProv =
          Provider.of<StyleupItemTagProvider>(context, listen: false);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.file(
                File(widget.imgFileList.first.path),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24.toWidth),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...ItemCategory.values.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final ItemCategory category = entry.value;
                    return AddItemButton(
                      category: category,
                      goodsData:
                          itemProv.goodsDataList[itemProv.imgIdx]![index],
                      onSelected: () {
                        itemProv.onClickAddItemBox(index);
                      },
                    );
                  }).toList(),
                  const SizedBox(width: 12.0),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTagItemList() {
    return Consumer<StyleupItemTagProvider>(builder: (context, prov, child) {
      List<StoreGoodModel?> tagList = prov.goodsDataList[prov.imgIdx]!;
      bool isEmpty = true;
      for (var i in tagList) {
        if (i != null) {
          isEmpty = false;
          break;
        }
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Column(
          children: [
            if (!isEmpty) ...{
              ...List.generate(tagList.length, (index) {
                if (tagList[index] == null) {
                  return Container();
                }

                return _tagListItem(
                  category: ItemCategory.values[index].name,
                  tag: tagList[index]!,
                  index: index,
                );
              }).superJoin(Container(
                height: 10.toWidth,
              )),
            } else ...{
              SizedBox(height: 20.toWidth),
              Text(
                '아이템을 클릭 후 검색하여 사용하세요',
                style: ShownyStyle.body2(
                    color: ShownyStyle.black, weight: FontWeight.w500),
              ),
            },
          ],
        ),
      );
      // return ListView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   itemCount: widget.goodsDataList[prov.imgIdx]!.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     debugPrint(
      //         (widget.goodsDataList[prov.imgIdx]![index] == null).toString());
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: widget.goodsDataList[prov.imgIdx]![index] != null
      //           ? ItemTagListItem(
      //               goodsData: widget.goodsDataList[prov.imgIdx]![index]!,
      //               deleteSelect: () {
      //                 var completeDialog = ShownyDialog(
      //                   message: "선택된 상품을 삭제하시겠습니까?",
      //                   primaryLabel: "취소",
      //                   primaryAction: () {},
      //                   secondaryLabel: "삭제",
      //                   secondaryAction: () {
      //                     prov.setStoreGoodModel(null, index);
      //                   },
      //                 );
      //                 showDialog(
      //                   barrierColor: Colors.black.withOpacity(0.4),
      //                   context: context,
      //                   builder: (context) => completeDialog,
      //                 );
      //               },
      //             )
      //           : const SizedBox(),
      //     );
      // },
      // );
    });
  }

  Widget _tagListItem({
    required String category,
    required StoreGoodModel tag,
    required int index,
  }) {
    return Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: ShownyStyle.caption(color: ShownyStyle.black),
            ),
            SizedBox(height: 14.toWidth),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    tag.goodsImageUrlList.first,
                    width: 80.toWidth,
                    height: 80.toWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 13.toWidth),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tag.brandNm,
                        style: ShownyStyle.caption(color: ShownyStyle.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        tag.goodsNm,
                        style: ShownyStyle.caption(
                            color: ShownyStyle.black, weight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (!tag.optionList.isNotEmpty) ...{
                        Text(
                          '[ 착용사이즈 : M ]',
                          style:
                              ShownyStyle.caption(color: ShownyStyle.gray070),
                        ),
                      } else ...{
                        SizedBox(height: 20.toWidth),
                      },
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _itemButton(
                              onPressed: () {
                                StyleupItemTagProvider itemProv =
                                    Provider.of<StyleupItemTagProvider>(context,
                                        listen: false);
                                var completeDialog = ShownyDialog(
                                  message: "선택된 상품을 삭제하시겠습니까?",
                                  primaryLabel: "취소",
                                  primaryAction: () {},
                                  secondaryLabel: "삭제",
                                  secondaryAction: () {
                                    itemProv.setStoreGoodModel(null, index);
                                  },
                                );
                                showDialog(
                                  barrierColor: Colors.black.withOpacity(0.4),
                                  context: context,
                                  builder: (context) => completeDialog,
                                );
                              },
                              bgColor: ShownyStyle.gray040,
                              text: '삭제',
                              textColor: ShownyStyle.gray070),
                          SizedBox(width: 4.toWidth),
                          _itemButton(
                              onPressed: () {
                                StyleupItemTagProvider itemProv =
                                    Provider.of<StyleupItemTagProvider>(context,
                                        listen: false);
                                Navigator.push(
                                    context,
                                    ShownyPageRoute(
                                        builder: (context) => StoreSearchScreen(
                                              onSelected: (goodsData) {
                                                goodsData.left = tag.left;
                                                goodsData.top = tag.top;
                                                itemProv.setStoreGoodModel(
                                                    goodsData, index);
                                              },
                                            ),
                                        settings: const RouteSettings(
                                            name: PageName.STORE_SEARCH)));
                              },
                              bgColor: ShownyStyle.black,
                              text: '변경',
                              textColor: ShownyStyle.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _itemButton({
    required VoidCallback onPressed,
    required Color bgColor,
    required String text,
    required Color textColor,
  }) {
    return BaseButton(
      onPressed: onPressed,
      child: Container(
        width: 56.toWidth,
        height: 28.toWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: bgColor,
        ),
        child: Text(
          text,
          style: ShownyStyle.caption(color: textColor),
        ),
      ),
    );
  }
}
