import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/utils/formatter.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../../providers/FetchGetMemberMinishopProductProvider.dart';

class MyShopGridItem extends StatefulWidget {
  const MyShopGridItem({
    super.key,
    this.imageUrl = "https://via.placeholder.com/130x130",
    required this.brandName,
    required this.title,
    required this.price,
    this.onTap,
  });
  final String imageUrl;
  final String brandName;
  final String title;
  final String price;
  final Function()? onTap;

  @override
  State<MyShopGridItem> createState() => _MyShopGridItemState();
}

class _MyShopGridItemState extends State<MyShopGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.brandName.isEmpty ? '-' : widget.brandName,
                  style: ShownyStyle.overline(
                    color: Color(0xFF777777),
                    weight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  constraints: BoxConstraints(minHeight: 40.toWidth),
                  child: Text(
                    widget.title.isEmpty ? '-' : widget.title,
                    style: ShownyStyle.caption(
                      color: Colors.black,
                      weight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                Text(
                  '${Formatter.formatNumber(int.parse(widget.price.replaceAll(',', '')))} 원',
                  style: ShownyStyle.caption(
                    color: Colors.black,
                    weight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
