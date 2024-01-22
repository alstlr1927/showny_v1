import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/common/components/feed_item.dart';
import 'package:showny/screens/home/styleup_screen.dart';

class TabProfileFeed extends StatelessWidget {
  final List<StyleupModel> styleupList;
  final Function({required String styleupNo, required StyleupModel copy})?
      setStyleupData;
  const TabProfileFeed({
    Key? key,
    required this.styleupList,
    this.setStyleupData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: styleupList.length,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 13 / 20,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return FeedItem(
          item: styleupList[index],
          onSelected: () {
            Navigator.push(
              context,
              ShownyPageRoute(
                builder: (context) => StyleupScreen(
                  isMain: false,
                  initIndex: index,
                  styleupList: styleupList,
                  setStyelupData: setStyleupData,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
