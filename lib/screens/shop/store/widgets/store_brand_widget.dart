import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../utils/colors.dart';

class StoreBrandWidget extends StatefulWidget {
  final BrandData brandData;

  const StoreBrandWidget({
    Key? key,
    required this.brandData,
  }) : super(key: key);

  @override
  State<StoreBrandWidget> createState() => _StoreBrandWidget();
}

class _StoreBrandWidget extends State<StoreBrandWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.toWidth,
                      width: 40.toWidth,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ShownyStyle.white,
                        boxShadow: ShownyStyle.elevation_01dp(),
                        image: DecorationImage(
                          image: NetworkImage(widget.brandData.brandImgUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.toWidth),
                    Text(
                      widget.brandData.cateNm,
                      style: ShownyStyle.body2(
                          color: ShownyStyle.black, weight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
