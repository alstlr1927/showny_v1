import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/screens/shop/store/store_search_page_screen.dart';
import 'package:showny/screens/upload/styleup/providers/styleup_item_tag.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class StyleupItemTag extends StatefulWidget {
  final String type;
  final List<List<StoreGoodModel?>?>? goodsDataList;
  final Function(List<List<StoreGoodModel?>?>?) onCompleted;
  final List<XFile> imgFileList;

  const StyleupItemTag({
    super.key,
    required this.type,
    this.goodsDataList,
    required this.onCompleted,
    this.imgFileList = const [],
  });

  @override
  State<StyleupItemTag> createState() => _StyleupItemTagState();
}

class _StyleupItemTagState extends State<StyleupItemTag> {
  @override
  Widget build(BuildContext context) {
    print('type : ${widget.type}');
    print('goods : ${widget.goodsDataList}');
    print('goods : ${widget.imgFileList}');
    return ChangeNotifierProvider<StyleupItemTagProvider>(
        create: (_) => StyleupItemTagProvider(this),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('아이템 태그'),
              scrolledUnderElevation: 0,
              actions: [
                ShownyButton(
                  option: ShownyButtonOption.text(
                    text: '완료',
                    theme: ShownyButtonTextTheme.black,
                    style: ShownyButtonTextStyle.regular,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.toWidth),
                  _buildImageArea(),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildImageArea() {
    return Builder(builder: (context) {
      StyleupItemTagProvider itemProv =
          Provider.of<StyleupItemTagProvider>(context, listen: false);
      return Column(
        children: [
          CarouselSlider(
            items: widget.imgFileList.map((xfile) {
              return Listener(
                onPointerDown: (event) {
                  print('x : ${event.localPosition.dx}');
                  print('y : ${event.localPosition.dy}');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreSearchScreen(
                          onSelected: (p0) {
                            //
                          },
                        ),
                      ));
                },
                child: Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: Image.file(
                    File(xfile.path),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              aspectRatio: 3 / 4,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                itemProv.imgIndexChange(index);
              },
            ),
          ),
          Consumer<StyleupItemTagProvider>(builder: (context, prov, child) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imgFileList.asMap().entries.map((entry) {
                  return Container(
                    width: 8.toWidth,
                    height: 8.toWidth,
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: prov.imgIdx == entry.key
                          ? ShownyStyle.black
                          : const Color(0xffd9d9d9),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      );
    });
  }
}
