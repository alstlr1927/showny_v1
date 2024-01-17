import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/upload/battle/crop_image.dart';
import 'package:showny/screens/upload/battle/models/battle_upload_model.dart';
import 'package:showny/utils/showny_util.dart';

class SelectCover extends StatelessWidget {
  final StyleupModel styleup;
  final BattleUploadModel uploadSample;
  const SelectCover({
    Key? key,
    required this.styleup,
    required this.uploadSample,
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
                              builder: (context) => CropImage(
                                imageUrl: item,
                                uploadSample: uploadSample.copyWith(),
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
