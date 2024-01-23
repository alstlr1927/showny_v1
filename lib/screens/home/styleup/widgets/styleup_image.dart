import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/error/image_error.dart';
import 'package:showny/screens/home/styleup/providers/styleup_item_provider.dart';

class StyleUpImage extends StatelessWidget {
  final List<String> imageList;
  const StyleUpImage({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StyleUpItemProvider prov =
        Provider.of<StyleUpItemProvider>(context, listen: false);
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: PageView(
        physics: const ClampingScrollPhysics(),
        onPageChanged: prov.setImgIdx,
        children: imageList
            .map((url) => SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const ImageError(),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
