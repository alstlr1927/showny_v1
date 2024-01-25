import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../../../utils/colors.dart';

class ProductImageSliderWidget extends StatefulWidget {
  final List<String> imageList;

  const ProductImageSliderWidget({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  @override
  State<ProductImageSliderWidget> createState() =>
      _ProductImageSliderWidgetState();
}

class _ProductImageSliderWidgetState extends State<ProductImageSliderWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: size.width,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: widget.imageList.map(
            (item) {
              return SizedBox(
                width: size.width,
                height: size.width,
                child: Center(
                    child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: size.width,
                  height: size.width,
                )),
              );
            },
          ).toList(),
        ),
        widget.imageList.length == 1
            ? const SizedBox.shrink()
            : Positioned(
                right: 50,
                left: 50,
                bottom: 20,
                child: DotsIndicator(
                  dotsCount: widget.imageList.length,
                  position: currentIndex,
                  decorator: DotsDecorator(
                    activeColor: white,
                    spacing: const EdgeInsets.symmetric(horizontal: 4),
                    color: white.withOpacity(0.4),
                  ),
                ),
              ),
      ],
    );
  }
}
