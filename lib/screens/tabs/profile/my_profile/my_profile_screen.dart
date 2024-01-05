import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showny/constants.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/style.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/feed_item.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/tabs/home/screen/styleup_screen.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_follower_screen.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_following_screen.dart';
import 'package:showny/screens/tabs/profile/my_shop/my_shop_screen.dart';
import 'package:showny/screens/tabs/profile/profile_tab_button.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';
import 'package:showny/screens/tabs/profile/test.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class MyProfileScreen extends StatefulWidget {
  final TabController tabController;
  const MyProfileScreen({super.key, required this.tabController});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  List<String>? tags;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetMyProfileProvider>(
        builder: (context, getMyProfileProvider, child) {
      return Consumer<UserProvider>(builder: (context, userProvider, child) {
        debugPrint(userProvider.user.memNo);

        tags = userProvider.user.styleIdList
            .map((e) => e.convertToStyle?.converToString ?? "")
            .toList();
        debugPrint(
            "user post count ${(userProvider.user.postCount).toString()}");
        debugPrint(
            "user Follower count ${(userProvider.user.followerCount).toString()}");
        debugPrint(
            "user Follow count ${(userProvider.user.followCount).toString()}");
        return Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: widget.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: getMyProfileProvider.myStyleupList.length,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 13 / 20,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return FeedItem(
                        item: getMyProfileProvider.myStyleupList[index],
                        onSelected: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StyleupScreen(
                                  isMain: false,
                                  initIndex: index,
                                  styleupList:
                                      getMyProfileProvider.myStyleupList,
                                ),
                              )
                              // PageRouteBuilderRightLeft(child: TestScreen()
                              //     // child: StyleupScreen(
                              //     //   isMain: false,
                              //     //   initIndex: index,
                              //     //   styleupList: getMyProfileProvider.myStyleupList,
                              //     // ),
                              //     ),
                              );
                        },
                      );
                    },
                  ),
                  const MyShopScreen(),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: getMyProfileProvider.myBookmarkList.length,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 13 / 20,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return FeedItem(
                        item: getMyProfileProvider.myBookmarkList[index],
                        onSelected: () {
                          Navigator.push(
                              context,
                              PageRouteBuilderRightLeft(
                                  child: StyleupScreen(
                                isMain: false,
                                initIndex: index,
                                styleupList:
                                    getMyProfileProvider.myBookmarkList,
                              )));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      });
    });
  }

  // Widget pageAtCategory() {
  //   switch (tabIndex) {
  //     case 0:
  //     case 1:
  //     default:
  //       return Consumer<GetMyProfileProvider>(
  //         builder: (context, getMyProfileProvider, child) {
  //           int itemCount = 0;
  //           List<StyleupModel>? feedItems;
  //           if (tabIndex == 0) {
  //             itemCount = getMyProfileProvider.myStyleupList.length;
  //             feedItems = getMyProfileProvider.myStyleupList;
  //           } else if (tabIndex == 1) {
  //             itemCount = getMyProfileProvider.myBookmarkList.length;
  //             feedItems = getMyProfileProvider.myBookmarkList;
  //           }

  //           if (feedItems != null) {
  //             debugPrint(feedItems.length.toString());
  //           }

  //           return GridView.builder(
  //             shrinkWrap: true,
  //             itemCount: itemCount,
  //             physics: const NeverScrollableScrollPhysics(),
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 3,
  //               childAspectRatio: 13 / 20,
  //               mainAxisSpacing: 1,
  //               crossAxisSpacing: 1,
  //             ),
  //             itemBuilder: (BuildContext context, int index) {
  //               return FeedItem(
  //                 item: feedItems![index],
  //                 onSelected: () {
  //                   Navigator.push(
  //                     context,
  //                     PageRouteBuilderRightLeft(
  //                       child: StyleupScreen(
  //                         isMain: false,
  //                         initIndex: index,
  //                         styleupList: feedItems!,
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               );
  //             },
  //           );
  //         },
  //       );
  //   }
  // }
}

enum MyProfilePageCategory with CategoryMixin {
  all,
  bookmark;

  @override
  String get name {
    switch (this) {
      case MyProfilePageCategory.all:
        return "assets/icons/profile_my_styleup.png";
      case MyProfilePageCategory.bookmark:
        return "assets/icons/profile_my_bookmark.png";
    }
  }
}
