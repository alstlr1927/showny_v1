import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ReselectCrop extends StatefulWidget {
  final StyleupModel styleup;
  final String imageUrl;
  final Function(File file, StyleupModel styleup) onSelect;
  const ReselectCrop({
    super.key,
    required this.imageUrl,
    required this.styleup,
    required this.onSelect,
  });

  @override
  State<ReselectCrop> createState() => _ReselectCropState();
}

class _ReselectCropState extends State<ReselectCrop> {
  final _cropController = CropController();
  Uint8List? _imageData;
  Uint8List? croppedImageData;

  @override
  void initState() {
    super.initState();
    _fetchImage(widget.imageUrl);
  }

  Future<void> _fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      setState(() {
        _imageData = response.bodyBytes;
      });
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("대표 이미지 선택")),
      ),
      body: Column(
        children: [
          // SizedBox(height: 24.toWidth),
          if (_imageData != null)
            Builder(builder: (context) {
              return Container(
                constraints: const BoxConstraints(
                  maxHeight: 490,
                ),
                width: double.infinity,
                child: Crop(
                    image: _imageData!,
                    controller: _cropController,
                    aspectRatio: 9 / 16,
                    interactive: true,
                    baseColor: Colors.white,
                    maskColor: Colors.black.withOpacity(0.2),
                    fixArea: true,
                    cornerDotBuilder: (size, edgeAlignment) {
                      return makeCropCornerWidget(edgeAlignment, size);
                    },
                    initialSize: 1,
                    // initialArea: Rect.fromLTWH(240, 212, 800, 600),
                    initialAreaBuilder: (rect) => Rect.fromLTRB(rect.left + 96,
                        rect.top + 36, rect.right - 96, rect.bottom - 72),
                    onCropped: (image) async {
                      final tempDir = await getTemporaryDirectory();

                      File('${tempDir.path}/image_${DateTime.now()}.png')
                          .create()
                          .then((file) async {
                        file.writeAsBytesSync(image);
                        widget.onSelect(file, widget.styleup);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    }),
              );
            })
          else
            const Center(
              child: Text("이미지를 불러올 수 없습니다."),
            ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              left: 16.toWidth,
              right: 16.toWidth,
              bottom: ShownyStyle.defaultBottomPadding() + 24.toWidth,
            ),
            child: ShownyButton(
              onPressed: () {
                _cropController.crop();
              },
              option: ShownyButtonOption.fill(
                text: '완료',
                theme: ShownyButtonFillTheme.violet,
                style: ShownyButtonFillStyle.fullRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeCropCornerWidget(EdgeAlignment edgeAlignment, double size) {
    const double barWidth = 3;
    const double barHeigt = 28;
    switch (edgeAlignment) {
      case EdgeAlignment.topLeft:
        return Stack(
          children: [
            const DotControl(
              color: Colors.transparent,
              padding: 0,
            ),
            Transform.translate(
              offset: const Offset(14, 14),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: barWidth,
                      height: barHeigt,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      width: 27 - barWidth,
                      height: barWidth,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      case EdgeAlignment.topRight:
        return Stack(
          children: [
            const DotControl(
              color: Colors.transparent,
              padding: 0,
            ),
            Transform.translate(
              offset: const Offset(-8, 13),
              child: SizedBox(
                width: size,
                height: size,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: barHeigt - barWidth,
                      height: barWidth,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      width: barWidth,
                      height: barHeigt,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      case EdgeAlignment.bottomLeft:
        return Stack(
          children: [
            const DotControl(
              color: Colors.transparent,
              padding: 0,
            ),
            Transform.translate(
              offset: const Offset(14, -14),
              child: SizedBox(
                width: size,
                height: size,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: barWidth,
                      height: barHeigt,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      width: barHeigt - barWidth,
                      height: barWidth,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      case EdgeAlignment.bottomRight:
        return Stack(
          children: [
            const DotControl(
              color: Colors.transparent,
              padding: 0,
            ),
            Transform.translate(
              offset: const Offset(-8, -14),
              child: SizedBox(
                width: size,
                height: size,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: barHeigt - barWidth,
                      height: barWidth,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      width: barWidth,
                      height: barHeigt,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
    }
  }
}
