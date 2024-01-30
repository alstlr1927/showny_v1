import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/screens/upload/styleup/providers/styleup_pick_provider.dart';
import 'package:showny/screens/upload/styleup/stylup_input_info.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class StylupPickImage extends StatefulWidget {
  const StylupPickImage({super.key});

  @override
  State<StylupPickImage> createState() => _StylupPickImageState();
}

class _StylupPickImageState extends State<StylupPickImage> {
  late StyleupPickProvider provider;
  @override
  void initState() {
    super.initState();
    provider = StyleupPickProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StyleupPickProvider>.value(
        value: provider,
        builder: (context, _) {
          return Consumer<StyleupPickProvider>(builder: (ctx, prov, child) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('스타일업'),
                scrolledUnderElevation: 0,
                actions: [
                  ShownyButton(
                    onPressed: prov.selectedFiles.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                                context,
                                ShownyPageRoute(
                                  builder: (context) => StyleupInputInfo(
                                    fileList: prov.selectedFiles,
                                    type: prov.fileType,
                                    thumb: prov.thumbnail,
                                  ),
                                ));
                          },
                    option: ShownyButtonOption.text(
                      text: '다음',
                      theme: ShownyButtonTextTheme.black,
                      style: ShownyButtonTextStyle.regular,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  _buildSeletedArea(ctx),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.toWidth),
                    child: Row(
                      children: [
                        DropdownButton2(
                          customButton: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 8.toWidth),
                            child: Row(
                              children: [
                                Text(
                                  '이미지',
                                  style: ShownyStyle.body2(color: ShownyStyle.black),
                                ),
                                SizedBox(width: 8.toWidth),
                                Image.asset(
                                  'assets/icons/upload/bottom_arrow.png',
                                  width: 12.toWidth,
                                  height: 12.toWidth,
                                ),
                              ],
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: FileType.image.name,
                              child: Text(
                                '이미지',
                                style: ShownyStyle.body2(color: ShownyStyle.black),
                              ),
                            ),
                            DropdownMenuItem(
                              value: FileType.video.name,
                              child: Text(
                                '비디오',
                                style: ShownyStyle.body2(color: ShownyStyle.black),
                              ),
                            ),
                          ],
                          // value: prov.fileType.name,
                          onChanged: prov.setFileType,
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                        const Spacer(),
                        // if (prov.fileType == 'image') ...{
                        //   BaseButton(
                        //     onPressed: () {},
                        //     child: Container(
                        //       padding: EdgeInsets.all(8.toWidth),
                        //       decoration: BoxDecoration(
                        //         color: ShownyStyle.black,
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //       child: Row(
                        //         children: [
                        //           Image.asset(
                        //             'assets/icons/upload/multi.png',
                        //             width: 24.toWidth,
                        //             height: 24.toWidth,
                        //             fit: BoxFit.cover,
                        //           ),
                        //           SizedBox(width: 4.toWidth),
                        //           Text(
                        //             '여러 항목 선택',
                        //             style: ShownyStyle.caption(
                        //               color: ShownyStyle.white,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // },
                        BaseButton(
                          onPressed: () async {
                            // bottom sheet
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.toWidth),
                            margin: EdgeInsets.symmetric(horizontal: 8.toWidth),
                            decoration: BoxDecoration(
                              color: ShownyStyle.black.withOpacity(.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset(
                              'assets/icons/upload/camera.png',
                              width: 24.toWidth,
                              height: 24.toWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: ScreenUtil().screenWidth,
                      child: GridView(
                        physics: const ClampingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        addAutomaticKeepAlives: true,
                        children: prov.imageList.map((imageFile) {
                          return FutureBuilder(
                            future: imageFile.thumbnailData,
                            builder: (context, snapshot) {
                              if (snapshot.data == null || !snapshot.hasData) {
                                return Container();
                              }
                              // snapshot.data.
                              return Image.memory(
                                snapshot.data!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget _buildSeletedArea(BuildContext context) {
    StyleupPickProvider pickProv = Provider.of<StyleupPickProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        pickProv.fileSelectBottomSheet();
      },
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenWidth,
        color: Colors.white,
        child: Builder(builder: (context) {
          if (pickProv.selectedFiles.isNotEmpty) {
            if (pickProv.fileType == 'img') {
              return Image.file(
                File(pickProv.selectedFiles.first.path),
                fit: BoxFit.cover,
              );
            }
            if (pickProv.fileType == 'video') {
              return Image.file(
                File(pickProv.thumbnail!.path),
                fit: BoxFit.cover,
              );
            }
          }
          return Center(
            child: Icon(
              Icons.add,
              size: 40.toWidth,
            ),
          );
        }),
      ),
    );
  }
}
