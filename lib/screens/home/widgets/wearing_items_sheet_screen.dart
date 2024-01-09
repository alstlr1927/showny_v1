import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/goods_item_model.dart';
import 'package:showny/screens/home/widgets/wearing_item_tile.dart';

class WearingItemsSheetScreen extends StatefulWidget {
  const WearingItemsSheetScreen({super.key, required this.itemInfo});

  final List<GoodsItemModel> itemInfo;

  @override
  State<WearingItemsSheetScreen> createState() =>
      _WearingItemsSheetScreenState();
}

class _WearingItemsSheetScreenState extends State<WearingItemsSheetScreen> {
  final sheetController = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    sheetController.addListener(_onSheetHeightChanged);
  }

  @override
  void dispose() {
    sheetController.removeListener(_onSheetHeightChanged);
    super.dispose();
  }

  void _onSheetHeightChanged() {
    if (sheetController.size <= 0.5) {
      FocusManager.instance.primaryFocus?.unfocus();
      sheetController.animateTo(
        0.5,
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        ),
        DraggableScrollableSheet(
          controller: sheetController,
          minChildSize: 0.45,
          maxChildSize: 0.95,
          snapSizes: const [0.5, 0.95],
          snap: true,
          builder: (context, controller) {
            return Container(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 24.0),
                        Text('착용상품 리스트', style: Constants.appBarTitleStyle),
                        CupertinoButton(
                          minSize: 0.0,
                          padding: EdgeInsets.zero,
                          child: Image.asset(
                            'assets/icons/x_mark.png',
                            width: 24.0,
                            height: 24.0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: widget.itemInfo.length,
                      itemBuilder: (context, index) {
                        final item = widget.itemInfo[index];

                        return WearingItemTile(
                          itemUrl: item.goodsImg,
                          brandName: item.brandNm,
                          itemName: item.goodsNm,
                          price: item.goodsPrice,
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     PageRouteBuilderRightLeft(
                            //       child: StorePage(
                            //         goodsNo: item.goodsNo,
                            //       ),
                            //     ));
                            debugPrint('DEBUG: tap wearing item');
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
