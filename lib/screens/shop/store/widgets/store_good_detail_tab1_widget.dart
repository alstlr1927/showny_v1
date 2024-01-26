import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/models/store_good_model.dart';

class StoreGoodDetailTab1Widget extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailTab1Widget({
    super.key,
    required this.goodsData,
  });

  @override
  State<StoreGoodDetailTab1Widget> createState() =>
      _StoreGoodDetailTab1Widget();
}

class _StoreGoodDetailTab1Widget extends State<StoreGoodDetailTab1Widget> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.goodsData.goodsDescription
        .replaceAll(RegExp(r'\\'), '')
        .replaceAll(RegExp('<br style="clear:both;">'), ''));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Html(
        data: widget.goodsData.goodsDescription
            .replaceAll(RegExp(r'\\'), '')
            .replaceAll(RegExp('<br style="clear:both;">'), ''),
        shrinkWrap: true,
      ),
    );
  }
}
