import 'package:flutter/material.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ProfieTabButton<T extends CategoryMixin> extends StatelessWidget {
  const ProfieTabButton({
    super.key,
    this.onTap,
    required this.category,
    required this.currentCategory,
    required this.count,
  });
  final Function()? onTap;
  final T category;
  final T currentCategory;
  final int count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 8.toWidth),
        child: Row(
          children: [
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: ShownyStyle.caption(
                color: category == currentCategory
                    ? Colors.black
                    : const Color(0xFF444444),
                weight: category == currentCategory
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
            SizedBox(width: 6.toWidth),
            Text(
              '$count',
              textAlign: TextAlign.center,
              style: ShownyStyle.caption(
                color: category == currentCategory
                    ? Colors.black
                    : const Color(0xFF444444),
                weight: category == currentCategory
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mixin CategoryMixin {
  String get name;
}
