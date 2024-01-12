import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/screens/upload/styleup/types/item_category.dart';
import 'package:showny/utils/showny_style.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
    required this.category,
    required this.onSelected,
    this.goodsData,
  });

  final ItemCategory category;
  final Function() onSelected;
  final StoreGoodModel? goodsData;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: goodsData != null
                  ? SizedBox(
                      width: 64,
                      height: 64,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            goodsData!.goodsImageUrlList[0],
                            fit: BoxFit.cover,
                          )),
                    )
                  : Image.asset(
                      'assets/icons/plus.png',
                      width: 14.0,
                      height: 14.0,
                    ),
            ),
          ),
          const SizedBox(height: 9.0),
          Text(
            category.convertToString,
            style: ShownyStyle.caption(color: ShownyStyle.black),
          ),
        ],
      ),
      onPressed: () {
        onSelected();
      },
    );
  }
}
