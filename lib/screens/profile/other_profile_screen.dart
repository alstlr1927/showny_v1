import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/minishop_product_review_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/profile/widgets/tab_other_shop.dart';
import 'package:showny/screens/profile/widgets/tab_profile_feed.dart';
import 'package:showny/screens/tabs/profile/my_profile/components/sv_inline_button.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_follower_screen.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_following_screen.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class OtherProfileScreen extends StatefulWidget {
  final String memNo;

  const OtherProfileScreen({Key? key, required this.memNo}) : super(key: key);

  static const routeName = "other_profile_screen";

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreen();
}

class _OtherProfileScreen extends State<OtherProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _tabController2;

  UserModel? otherProfile;
  List<StyleupModel> styleupList = [];
  List<MinishopProductModel> allProductList = [];
  List<MinishopProductModel> salingProductList = [];
  List<MinishopProductModel> saleCompleteProductList = [];
  List<MinishopProductReviewModel> reviewList = [];

  var isTabMode = 0;
  var tabMode2 = 0;
  var isFirst = true;
  var isLoading = false;

  final List<Map<String, dynamic>> _tabs = [
    {
      'on': "assets/icons/profile_my_styleup.png",
      'off': "assets/icons/profile_my_styleup_off.png",
    },
    {
      'on': "assets/icons/profile/my_store.png",
      'off': "assets/icons/profile/my_store_off.png",
    },
  ];

  @override
  void initState() {
    super.initState();

    getProfile();

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    ApiHelper.shared.getProfileStyleupList(widget.memNo, 2, 0, (styleupList) {
      setState(() {
        this.styleupList = styleupList;
      });
      // for (var i in styleupList) {
      //   print('type : ${i.upDownType}');
      // }
    }, (error) {});

    ApiHelper.shared.getMinishopProductList(widget.memNo, 2, 0,
        (allProductList) {
      setState(() {
        this.allProductList = allProductList;
      });
    }, (error) {});

    ApiHelper.shared.getMinishopProductList(widget.memNo, 0, 0,
        (salingProductList) {
      setState(() {
        this.salingProductList = salingProductList;
      });
    }, (error) {});

    ApiHelper.shared.getMinishopProductList(widget.memNo, 1, 0,
        (saleCompleteProductList) {
      setState(() {
        this.saleCompleteProductList = saleCompleteProductList;
      });
    }, (error) {});

    ApiHelper.shared.getMinishopProductReviewList(user.memNo, widget.memNo, 0,
        (reviewList) {
      setState(() {
        this.reviewList = reviewList;
      });
    }, (error) {});

    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          isTabMode = _tabController.index;
          print('set state');
        });
      });
    _tabController2 = TabController(length: 4, vsync: this)
      ..addListener(() {
        setState(() {
          tabMode2 = _tabController2.index;
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController2.dispose();
    super.dispose();
  }

  void getProfile() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    setState(() {
      if (isFirst == true) {
        isFirst = false;
        isLoading = true;
      }
    });
    ApiHelper.shared.getProfile(user.memNo, widget.memNo, (profile) {
      setState(() {
        isLoading = false;
        otherProfile = profile;
      });
    }, (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint(error);
    });
  }

  void setStyleUpDown({required String styleUpNo, required int value}) {
    int idx =
        styleupList.indexWhere((element) => element.styleupNo == styleUpNo);
    if (idx != -1) {
      styleupList[idx].upDownType = value;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          otherProfile?.memId ?? "",
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          // 뒤로 가기 이벤트 처리
          if (_tabController.index == 0) {
            // 현재 선택된 탭이 0번째 탭일 경우
            return true; // 뒤로 가기 이벤트를 허용
          } else {
            // 현재 선택된 탭이 1번째 탭일 경우
            _tabController.animateTo(0); // 첫 번째 탭으로 이동
            return false; // 뒤로 가기 이벤트를 차단
          }
        },
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : ExtendedNestedScrollView(
                floatHeaderSlivers: false,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                pinnedHeaderSliverHeightBuilder: () {
                  return 48.toWidth;
                },
                onlyOneScrollInBody: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    _buildProfileInfo(user),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate:
                          _TabPersistentHeaderDelegate(_tabController, _tabs),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    TabProfileFeed(
                        styleupList: styleupList,
                        afterUpDownAction: setStyleUpDown),
                    TabOtherShop(
                      allProductList: allProductList,
                      saleCompleteProductList: saleCompleteProductList,
                      salingProductList: salingProductList,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProfileInfo(UserModel user) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Center(
            child: Container(
              width: 88.toWidth,
              height: 88.toWidth,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    otherProfile?.profileImage != ""
                        ? otherProfile?.profileImage ?? ""
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
          ),
          const SizedBox(height: 15),
          Text(
            '${otherProfile?.nickNm}',
            style: ShownyStyle.body2(
                color: ShownyStyle.black, weight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Text(
              '${otherProfile?.introduce}',
              style: ShownyStyle.overline(
                  color: ShownyStyle.black, weight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SVInlineButton(
                strokeColor: otherProfile?.isFollow ?? false
                    ? ShownyStyle.mainPurple
                    : Colors.black,
                constraints:
                    BoxConstraints(minWidth: 80.toWidth, minHeight: 24.toWidth),
                onPressed: () {
                  setState(() {
                    otherProfile?.isFollow = !(otherProfile?.isFollow ?? false);
                  });
                  if (otherProfile?.isFollow ?? false) {
                    ApiHelper.shared.followUser(user.memNo, otherProfile?.memNo,
                        (success) {
                      getProfile();
                    }, (error) {});
                  } else {
                    ApiHelper.shared.unFollowUser(
                        user.memNo, otherProfile?.memNo, (success) {
                      getProfile();
                    }, (error) {});
                  }
                },
                text: (otherProfile?.isFollow ?? false) == true ? "팔로잉" : "팔로우",
                textColor: otherProfile?.isFollow ?? false
                    ? ShownyStyle.mainPurple
                    : Colors.white,
                backgroundColor: otherProfile?.isFollow ?? false
                    ? Colors.white
                    : ShownyStyle.mainPurple,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              ),
              SizedBox(width: 4.toWidth),
              Container(
                  height: 24.toWidth,
                  width: 24.toWidth,
                  decoration: BoxDecoration(
                      color: const Color(0xffefefef),
                      borderRadius: BorderRadius.circular(4)),
                  child: GestureDetector(
                    onTap: () {
                      if (otherProfile != null) {
                        // context
                        //     .read<ChatStyleProvider>()
                        //     .connectToServer(
                        //         otherUserId: otherProfile!.memNo,
                        //         type: "style");
                        // Navigator.push(
                        //     context,
                        //     PageRouteBuilderRightLeft(
                        //         child: StyleChatDetailScreen(
                        //       otherUserName: otherProfile!.nickNm,
                        //     )));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4.toWidth),
                      child: Image.asset(
                        'assets/icons/profile/dm_icon.png',
                        width: 16.toWidth,
                      ),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_tabController.index == 1) ...{
                _buildInfo(
                  count: 4.9,
                  title: '평점',
                  memNo: otherProfile?.memNo ?? '',
                ),
                _buildInfo(
                    count: 18,
                    title: '후기',
                    memNo: otherProfile?.memNo ?? '',
                    onPressed: () {
                      //
                    }),
              } else ...{
                _buildInfo(
                  count: otherProfile?.postCount ?? 0,
                  title: '게시물',
                  memNo: otherProfile?.memNo ?? '',
                ),
                _buildInfo(
                    count: otherProfile?.followerCount ?? 0,
                    title: '팔로워',
                    memNo: otherProfile?.memNo ?? '',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileFollowerScreen(
                                profileMemNo: otherProfile?.memNo),
                          )).then((value) {
                        setState(() {});
                      });
                    }),
                _buildInfo(
                    count: otherProfile?.followCount ?? 0,
                    title: '팔로잉',
                    memNo: otherProfile?.memNo ?? '',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileFollowingScreen(
                                profileMemNo: otherProfile?.memNo),
                          )).then((value) {
                        setState(() {});
                      });
                    }),
              },
            ],
          ),
        ],
      ),
    );
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
    return true;
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
                      width: 24.toWidth,
                      height: 24.toWidth,
                    )
                  : Image.asset(
                      _tabs[index]['off'],
                      width: 24.toWidth,
                      height: 24.toWidth,
                    ),
            );
          }),
        ),
      ),
    );
  }
}
