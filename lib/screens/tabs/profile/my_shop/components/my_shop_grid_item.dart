import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/utils/formatter.dart';

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
            aspectRatio: 4/5,
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
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                widget.brandName != "" ? Text(
                  widget.brandName,
                  style: const TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 10,
                    fontFamily: 'Spoqa Han Sans Neo',
                    fontWeight: FontWeight.w700,
                  ),
                ) : const SizedBox(),
                widget.brandName != "" ? const SizedBox(
                  height: 8,
                ) : const SizedBox(),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Spoqa Han Sans Neo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                   '${Formatter.formatNumber(int.parse(widget.price.replaceAll(',', '')))} 원',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Spoqa Han Sans Neo',
                    fontWeight: FontWeight.w700,
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
