import 'package:flutter/material.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/utils/showny_style.dart';

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
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: ShownyImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
            ),
            // child: Container(
            //   decoration: ShapeDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(widget.imageUrl),
            //       fit: BoxFit.cover,
            //     ),
            //     shape: const RoundedRectangleBorder(
            //       side: BorderSide(
            //         width: 0.50,
            //         strokeAlign: BorderSide.strokeAlignCenter,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(height: 8),
          //       Text(
          //         widget.brandName.isEmpty ? '-' : widget.brandName,
          //         style: ShownyStyle.overline(
          //           color: Color(0xFF777777),
          //           weight: FontWeight.w700,
          //         ),
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //       const SizedBox(
          //         height: 6,
          //       ),
          //       Container(
          //         constraints: BoxConstraints(minHeight: 40.toWidth),
          //         child: Text(
          //           widget.title.isEmpty ? '-' : widget.title,
          //           style: ShownyStyle.caption(
          //             color: Colors.black,
          //             weight: FontWeight.w500,
          //           ),
          //           maxLines: 2,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 0,
          //       ),
          //       Text(
          //         widget.price,
          //         style: ShownyStyle.caption(
          //           color: Colors.black,
          //           weight: FontWeight.w700,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.title.isEmpty ? '-' : widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ShownyStyle.caption(
                      color: Colors.black,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  widget.price,
                  style: ShownyStyle.caption(
                    color: Colors.black,
                    weight: FontWeight.w700,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
