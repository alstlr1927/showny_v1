import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/components/error/image_error.dart';

class BackBlurWidget extends StatelessWidget {
  final String image1;
  final String image2;
  const BackBlurWidget({
    super.key,
    required this.image1,
    required this.image2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: ScreenUtil().screenWidth / 2,
              height: ScreenUtil().screenHeight,
              child: Image.network(
                image1,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const ImageError(),
              ),
            ),
            SizedBox(
              width: ScreenUtil().screenWidth / 2,
              height: ScreenUtil().screenHeight,
              child: Image.network(
                image2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const ImageError(),
              ),
            ),
          ],
        ),
        Blur(
          blur: 5,
          blurColor: Colors.black,
          child: SizedBox(
            width: ScreenUtil().screenWidth,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}

class BackBlurWidget2 extends StatelessWidget {
  final String image;
  const BackBlurWidget2({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) => const ImageError(),
          ),
        ),
        const Blur(
          blur: 5,
          blurColor: Colors.black,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
