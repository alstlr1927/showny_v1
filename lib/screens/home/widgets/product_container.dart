import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/error/image_error.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/models/goods_item_model.dart';
import 'package:showny/screens/home/widgets/wearing_items_sheet_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ProductContainer extends StatefulWidget {
  const ProductContainer({
    super.key,
    required this.itemInfo,
    required this.styleNo,
    required this.currentImageIdx,
  });

  final List<List<GoodsItemModel>> itemInfo;
  final int currentImageIdx;
  final String styleNo;

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  List<GoodsItemModel> goodsDataList = [];

  @override
  void initState() {
    super.initState();

    goodsDataList.clear();
    for (var goodsList in widget.itemInfo) {
      for (var goodsItem in goodsList) {
        goodsDataList.add(goodsItem);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (goodsDataList.isNotEmpty) {
      return GestureDetector(
          onTap: () {
            showMoreItem(context, itemInfo: goodsDataList);
          },
          child: Container(
            padding: EdgeInsets.all(4.toWidth),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ShownyImage(
                    imageUrl: goodsDataList.first.goodsImg,
                    width: 40.toWidth,
                    height: 40.toWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.toWidth),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goodsDataList[0].brandNm,
                        style: ShownyStyle.overline(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        goodsDataList[0].goodsNm,
                        style: ShownyStyle.overline(
                            color: Colors.white, weight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                CupertinoButton(
                  onPressed: () {
                    showMoreItem(context, itemInfo: goodsDataList);
                  },
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: SizedBox(
                    width: 50,
                    height: 30,
                    child: Center(
                      child: Text(
                        '더보기',
                        style: ShownyStyle.overline(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
    } else {
      return SizedBox(
        height: 48.toWidth,
      );
    }
  }

  void showMoreItem(BuildContext context,
      {required List<GoodsItemModel> itemInfo}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (context) {
        return WearingItemsSheetScreen(itemInfo: itemInfo);
      },
    );
  }
}
