import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/screens/upload/styleup/providers/styleup_item_tag_provider.dart';
import 'package:showny/screens/upload/styleup/widgets/item_tag_carousel.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class StyleupItemTag extends StatefulWidget {
  final String type;
  final List<List<StoreGoodModel?>?> goodsDataList;
  final Function(List<List<StoreGoodModel?>?>?) onCompleted;
  final List<XFile> imgFileList;

  const StyleupItemTag({
    super.key,
    required this.type,
    required this.goodsDataList,
    required this.onCompleted,
    this.imgFileList = const [],
  });

  @override
  State<StyleupItemTag> createState() => _StyleupItemTagState();
}

class _StyleupItemTagState extends State<StyleupItemTag> {
  late StyleupItemTagProvider provider;

  @override
  void initState() {
    super.initState();
    provider = StyleupItemTagProvider(this);
    // goodsDataList = [...widget.goodsDataList];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StyleupItemTagProvider>.value(
        value: provider,
        builder: (context, _) {
          return Consumer<StyleupItemTagProvider>(
              builder: (context, prov, child) {
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
                    if (widget.type == 'img') ...{
                      _buildImageArea(),
                    },
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget _buildImageArea() {
    return Builder(builder: (context) {
      StyleupItemTagProvider itemProv =
          Provider.of<StyleupItemTagProvider>(context, listen: false);
      return Column(
        children: [
          ItemTagCarouselImageViewer(
            imgFileList: widget.imgFileList,
            goodsDataList: itemProv.goodsDataList,
            initIndex: 0,
            onChangePageIndex: itemProv.imgIndexChange,
            onTap: () {
              itemProv.showItemTagSheet();
            },
          ),
          // CarouselSlider(
          //   items: widget.imgFileList.map((xfile) {
          //     return GestureDetector(
          //       onTap: () {
          //         itemProv.showItemTagSheet();
          //       },
          //       onTapDown: (details) {
          //         debugPrint('x : ${details.localPosition.dx}');
          //         debugPrint('y : ${details.localPosition.dy}');
          //       },
          //       child: Container(
          //         color: Colors.grey.withOpacity(0.5),
          //         child: Image.file(
          //           File(xfile.path),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     );
          //   }).toList(),
          //   options: CarouselOptions(
          //     aspectRatio: 3 / 4,
          //     viewportFraction: 1,
          //     enableInfiniteScroll: false,
          //     onPageChanged: (index, reason) {
          //       itemProv.imgIndexChange(index);
          //     },
          //   ),
          // ),
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
