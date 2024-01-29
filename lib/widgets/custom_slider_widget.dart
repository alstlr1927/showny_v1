import 'dart:math';
import 'package:flutter/material.dart';
import 'package:showny/utils/showny_style.dart';

class CustomSlider extends StatelessWidget {
  double value;
  Function onChanged;

  CustomSlider({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2,
        trackShape: const RoundedRectSliderTrackShape(),
        activeTrackColor: ShownyStyle.mainPurple,
        inactiveTrackColor: ShownyStyle.mainPurple,
        thumbShape: const PolygonSliderThumb(
          thumbRadius: 12.0,
          sliderValue: 3,
        ),
        thumbColor: ShownyStyle.mainPurple,
        tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 5),
        activeTickMarkColor: ShownyStyle.mainPurple,
        inactiveTickMarkColor: ShownyStyle.mainPurple,
      ),
      child: Slider(
        min: 1,
        max: 5,
        value: value,
        divisions: 4,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class PolygonSliderThumb extends SliderComponentShape {
  final double thumbRadius;
  final double sliderValue;

  const PolygonSliderThumb({
    required this.thumbRadius,
    required this.sliderValue,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    double innerPolygonRadius1 = thumbRadius * 0.6;
    double innerPolygonRadius = thumbRadius * 0.8;
    double outerPolygonRadius = thumbRadius * 1;

    final thumbColor = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.black
      ..style = PaintingStyle.fill;

    final backGroundColor = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Offset startPoint2 = Offset(
      ((innerPolygonRadius1 * cos(0.0) + center.dx)) - 4,
      ((outerPolygonRadius * sin(0.0)) + center.dy),
    );

    canvas.drawCircle(startPoint2, outerPolygonRadius, thumbColor);
    canvas.drawCircle(startPoint2, innerPolygonRadius, backGroundColor);
    canvas.drawCircle(startPoint2, innerPolygonRadius1, thumbColor);
  }
}
