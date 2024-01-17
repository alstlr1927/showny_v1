import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/common/components/feed_item.dart';
import 'package:showny/screens/home/styleup_screen.dart';

class TabProfileBookmark extends StatelessWidget {
  final List<StyleupModel> bookmarkList;
  const TabProfileBookmark({
    super.key,
    required this.bookmarkList,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: bookmarkList.length,
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
          item: bookmarkList[index],
          onSelected: () {
            Navigator.push(
                context,
                ShownyPageRoute(
                  builder: (context) => StyleupScreen(
                    isMain: false,
                    initIndex: index,
                    styleupList: bookmarkList,
                  ),
                ));
          },
        );
      },
    );
  }
}
