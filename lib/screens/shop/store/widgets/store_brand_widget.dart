import 'package:flutter/material.dart';
import 'package:showny/models/brand_search_model.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/theme.dart';

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
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 60,
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
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyExtraLight,
                          image: DecorationImage(
                              image: NetworkImage(widget.brandData.brandImgUrl),
                              fit: BoxFit.contain)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(widget.brandData.cateNm,
                        style: themeData().textTheme.titleMedium)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
