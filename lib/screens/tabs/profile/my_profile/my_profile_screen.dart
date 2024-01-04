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
import 'package:showny/screens/tabs/profile/profile_tab_button.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    super.key,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  int tabIndex = 0;

  List<String>? tags;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    Provider.of<GetMyProfileProvider>(context, listen: false)
        .getMyStyleupList(context);
    Provider.of<GetMyProfileProvider>(context, listen: false)
        .getMyBookmarkList(context);

    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          tabIndex = _tabController.index;
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 84.toWidth,
                    height: 84.toWidth,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          userProvider.user.profileImage != ""
                              ? userProvider.user.profileImage
                              : 'https://via.placeholder.com/88x88',
                        ),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x28000000),
                          blurRadius: 1,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 21),
                  Text(
                    userProvider.user.nickNm,
                    style: ShownyStyle.caption(
                        color: ShownyStyle.black, weight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    userProvider.user.introduce,
                    style: ShownyStyle.overline(
                        color: ShownyStyle.black, weight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 65.toWidth,
                            height: 46,
                            child: Column(
                              children: [
                                Text(
                                  (userProvider.user.postCount).toString(),
                                  style: ShownyStyle.body2(
                                      weight: FontWeight.w600,
                                      color: ShownyStyle.black),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Text(
                                  tr('profile_2.post'),
                                  style: ShownyStyle.overline(
                                      weight: FontWeight.w400,
                                      color: ShownyStyle.black),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilderRightLeft(
                                      child: ProfileFollowerScreen(
                                          profileMemNo:
                                              userProvider.user.memNo)));
                            },
                            child: SizedBox(
                              width: 65.toWidth,
                              height: 46,
                              child: Column(
                                children: [
                                  Text(
                                    (userProvider.user.followerCount)
                                        .toString(),
                                    style: ShownyStyle.body2(
                                        weight: FontWeight.w600,
                                        color: ShownyStyle.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Spacer(),
                                  Text(
                                    tr('profile_screen.followers'),
                                    style: ShownyStyle.overline(
                                        weight: FontWeight.w400,
                                        color: ShownyStyle.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilderRightLeft(
                                      child: ProfileFollowingScreen(
                                    profileMemNo: userProvider.user.memNo,
                                  )));
                            },
                            child: SizedBox(
                              width: 65.toWidth,
                              height: 46,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (userProvider.user.followCount).toString(),
                                    style: ShownyStyle.body2(
                                        weight: FontWeight.w600,
                                        color: ShownyStyle.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Spacer(),
                                  Text(
                                    tr('product_detail.seller_information.following_text'),
                                    style: ShownyStyle.overline(
                                        weight: FontWeight.w400,
                                        color: ShownyStyle.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const SizedBox(height: 12),
                  // const SizedBox(height: 16),
                  // Wrap(
                  //   spacing: 8,
                  //   runSpacing: 8,
                  //   children: List.generate(
                  //     userProvider.user.styleIdList.length,
                  //     (index) {
                  //       return SizedBox(
                  //           height: 28,
                  //           child: Container(
                  //             height: 28,
                  //             // color: const Color(0xFFEFEFEF),
                  //             decoration: BoxDecoration(
                  //               color: const Color(0xFFEFEFEF),
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 12, vertical: 6),
                  //             child: Text(
                  //               tags?[index] ?? "",
                  //               textAlign: TextAlign.center,
                  //               style: Constants.defaultTextStyle
                  //                   .copyWith(fontSize: 11.0),
                  //             ),
                  //           ));
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           // Navigator.push(
                  //           //     context,
                  //           //     PageRouteBuilderRightLeft(
                  //           //         child: EditProfileScreen(
                  //           //       disposed: () => WidgetsBinding.instance
                  //           //           .addPostFrameCallback(
                  //           //               (_) => setState(() {})),
                  //           //     )));
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //             elevation: 0.0,
                  //             foregroundColor: Colors.black,
                  //             backgroundColor:
                  //                 const Color(0xFFEFEFEF), // Text color
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius:
                  //                   BorderRadius.circular(6.0), // Border radius
                  //             ),
                  //             minimumSize: const Size(double.infinity, 28)),
                  //         child: Text(
                  //           tr('profile_edit.profile_edit'),
                  //           style: FontHelper.regualr_12_000000,
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           Share.share(
                  //               'https://www.instagram.com/outfitbattles_korea/');
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //             elevation: 0.0,
                  //             foregroundColor: Colors.black,
                  //             backgroundColor:
                  //                 const Color(0xFFEFEFEF), // Text color
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius:
                  //                   BorderRadius.circular(6.0), // Border radius
                  //             ),
                  //             minimumSize: const Size(double.infinity, 28)),
                  //         child: Text(tr('profile_edit.share_profile'),
                  //             style: FontHelper.regualr_12_000000),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TabBar(
                indicatorColor: Colors.transparent,
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: _tabController.index == 0
                        ? Image.asset(
                            "assets/icons/profile_my_styleup.png",
                            width: 24,
                            height: 24,
                          )
                        : Image.asset("assets/icons/profile_my_styleup_off.png",
                            width: 24, height: 24),
                  ),
                  Tab(
                    icon: _tabController.index == 1
                        ? Image.asset("assets/icons/profile_my_bookmark.png",
                            width: 24, height: 24)
                        : Image.asset(
                            "assets/icons/profile_my_bookmark_off.png",
                            width: 24,
                            height: 24),
                  ),
                  Tab(
                    icon: _tabController.index == 1
                        ? Image.asset("assets/icons/profile_my_bookmark.png",
                            width: 24, height: 24)
                        : Image.asset(
                            "assets/icons/profile_my_bookmark_off.png",
                            width: 24,
                            height: 24),
                  ),
                ]),
            SizedBox(
              height: _tabController.index == 0
                  ? ((size.width / 3) * 20 / 13) *
                      ((getMyProfileProvider.myStyleupList.length) / 3).ceil()
                  : _tabController.index == 1
                      ? (((size.width / 3) * 20 / 13) *
                              ((getMyProfileProvider.myBookmarkList.length) / 3)
                                  .ceil()) +
                          48
                      : (((size.width / 3) * 20 / 13) *
                              ((getMyProfileProvider.myBookmarkList.length) / 3)
                                  .ceil()) +
                          48,
              child: TabBarView(controller: _tabController, children: [
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: getMyProfileProvider.myStyleupList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            PageRouteBuilderRightLeft(
                                child: StyleupScreen(
                              isMain: false,
                              initIndex: index,
                              styleupList: getMyProfileProvider.myStyleupList,
                            )));
                      },
                    );
                  },
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: getMyProfileProvider.myBookmarkList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              styleupList: getMyProfileProvider.myBookmarkList,
                            )));
                      },
                    );
                  },
                )
              ]),
            ),
            const SizedBox(height: 12),
            // pageAtCategory(),
          ],
        );
      });
    });
  }

  Widget pageAtCategory() {
    switch (tabIndex) {
      case 0:
      case 1:
      default:
        return Consumer<GetMyProfileProvider>(
          builder: (context, getMyProfileProvider, child) {
            int itemCount = 0;
            List<StyleupModel>? feedItems;
            if (tabIndex == 0) {
              itemCount = getMyProfileProvider.myStyleupList.length;
              feedItems = getMyProfileProvider.myStyleupList;
            } else if (tabIndex == 1) {
              itemCount = getMyProfileProvider.myBookmarkList.length;
              feedItems = getMyProfileProvider.myBookmarkList;
            }

            if (feedItems != null) {
              debugPrint(feedItems.length.toString());
            }

            return GridView.builder(
              shrinkWrap: true,
              itemCount: itemCount,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 13 / 20,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FeedItem(
                  item: feedItems![index],
                  onSelected: () {
                    Navigator.push(
                      context,
                      PageRouteBuilderRightLeft(
                        child: StyleupScreen(
                          isMain: false,
                          initIndex: index,
                          styleupList: feedItems!,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
    }
  }
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
