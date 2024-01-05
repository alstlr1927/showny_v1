import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/models/minishop_product_review_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/feed_item.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/tabs/home/screen/styleup_screen.dart';
import 'package:showny/screens/tabs/profile/my_profile/components/sv_inline_button.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_follower_screen.dart';
import 'package:showny/screens/tabs/profile/my_profile/screens/profile_following_screen.dart';
import 'package:showny/screens/tabs/profile/my_shop/components/my_shop_grid_item.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';

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
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildProfileInfo(user),
                      TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Tab(
                            icon: _tabController.index == 0
                                ? Image.asset(tab1)
                                : Image.asset(tab),
                          ),
                          Tab(
                            icon: _tabController.index == 1
                                ? Image.asset(tab2Selected)
                                : Image.asset(tab2),
                          ),
                        ],
                      ),
                      // Expanded(
                      //   child: true,
                      //   child: child)
                      // Expanded(
                      //   child:
                      SizedBox(
                        height: _tabController.index == 0
                            ? ((size.width / 3) * 20 / 13) *
                                ((styleupList.length) / 3).ceil()
                            : _tabController.index == 1
                                ? (((size.width / 3) * 28 / 13) *
                                        ((salingProductList.length) / 3)
                                            .ceil()) +
                                    48
                                : 0,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: styleupList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      MaterialPageRoute(
                                        builder: (context) => StyleupScreen(
                                          isMain: false,
                                          initIndex: index,
                                          styleupList: styleupList,
                                          afterUpDownAction: setStyleUpDown,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TabBar(
                                    isScrollable: true,
                                    indicator: BoxDecoration(),
                                    controller: _tabController2,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    labelPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    tabs: [
                                      Tab(
                                          child: Row(
                                        children: [
                                          Text(
                                            "전체",
                                            style: tabMode2 == 0
                                                ? themeData()
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    .apply(color: black)
                                                : themeData()
                                                    .textTheme
                                                    .titleSmall!
                                                    .apply(color: black),
                                          ),
                                          Container(
                                            height: 8,
                                            width: 1,
                                            color: Colors.black,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                          ),
                                        ],
                                      )),
                                      Tab(
                                          child: Row(
                                        children: [
                                          Text(
                                            "판매중",
                                            style: tabMode2 == 1
                                                ? themeData()
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    .apply(color: black)
                                                : themeData()
                                                    .textTheme
                                                    .titleSmall!
                                                    .apply(color: black),
                                          ),
                                          Container(
                                            height: 8,
                                            width: 1,
                                            color: Colors.black,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                          ),
                                        ],
                                      )),
                                      Tab(
                                          child: Row(
                                        children: [
                                          Text(
                                            "판매완료",
                                            style: tabMode2 == 2
                                                ? themeData()
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    .apply(color: black)
                                                : themeData()
                                                    .textTheme
                                                    .titleSmall!
                                                    .apply(color: black),
                                          ),
                                          Container(
                                            height: 8,
                                            width: 1,
                                            color: Colors.black,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                          ),
                                        ],
                                      )),
                                      Tab(
                                          child: Text(
                                        "판매후기",
                                        style: tabMode2 == 3
                                            ? themeData()
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold)
                                                .apply(color: black)
                                            : themeData()
                                                .textTheme
                                                .titleSmall!
                                                .apply(color: black),
                                      )),
                                    ]),
                                Expanded(
                                    child: TabBarView(
                                        controller: _tabController2,
                                        children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: allProductList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 1,
                                          crossAxisCount: 3,
                                          childAspectRatio: (size.width / 3) /
                                              (((size.width / 3) * 5 / 4) +
                                                  100),
                                        ),
                                        itemBuilder: (context, index) {
                                          return MyShopGridItem(
                                            brandName:
                                                allProductList[index].brand,
                                            title: allProductList[index].name,
                                            price:
                                                '${allProductList[index].price.formatPrice()}',
                                            imageUrl: allProductList[index]
                                                    .productImageUrlList
                                                    .isNotEmpty
                                                ? allProductList[index]
                                                    .productImageUrlList[0]
                                                : "",
                                            onTap: () {
                                              String productId =
                                                  allProductList[index].id ??
                                                      "";
                                              if (productId == "") {
                                                return;
                                              }
                                              // Navigator.push(
                                              //     context,
                                              //     PageRouteBuilderRightLeft(
                                              //         child:
                                              //             ProductDetailScreen(
                                              //       productId: productId,
                                              //     )));
                                            },
                                          );
                                        },
                                      ),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: salingProductList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 1,
                                          crossAxisCount: 3,
                                          childAspectRatio: (size.width / 3) /
                                              (((size.width / 3) * 5 / 4) +
                                                  100),
                                        ),
                                        itemBuilder: (context, index) {
                                          return MyShopGridItem(
                                            brandName:
                                                salingProductList[index].brand,
                                            title:
                                                salingProductList[index].name,
                                            price:
                                                '${salingProductList[index].price.formatPrice()}',
                                            imageUrl: salingProductList[index]
                                                    .productImageUrlList
                                                    .isNotEmpty
                                                ? salingProductList[index]
                                                    .productImageUrlList[0]
                                                : "",
                                            onTap: () {
                                              String productId =
                                                  saleCompleteProductList[index]
                                                      .id;
                                              if (productId == "") {
                                                return;
                                              }
                                              // Navigator.push(
                                              //     context,
                                              //     PageRouteBuilderRightLeft(
                                              //         child:
                                              //             ProductDetailScreen(
                                              //       productId: productId,
                                              //     )));
                                            },
                                          );
                                        },
                                      ),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 0,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 1,
                                          crossAxisCount: 3,
                                          childAspectRatio: (size.width / 3) /
                                              (((size.width / 3) * 5 / 4) +
                                                  100),
                                        ),
                                        itemBuilder: (context, index) {
                                          return MyShopGridItem(
                                            brandName:
                                                saleCompleteProductList[index]
                                                    .brand,
                                            title:
                                                saleCompleteProductList[index]
                                                    .name,
                                            price:
                                                '${saleCompleteProductList[index].price.formatPrice()}',
                                            imageUrl: saleCompleteProductList[
                                                        index]
                                                    .productImageUrlList
                                                    .isNotEmpty
                                                ? saleCompleteProductList[index]
                                                    .productImageUrlList[0]
                                                : "",
                                            onTap: () {
                                              String productId =
                                                  saleCompleteProductList[index]
                                                          .id ??
                                                      "";
                                              if (productId == "") {
                                                return;
                                              }
                                              // Navigator.push(
                                              //     context,
                                              //     PageRouteBuilderRightLeft(
                                              //         child:
                                              //             ProductDetailScreen(
                                              //       productId: productId,
                                              //     )));
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox()
                                    ]))
                              ],
                            )
                          ],
                        ),
                      )

                      // ),
                    ],
                  ),
                )),
    );
  }

  Widget _buildProfileInfo(UserModel user) {
    return Column(
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
          style: ShownyStyle.caption(
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
                  ApiHelper.shared.unFollowUser(user.memNo, otherProfile?.memNo,
                      (success) {
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
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
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
            Column(
              children: [
                SizedBox(
                  width: 80,
                  height: 24,
                  child: Text(
                    "${otherProfile?.postCount ?? 0}",
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 80,
                  height: 24,
                  child: Text(
                    "게시물",
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilderRightLeft(
                      child: ProfileFollowerScreen(
                          profileMemNo: otherProfile?.memNo),
                    )).then((value) {
                  setState(() {});
                });
              },
              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 24,
                    child: Text(
                      "${otherProfile?.followerCount ?? 0}",
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                    height: 24,
                    child: Text(
                      "팔로워",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilderRightLeft(
                        child: ProfileFollowingScreen(
                            profileMemNo: otherProfile?.memNo)));
              },
              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 24,
                    child: Text(
                      "${otherProfile?.followCount ?? 0}",
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                    height: 24,
                    child: Text(
                      "팔로잉",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
