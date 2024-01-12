import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class SelectBattle extends StatefulWidget {
  const SelectBattle({super.key});

  @override
  State<SelectBattle> createState() => _SelectBattleState();
}

class _SelectBattleState extends State<SelectBattle>
    with SingleTickerProviderStateMixin {
  int idx = 0;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  int _currentIndex = 0;
  List<String> imgList = [
    'assets/icons/upload/111.jpg',
    'assets/icons/upload/222.jpg',
    'assets/icons/upload/333.jpeg',
    'assets/icons/upload/444.jpg',
    'assets/icons/upload/555.jpg',
    'assets/icons/upload/666.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: pi / 6).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('배틀'),
        scrolledUnderElevation: 0,
        actions: [
          ShownyButton(
            onPressed: () {},
            option: ShownyButtonOption.text(
              text: '등록',
              theme: ShownyButtonTextTheme.black,
              style: ShownyButtonTextStyle.regular,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenWidth,
            child: CarouselSlider.builder(
              itemCount: imgList.length,
              itemBuilder: (context, index, realIndex) {
                // if (index == idx - 1) {
                //   return Transform(
                //     transform: Matrix4.identity()
                //       ..setEntry(3, 2, .001)
                //       ..rotateY(330 * pi / 180),
                //     alignment: FractionalOffset.center,
                //     child: Image.asset(
                //       imgList[index],
                //       fit: BoxFit.cover,
                //     ),
                //   );
                // }
                // if (index == idx + 1) {
                //   return Transform(
                //     transform: Matrix4.identity()
                //       ..setEntry(3, 2, .001)
                //       ..rotateY(-330 * pi / 180),
                //     alignment: FractionalOffset.center,
                //     child: Image.asset(
                //       imgList[index],
                //       fit: BoxFit.cover,
                //     ),
                //   );
                // }
                bool isPreviousIndex = index == _currentIndex - 1;
                bool isNextIndex = index == _currentIndex + 1;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // 원근법 효과 추가
                    ..rotateY(
                      isPreviousIndex
                          ? 330 * pi / 180
                          : (isNextIndex ? -330 * pi / 180 : 0),
                    ),
                  alignment: FractionalOffset.center,
                  child: Image.asset(
                    imgList[index],
                    fit: BoxFit.cover,
                  ),
                );
                return Image.asset(
                  imgList[index],
                  fit: BoxFit.cover,
                );
              },
              options: CarouselOptions(
                aspectRatio: 4 / 5,
                viewportFraction: .6,
                enlargeFactor: .01,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  idx = index;
                  _currentIndex = index;

                  setState(() {});
                },
              ),
            ),
            // child: Swiper(
            //   itemCount: 8,
            //   loop: true,
            //   itemWidth: ScreenUtil().screenWidth * .65,
            //   layout: SwiperLayout.CUSTOM,
            //   customLayoutOption:
            //       CustomLayoutOption(startIndex: -1, stateCount: 3)
            //         ..addRotate([0, 0.0, 0])
            //         ..addTranslate([
            //           Offset(ScreenUtil().screenWidth * -.65, -20.0),
            //           const Offset(0.0, 0.0),
            //           Offset(ScreenUtil().screenWidth * .65, -0.0)
            //         ])
            //         ..addScale([.8, 1, .8], Alignment.center),
            //   itemBuilder: (context, index) {
            //     return Container(
            //       width: 100,
            //       height: 100,
            //       decoration: BoxDecoration(
            //         color: Colors.green[100 + 100 * index],
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     );
            //   },
            // ),
          ),
          const Spacer(),
          _buildSelectButton(),
        ],
      ),
    );
  }

  Widget _buildSelectButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
      child: Column(
        children: [
          ShownyButton(
            onPressed: () {},
            option: ShownyButtonOption.fill(
              text: '선택완료',
              theme: ShownyButtonFillTheme.violet,
              style: ShownyButtonFillStyle.fullRegular,
            ),
          ),
          SizedBox(height: ShownyStyle.defaultBottomPadding() + 50 + 14)
        ],
      ),
    );
  }
}
