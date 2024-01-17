import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/upload/battle/crop_image.dart';
import 'package:showny/screens/upload/battle/models/battle_upload_model.dart';
import 'package:showny/screens/upload/battle/providers/select_styleup_provider.dart';
import 'package:showny/screens/upload/battle/select_cover.dart';
import 'package:showny/utils/showny_util.dart';

import '../../common/components/feed_item.dart';

class SelectStyleup extends StatefulWidget {
  final BattleUploadModel uploadSample;
  const SelectStyleup({
    super.key,
    required this.uploadSample,
  });

  @override
  State<SelectStyleup> createState() => _SelectStyleupState();
}

class _SelectStyleupState extends State<SelectStyleup> {
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
                    BattleUploadModel uploadSample =
                        widget.uploadSample.copyWith(styleup: item);
                    if (item.imgUrlList.length > 1) {
                      Navigator.push(
                          context,
                          ShownyPageRoute(
                            builder: (context) => SelectCover(
                              styleup: item,
                              uploadSample: uploadSample,
                            ),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          ShownyPageRoute(
                            builder: (context) => CropImage(
                              imageUrl: item.imgUrlList.first,
                              uploadSample: uploadSample,
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
