import 'package:easy_localization/easy_localization.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/intro/screen/login_screen.dart';
import 'package:showny/screens/profile/temp_setting.dart';
import 'package:showny/screens/profile/widgets/tab_profile_bookmark.dart';
import 'package:showny/screens/profile/widgets/tab_profile_feed.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_follower_screen.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_following_screen.dart';
import 'package:showny/screens/profile/widgets/tab_my_shop.dart';
import 'package:showny/screens/tabs/profile/myshopping/pages/my_shopping_page.dart';
import 'package:showny/screens/profile/widgets/profile_not_logged_in_screen.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import '../../models/user_model.dart';
import '../../utils/images.dart';
import '../tabs/profile/profile_tab_button.dart';

class ProfileScreen extends StatefulWidget {
  bool? isBack = false;

  ProfileScreen({Key? key, this.category, this.isBack}) : super(key: key);
  final ProfilePageCategory? category;
  static const routeName = "profile_screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  static const storage = FlutterSecureStorage();
  late TabController _tabController;

  final List<Map<String, dynamic>> _tabs = [
    {
      'on': "assets/icons/profile_my_styleup.png",
      'off': "assets/icons/profile_my_styleup_off.png",
    },
    {
      'on': "assets/icons/profile/my_store.png",
      'off': "assets/icons/profile/my_store_off.png",
    },
    {
      'on': "assets/icons/profile_my_bookmark.png",
      'off': "assets/icons/profile_my_bookmark_off.png",
    },
  ];

  void logout() async {
    await storage.delete(key: 'email');
    await storage.delete(key: 'password');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    }
  }

  ProfilePageCategory? category;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    category = widget.category ?? ProfilePageCategory.myProfile;
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        setState(() {
          tabIndex = _tabController.index;
        });
      });
    Provider.of<GetMyProfileProvider>(context, listen: false)
        .getProfileData(context);
    Provider.of<GetMyProfileProvider>(context, listen: false)
        .getMyStyleupList(context);
    Provider.of<GetMyProfileProvider>(context, listen: false)
        .getMyBookmarkList(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    debugPrint(user.memNo);
    if (user.memNo == "") {
      return const ProfileNotLoggedInScreen();
    }

    return Scaffold(
      appBar: _buildAppbar(user),
      body: Stack(
        children: [
          ExtendedNestedScrollView(
            floatHeaderSlivers: false,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            pinnedHeaderSliverHeightBuilder: () {
              final double tabbarSize = 48.toWidth;

              return tabbarSize;
            },
            onlyOneScrollInBody: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 12,
                  ),
                ),
                _ProfileInfo(tabController: _tabController),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabPersistentHeaderDelegate(_tabController, _tabs),
                ),
              ];
            },
            body: Consumer2<GetMyProfileProvider, UserProvider>(
                builder: (ctx, profileProvider, userProvider, child) {
              return TabBarView(
                controller: _tabController,
                children: [
                  TabProfileFeed(
                    styleupList: profileProvider.myStyleupList,
                    afterUpDownAction: profileProvider.setStyleUpDown,
                  ),
                  const TabMyShop(),
                  TabProfileBookmark(
                      bookmarkList: profileProvider.myBookmarkList)
                ],
              );
            }),
            // body: MyProfileTabView(tabController: _tabController),
          ),
          // if (category == ProfilePageCategory.myProfile ||
          //     category == ProfilePageCategory.myShop) ...[
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           FloatingActionButton(
          //             backgroundColor: Colors.white,
          //             foregroundColor: Colors.black,
          //             child: const Icon(Icons.camera_alt),
          //             onPressed: () {
          //               //   Navigator.push(
          //               //         context,
          //               //         PageRouteBuilderRightLeft(
          //               //             child: UploadContentScreen(
          //               //         onCompleted: () {
          //               //           Provider.of<GetMyProfileProvider>(context, listen: false).getProfileData(context);
          //               //           Provider.of<GetMyProfileProvider>(context, listen: false).getMyStyleupList(context);
          //               //           Provider.of<GetMyProfileProvider>(context, listen: false).getMyBookmarkList(context);
          //               // })));
          //             },
          //           ),
          //         ],
          //       ),
          //       const SizedBox(height: 28),
          //     ],
          //   ),
          // ],
          // 주문하기 버튼
          // category == ProfilePageCategory.myShopping &&
          //         (Provider.of<RequestReturnProvider>(context).selectedIndex ==
          //             0)
          //     ? Positioned(
          //         bottom: 10,
          //         left: 16,
          //         right: 16,
          //         child: Consumer<GetStoreCartListProvider>(
          //             builder: (context, getStoreCartListProvider, child) =>
          //                 SizedBox()
          //             // CommonButtonWidget(
          //             //   text: tr('my_profile.btn_text'),
          //             //   radius: 12,
          //             //   height: 48,
          //             //   color: !getStoreCartListProvider.checkFalse() ? grey444 : black,
          //             //   textcolor: white,
          //             //   onTap: !getStoreCartListProvider.checkFalse()
          //             //       ? null
          //             //       : () {
          //             // List<cartResponse.Data> newList =
          //             // getStoreCartListProvider
          //             //     .getProducts()
          //             //     .where((i) => (i.isSelected ?? false))
          //             //     .toList();
          //             // context
          //             //     .read<OrderFormProvider>()
          //             //     .setCartProducts(newList);
          //             // Navigator.push(
          //             //     context,
          //             //     MaterialPageRoute(
          //             //       builder: (context) => const OrderFormScreen(),
          //             //     ));
          //             //   },
          //             // ),
          //             ),
          //       )
          //     : Container(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(UserModel user) {
    return AppBar(
      title: Text(
        user.memId,
        style: ShownyStyle.body1(
          color: ShownyStyle.black,
          weight: FontWeight.w600,
        ),
      ),
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: widget.isBack == true
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  arrowBackward,
                  height: 18,
                  width: 9,
                ),
              ),
            )
          : Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        ShownyPageRoute(
                            builder: (context) => const MyShoppingPage(),
                            settings: const RouteSettings(
                                name: PageName.MY_SHOPPING)));
                  },
                  child: Image.asset(
                    'assets/icons/profile/shopping_list.png',
                    height: 20.toWidth,
                  ),
                ),
              ],
            ),
      actions: [
        CupertinoButton(
          minSize: 0.0,
          padding: EdgeInsets.symmetric(horizontal: 7.toWidth),
          onPressed: () {
            // Navigator.push(
            //     context, PageRouteBuilderRightLeft(
            //     child: const SettingPage()));
          },
          child: Image.asset(
            'assets/icons/profile/msg_icon.png',
            width: 24.0,
            height: 24.0,
          ),
        ),
        CupertinoButton(
          minSize: 0.0,
          padding: EdgeInsets.symmetric(horizontal: 7.toWidth),
          onPressed: () {
            Navigator.push(
                context,
                ShownyPageRoute(
                  builder: (context) => const TempSetting(),
                ));
            // Navigator.push(
            //     context, PageRouteBuilderRightLeft(
            //     child: const SettingPage()));
          },
          child: Image.asset(
            'assets/icons/profile/noti_icon.png',
            width: 24.0,
            height: 24.0,
          ),
        ),
        CupertinoButton(
          minSize: 0.0,
          padding: EdgeInsets.only(right: 16.toWidth, left: 7.toWidth),
          onPressed: () {
            // Navigator.push(
            //     context, PageRouteBuilderRightLeft(
            //     child: const SettingPage()));
          },
          child: Image.asset(
            'assets/icons/profile/more_icon.png',
            width: 24.0,
            height: 24.0,
          ),
        ),
      ],
    );
  }

  // Widget pageAtCategory() {
  //   switch (category!) {
  //     case ProfilePageCategory.myProfile:
  //       return const MyProfileScreen();
  //     case ProfilePageCategory.myShop:
  //       return const MyShopScreen();
  //     case ProfilePageCategory.myShopping:
  //       return const MyShoppingPage();
  //   }
  // }
}

enum ProfilePageCategory with CategoryMixin {
  myProfile,
  myShop,
  myShopping;

  @override
  String get name {
    switch (this) {
      case ProfilePageCategory.myProfile:
        return "내 프로필";
      case ProfilePageCategory.myShop:
        return "내 상점";
      case ProfilePageCategory.myShopping:
        return "내 쇼핑";
    }
  }
}

class _ProfileInfo extends StatelessWidget {
  final TabController tabController;
  const _ProfileInfo({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (ctx, userProvider, child) {
      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 14),
            ProfileContainer.size84(
              url: userProvider.user.profileImage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {
                    //           // Navigator.push(
                    //           //     context,
                    //           //     PageRouteBuilderRightLeft(
                    //           //         child: EditProfileScreen(
                    //           //       disposed: () => WidgetsBinding.instance
                    //           //           .addPostFrameCallback(
                    //           //               (_) => setState(() {})),
                    //           //     )));
                  },
                  child: Image.asset(
                    'assets/icons/profile/profile_edit.png',
                    width: 16.toWidth,
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    Share.share(
                        'https://www.instagram.com/outfitbattles_korea/');
                  },
                  child: Image.asset(
                    'assets/icons/profile/profile_share.png',
                    width: 16.toWidth,
                  ),
                ),
              ],
            ),
            Text(
              userProvider.user.nickNm,
              style: ShownyStyle.body2(
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
                    if (tabController.index == 1) ...{
                      _buildInfo(
                        title: '평점',
                        count: 4.9,
                        memNo: userProvider.user.memNo,
                      ),
                      _buildInfo(
                        title: '후기',
                        count: 18,
                        memNo: userProvider.user.memNo,
                      ),
                      // _buildInfo(
                      //     title: '',
                      //     count: userProvider.user.followCount.toDouble(),
                      //     memNo: userProvider.user.memNo,
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           PageRouteBuilderRightLeft(
                      //               child: ProfileFollowingScreen(
                      //             profileMemNo: userProvider.user.memNo,
                      //           )));
                      //     }),
                    } else ...{
                      _buildInfo(
                        title: tr('profile_2.post'),
                        count: userProvider.user.postCount,
                        memNo: userProvider.user.memNo,
                      ),
                      _buildInfo(
                          title: tr('profile_screen.followers'),
                          count: userProvider.user.followerCount,
                          memNo: userProvider.user.memNo,
                          onPressed: () {
                            Navigator.push(
                              context,
                              ShownyPageRoute(
                                builder: (context) => ProfileFollowerScreen(
                                    profileMemNo: userProvider.user.memNo),
                              ),
                            );
                          }),
                      _buildInfo(
                          title: tr(
                              'product_detail.seller_information.following_text'),
                          count: userProvider.user.followCount,
                          memNo: userProvider.user.memNo,
                          onPressed: () {
                            Navigator.push(
                              context,
                              ShownyPageRoute(
                                builder: (context) => ProfileFollowingScreen(
                                  profileMemNo: userProvider.user.memNo,
                                ),
                              ),
                            );
                          }),
                    },
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfo({
    required num count,
    required String title,
    required String memNo,
    VoidCallback? onPressed,
  }) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          width: 65.toWidth,
          height: 46,
          child: Column(
            children: [
              Text(
                '$count',
                style: ShownyStyle.body2(
                    weight: FontWeight.w600, color: ShownyStyle.black),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                title,
                style: ShownyStyle.overline(
                    weight: FontWeight.w400, color: ShownyStyle.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _TabPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController _tabController;
  final List<Map<String, dynamic>> _tabs;

  _TabPersistentHeaderDelegate(this._tabController, this._tabs);

  @override
  double get maxExtent => 48.toWidth;

  @override
  double get minExtent => 48.toWidth;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 48.toWidth,
        color: Colors.white,
        child: TabBar(
          // isScrollable: true,
          indicatorColor: Colors.black,
          physics: const BouncingScrollPhysics(),
          automaticIndicatorColorAdjustment: true,
          controller: _tabController,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2,
          unselectedLabelStyle: TextStyle(color: Colors.black.withOpacity(.3)),
          tabs: List.generate(_tabs.length, (index) {
            return Tab(
              icon: _tabController.index == index
                  ? Image.asset(
                      _tabs[index]['on'],
                      width: 24,
                      height: 24,
                    )
                  : Image.asset(
                      _tabs[index]['off'],
                      width: 24,
                      height: 24,
                    ),
            );
          }),
        ),
      ),
    );
  }
}
