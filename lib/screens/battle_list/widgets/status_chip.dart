import 'package:flutter/material.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class StatusChip extends StatelessWidget {
  final String title;
  final Color color;
  const StatusChip({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 20.toWidth, vertical: 4.toWidth),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: ShownyStyle.body2(
            color: ShownyStyle.white, weight: FontWeight.w600),
      ),
    );
  }
}
