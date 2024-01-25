import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/utils/colors.dart';

class StoreGoodDetailImageWidget extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailImageWidget({super.key, required this.goodsData});

  @override
  State<StoreGoodDetailImageWidget> createState() =>
      _StoreGoodDetailImageWidget();
}

class _StoreGoodDetailImageWidget extends State<StoreGoodDetailImageWidget> {

  int currentImagePage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.goodsData.goodsImageUrlList.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              color: greyExtraLight,
              height: size.width,
              width: size.width,
              child: Image.network(widget.goodsData.goodsImageUrlList[index],
                  fit: BoxFit.cover, width: size.width,
                  errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                );
              }),
            );
          },
          options: CarouselOptions(
            height: size.width,
            viewportFraction: 1,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentImagePage = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0;
                  i < widget.goodsData.goodsImageUrlList.length;
                  i++)
                buildIndicator(currentImagePage == i)
            ],
          ),
        ),
      ],
    );
  }

  buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: isSelected ? black : checkBoxColor),
      ),
    );
  }
}
