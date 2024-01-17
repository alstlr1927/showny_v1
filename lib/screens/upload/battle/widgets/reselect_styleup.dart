import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/common/components/feed_item.dart';
import 'package:showny/screens/upload/battle/providers/select_styleup_provider.dart';
import 'package:showny/screens/upload/battle/widgets/reselect_crop.dart';
import 'package:showny/utils/showny_util.dart';

class ReselectStyleup extends StatefulWidget {
  final Function(File file, StyleupModel styleup) onSelect;
  const ReselectStyleup({
    super.key,
    required this.onSelect,
  });

  @override
  State<ReselectStyleup> createState() => _ReselectStyleupState();
}

class _ReselectStyleupState extends State<ReselectStyleup> {
  late SelectStyleupProvider provider;

  @override
  void initState() {
    super.initState();
    provider = SelectStyleupProvider(this);
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectStyleupProvider>.value(
      value: provider,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr("스타일 가져오기")),
          ),
          body: Column(
            children: [
              SizedBox(height: 24.toWidth),
              _buildStyleupGrid(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStyleupGrid() {
    return Consumer<SelectStyleupProvider>(
      builder: (context, prov, child) {
        return Builder(builder: (ctx) {
          return Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: prov.styleupList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 13 / 20,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FeedItem(
                  item: prov.styleupList[index],
                  onSelected: () {
                    StyleupModel item = prov.styleupList[index];
                    // BattleUploadModel uploadSample =
                    //     widget.uploadSample.copyWith(styleup: item);
                    if (item.imgUrlList.length > 1) {
                      Navigator.push(
                          context,
                          ShownyPageRoute(
                            builder: (context) => ReselectCover(
                              styleup: item,
                              onSelect: widget.onSelect,
                            ),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          ShownyPageRoute(
                            builder: (context) => ReselectCrop(
                              imageUrl: item.imgUrlList.first,
                              styleup: item,
                              onSelect: widget.onSelect,
                            ),
                          ));
                    }
                  },
                );
              },
            ),
          );
        });
      },
    );
  }
}

class ReselectCover extends StatelessWidget {
  final StyleupModel styleup;
  final Function(File file, StyleupModel styleup) onSelect;
  const ReselectCover({
    Key? key,
    required this.styleup,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('대표 이미지 선택'),
      ),
      body: Column(
        children: [
          SizedBox(height: 24.toWidth),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: styleup.imgUrlList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 13 / 20,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = styleup.imgUrlList[index];

                return Stack(
                  children: [
                    Container(color: Colors.white),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                          alignment: Alignment.center,
                          child: Opacity(
                            opacity: 1.0,
                            child: Image.network(
                              item,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            ShownyPageRoute(
                              builder: (context) => ReselectCrop(
                                imageUrl: item,
                                styleup: styleup,
                                onSelect: onSelect,
                              ),
                            ));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
