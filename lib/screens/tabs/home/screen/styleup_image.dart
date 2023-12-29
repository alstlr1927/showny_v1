import 'package:flutter/material.dart';

class StyleUpImage extends StatelessWidget {
  final List<String> imageList;
  const StyleUpImage({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        physics: const ClampingScrollPhysics(),
        children: imageList
            .map((url) => SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(url, fit: BoxFit.cover),
                ))
            .toList(),
      ),
    );
  }
}
