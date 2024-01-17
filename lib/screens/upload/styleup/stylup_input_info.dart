import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/models/style.dart';
import 'package:showny/screens/common/history_observer.dart';
import 'package:showny/screens/intro/components/preset_color_button.dart';
import 'package:showny/screens/upload/styleup/providers/styleup_input_info_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class StyleupInputInfo extends StatefulWidget {
  final List<XFile> fileList;
  final XFile? thumb;
  final String type;
  const StyleupInputInfo({
    super.key,
    required this.fileList,
    required this.type,
    this.thumb,
  });

  @override
  State<StyleupInputInfo> createState() => _StyleupInputInfoState();
}

class _StyleupInputInfoState extends State<StyleupInputInfo> {
  late StyleupInputInfoProvider provider;
  @override
  void initState() {
    super.initState();
    provider = StyleupInputInfoProvider(this);
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: provider,
        builder: (context, _) {
          return GestureDetector(
            onTap: () {
              provider.unfocusedAll();
            },
            behavior: HitTestBehavior.translucent,
            child: Scaffold(
              // resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('스타일업'),
                scrolledUnderElevation: 0,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: CustomScrollView(
                  slivers: [
                    _buildEmpty(24),
                    _buildImageArea(),
                    _buildEmpty(24),
                    _buildInputDescription(),
                    _buildEmpty(24),
                    _buildDivider(),
                    _buildTileButton(isStyle: false),
                    _buildDivider(),
                    _buildTileButton(isStyle: true),
                    _buildDivider(),
                    _buildStyleTag(),
                    _buildEmpty(24),
                    _buildMainColorArea(),
                    _buildSelectSeason(),
                    _buildEmpty(56),
                    _buildRegistButton(),
                    _buildEmpty(30),
                    _buildEmpty(ShownyStyle.defaultBottomPadding()),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildImageArea() {
    return SliverToBoxAdapter(
      child: Builder(builder: (context) {
        StyleupInputInfoProvider infoProv =
            Provider.of<StyleupInputInfoProvider>(context, listen: false);
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: widget.type == 'img'
              ? AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: widget.fileList.map((xfile) {
                          return Builder(builder: (context) {
                            return Container(
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.5),
                              child: Image.file(
                                File(xfile.path),
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                        }).toList(),
                        options: CarouselOptions(
                          aspectRatio: 3 / 4,
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            infoProv.changeIdx(index);
                          },
                        ),
                      ),
                      Consumer<StyleupInputInfoProvider>(
                          builder: (context, prov, child) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                widget.fileList.asMap().entries.map((entry) {
                              return Container(
                                width: 8.toWidth,
                                height: 8.toWidth,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(
                                      prov.viewIdx == entry.key ? 1.0 : 0.3),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ],
                  ),
                )
              : AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.file(
                    File(widget.thumb!.path),
                    fit: BoxFit.cover,
                  ),
                ),
        );
      }),
    );
  }

  Widget _buildInputDescription() {
    return Consumer<StyleupInputInfoProvider>(builder: (ctx, prov, child) {
      return SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: prov.desController,
                focusNode: prov.desFocusNode,
                maxLength: 80,
                maxLines: 5,
                minLines: 1,
                style: ShownyStyle.caption(color: ShownyStyle.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "내용을 입력해주세요.",
                  hintStyle: ShownyStyle.caption(color: ShownyStyle.gray070),
                  border: InputBorder.none,
                ),
                onChanged: prov.setDescription,
                buildCounter: (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) {
                  return null;
                },
              ),
            ),
            Text(
              '${prov.descriptionLeng}/80',
              textAlign: TextAlign.right,
              style: ShownyStyle.overline(color: ShownyStyle.gray070),
            ),
            CupertinoButton(
              minSize: 30,
              padding: EdgeInsets.zero,
              onPressed: () {
                prov.desController.clear();
              },
              child: Image.asset(
                'assets/icons/x_mark_thin.png',
                width: 16.toWidth,
                height: 16.toWidth,
                // fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTileButton({
    required bool isStyle,
  }) {
    VoidCallback? onPressed;
    String title = '';
    String description = '';

    return Consumer<StyleupInputInfoProvider>(builder: (context, prov, child) {
      if (isStyle) {
        title = '스타일 선택';
        onPressed = prov.onClickStyleTagTile;
        if (prov.selectedStyles.isNotEmpty) {
          description =
              '${prov.selectedStyles.first.converToString} 외 ${prov.selectedStyles.length - 1} 건';
        }
      } else {
        title = '아이템 태그';
        onPressed = prov.onClickItemTagTile;
        int cnt = 0;
        for (List<StoreGoodModel?>? i in prov.goodsDataList) {
          if (i != null) {
            for (StoreGoodModel? j in i) {
              if (j != null) {
                cnt++;
              }
            }
          }
        }
        if (cnt >= 1) {
          description = '$cnt';
        }
      }
      return SliverToBoxAdapter(
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 8.toWidth, vertical: 14.toWidth),
            child: Row(
              children: [
                Text(
                  title,
                  style: ShownyStyle.caption(
                      color: ShownyStyle.black, weight: FontWeight.w700),
                ),
                const Spacer(),
                if (isStyle) ...{
                  Text(
                    description,
                    style: ShownyStyle.caption(color: ShownyStyle.mainPurple),
                  ),
                } else ...{
                  Text(
                    description,
                    style: ShownyStyle.caption(color: ShownyStyle.mainPurple),
                  ),
                },
                SizedBox(width: 4.toWidth),
                Image.asset(
                  'assets/icons/upload/right_arrow.png',
                  width: 16.toWidth,
                  height: 16.toWidth,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildStyleTag() {
    return Consumer<StyleupInputInfoProvider>(builder: (context, prov, child) {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/tag.png',
                    width: 24.toWidth, height: 24.toWidth),
                SizedBox(width: 4.toWidth),
                Expanded(
                  child: TextField(
                    controller: prov.tagController,
                    focusNode: prov.tagFocusNode,
                    onChanged: prov.setTagText,
                    style: ShownyStyle.caption(color: ShownyStyle.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "스타일 태그로 더 표현해 보세요!",
                      hintStyle:
                          ShownyStyle.caption(color: ShownyStyle.gray070),
                    ),
                  ),
                ),
                if (prov.tagController.text.isNotEmpty) ...{
                  CupertinoButton(
                    minSize: 0.0,
                    padding: const EdgeInsets.only(left: 12),
                    onPressed: prov.onClickAddTag,
                    child: Image.asset(
                      'assets/icons/plus_circle_fill.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),
                }
              ],
            ),
            if (prov.selectedStyleTags.isNotEmpty) ...{
              SizedBox(height: 10.toWidth),
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: prov.styleTagScrollController,
                  child: Wrap(
                    spacing: 8.toWidth,
                    children: prov.selectedStyleTags.map((tag) {
                      return _chipWidget(
                          title: tag,
                          onPressed: () => prov.onClickDeleteTag(tag));
                    }).toList(),
                  ),
                ),
              ),
            },
          ],
        ),
      );
    });
  }

  Widget _chipWidget({
    VoidCallback? onPressed,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.toWidth, 4.toWidth, 4.toWidth, 4.toWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ShownyStyle.mainPurple,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: ShownyStyle.caption(color: ShownyStyle.white),
          ),
          SizedBox(width: 8.toWidth),
          GestureDetector(
            onTap: onPressed,
            child: Image.asset(
              'assets/icons/upload/close.png',
              width: 16.toWidth,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainColorArea() {
    return Consumer<StyleupInputInfoProvider>(
      builder: (context, prov, child) {
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '메인 컬러 선택',
                style: ShownyStyle.caption(
                    color: ShownyStyle.black, weight: FontWeight.w700),
              ),
              SizedBox(height: 24.toWidth),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: PresetColor.values.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PresetColorButton(
                    selectedColors: prov.selectedColors,
                    presetColor: PresetColor.values[index],
                    onPressed: prov.onClickColor,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectSeason() {
    return Consumer<StyleupInputInfoProvider>(
      builder: (context, prov, child) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '계절을 선택해 주세요.',
                    style: ShownyStyle.body1(color: ShownyStyle.black),
                  ),
                  SizedBox(width: 8.toWidth),
                  Text(
                    '(최대 1까지 선택가능)',
                    style: ShownyStyle.caption(color: ShownyStyle.gray070),
                  )
                ],
              ),
              SizedBox(height: 18.toWidth),
              Row(
                children: Season.values
                    .map((value) {
                      // bool isSelcted =

                      bool isSelected = prov.selectedSeason == value;
                      return Flexible(
                        flex: 10,
                        child: BaseButton(
                          onPressed: () => prov.onClickSeason(value),
                          child: Container(
                            width: double.infinity,
                            height: 45.toWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: isSelected
                                  ? ShownyStyle.mainPurple
                                  : ShownyStyle.white,
                              border: Border.all(
                                  width: 1,
                                  color: isSelected
                                      ? ShownyStyle.mainPurple
                                      : ShownyStyle.gray040),
                            ),
                            child: Text(
                              value.convertToString,
                              style: ShownyStyle.caption(
                                  color: isSelected
                                      ? ShownyStyle.white
                                      : ShownyStyle.gray060),
                            ),
                          ),
                        ),
                      );
                    })
                    .superJoin(
                        Flexible(flex: 1, child: SizedBox(width: 8.toWidth)))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRegistButton() {
    return SliverToBoxAdapter(
      child: Builder(builder: (context) {
        StyleupInputInfoProvider prov =
            Provider.of<StyleupInputInfoProvider>(context, listen: false);
        return Column(
          children: [
            Text(
              '아이템 태그 & 스타일 태그로 게시물을 더 많이 노출해 보세요!',
              style: ShownyStyle.caption(color: ShownyStyle.gray070),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.toWidth),
            ShownyButton(
              onPressed: prov.handleUploadButton,
              option: ShownyButtonOption.fill(
                text: '등록',
                theme: ShownyButtonFillTheme.violet,
                style: ShownyButtonFillStyle.fullRegular,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEmpty(double height) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height.toWidth,
      ),
    );
  }

  Widget _buildDivider() {
    return SliverToBoxAdapter(
      child: Container(
        width: ScreenUtil().screenWidth,
        height: 1,
        color: ShownyStyle.gray040,
      ),
    );
  }
}

enum Season { spring, summer, fall, winter }

extension SeasonExtension on Season {
  String get convertToString {
    switch (this) {
      case Season.spring:
        return "봄";
      case Season.summer:
        return "여름";
      case Season.fall:
        return "가을";
      case Season.winter:
        return "겨울";
    }
  }
}
