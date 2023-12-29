import 'package:flutter/material.dart';

class ProfieTabButton<T extends CategoryMixin> extends StatelessWidget {
  const ProfieTabButton({
    super.key,
    this.onTap,
    required this.category,
    required this.currentCategory,
  });
  final Function()? onTap;
  final T category;
  final T currentCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          category.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: category == currentCategory
                ? Colors.black
                : const Color(0xFF444444),
            fontSize: 12,
            fontFamily: 'Spoqa Han Sans Neo',
            fontWeight:
                category == currentCategory ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

mixin CategoryMixin {
  String get name;
}
