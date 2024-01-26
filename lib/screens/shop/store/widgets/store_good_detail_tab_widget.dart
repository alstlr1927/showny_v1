import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/showny_style.dart';

double _kProductDetailTabHeight = 40.0;

class StoreGoodDetailTabWidget extends StatefulWidget {
  final StoreGoodModel goodsData;
  final int tabIndex;
  final Function(int) onSelectedTab;

  const StoreGoodDetailTabWidget(
      {super.key,
      required this.goodsData,
      required this.tabIndex,
      required this.onSelectedTab});

  @override
  State<StoreGoodDetailTabWidget> createState() => _StoreGoodDetailTabWidget();
}

class _StoreGoodDetailTabWidget extends State<StoreGoodDetailTabWidget> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.goodsData.goodsDescription.replaceAll(RegExp(r'\\'), ''));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: _kProductDetailTabHeight,
          child: Row(
            children: [
              tab(0, tr("store.details.product_description"), () {
                widget.onSelectedTab(0);
              }),
              tab(1, tr("store.details.review"), () {
                widget.onSelectedTab(1);
              }),
              tab(2, tr("store.details.inquiry"), () {
                widget.onSelectedTab(2);
              }),
              tab(3, tr("store.details.delivery_return"), () {
                widget.onSelectedTab(3);
              }),
            ],
          ),
        ),
      ],
    );
  }

  tab(int index, String text, Function() onSelected) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: SizedBox(
        width: size.width / 4,
        height: 40,
        child: Column(
          children: [
            const Spacer(),
            Text(
              text,
              style: widget.tabIndex == index
                  ? FontHelper.bold_12_000000
                  : ShownyStyle.caption(),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: widget.tabIndex == index
                    ? const Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black,
                      )
                    : const SizedBox(height: 1))
          ],
        ),
      ),
    );
  }
}
