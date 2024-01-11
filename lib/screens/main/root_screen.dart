import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showny/components/lazy_indexed_stack/lazy_indexed_stack.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/screens/home/home_screen.dart';
import 'package:showny/screens/main/providers/main_landing_provider.dart';
import 'package:showny/screens/main/types/types.dart';

import 'package:showny/screens/profile/profile_screen.dart';
import 'package:showny/screens/upload/upload_wrapper.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class MainLanding extends StatefulWidget {
  const MainLanding({super.key, this.isChangeIndex});
  final bool? isChangeIndex;
  static String routeName = '/main_landing';

  @override
  State<MainLanding> createState() => MainLandingState();
}

class MainLandingState extends State<MainLanding> {
  int _currentIdx = 0;
  // late List<Widget> _tabs;

  var isFirstUse = true;
  static DateTime? _lastPressedAt;

  late MainLandingProvider provider;

  @override
  void initState() {
    super.initState();
    provider = MainLandingProvider(this);
    // _tabs = [
    //   const FeedScreen(),
    //   const SizedBox(),
    //   const SizedBox(),
    //   const SizedBox(),
    //   ProfileScreen(),
    // ];
    _lastPressedAt ??= DateTime.now().subtract(const Duration(seconds: 3));
    isFirstCheck();
    if (widget.isChangeIndex ?? false) {
      _currentIdx = 1;
    }
  }

  void isFirstCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirst = prefs.getBool("isFirstUse") ?? true;
    setState(() {
      isFirstUse = isFirst;
    });
    debugPrint("isFirst");
    debugPrint(isFirst.toString());
  }

  void setIsFirstUse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstUse", false);
  }

  getTabSelected(int idx) => _currentIdx == idx;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainLandingProvider>.value(
        value: provider,
        builder: (context, child) {
          return WillPopScope(
            onWillPop: () async {
              final now = DateTime.now();
              if (now.difference(_lastPressedAt!) >
                  const Duration(seconds: 2)) {
                _lastPressedAt = now;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('한번 더 뒤로가기를 누를 시 종료됩니다'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return false;
              }
              return true;
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Column(
                    children: [
                      Consumer<MainLandingProvider>(
                          builder: (ctx, prov, child) {
                        return Expanded(
                          child: IndexedStack(
                            index: prov.currentType.pageIndex,
                            children: [
                              HomeScreen(),
                              const SizedBox(),
                              const SizedBox(),
                              const SizedBox(),
                              ProfileScreen(),
                            ],
                          ),
                        );
                      }),
                      const _BottomActions(),
                    ],
                  ),
                  // Scaffold(
                  //   extendBody: false,
                  //   body:
                  //   // bottomNavigationBar: Container(
                  //   //   decoration: BoxDecoration(
                  //   //     color: Colors.white,
                  //   //     boxShadow: [
                  //   //       BoxShadow(
                  //   //         color: Colors.black.withOpacity(0.04),
                  //   //         blurRadius: 8.0,
                  //   //         offset: const Offset(0, -4),
                  //   //       )
                  //   //     ],
                  //   //   ),
                  //   //   child: SafeArea(
                  //   //     child: SizedBox(
                  //   //       height: 56,
                  //   //       child: Row(
                  //   //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   //         children: [
                  //   //           BottomTabButton(
                  //   //             icon: "home",
                  //   //             isSelected: getTabSelected(0),
                  //   //             onTap: () => setState(() => _currentIdx = 0),
                  //   //           ),
                  //   //           BottomTabButton(
                  //   //             icon: "feed",
                  //   //             isSelected: getTabSelected(1),
                  //   //             onTap: () => setState(() {
                  //   //               UserProvider userProvider =
                  //   //                   Provider.of<UserProvider>(context,
                  //   //                       listen: false);
                  //   //               final user = userProvider.user;

                  //   //               debugPrint(user.memNo);
                  //   //               if (user.memNo == "") {
                  //   //                 showModalBottomSheet(
                  //   //                     context: context,
                  //   //                     isScrollControlled: true,
                  //   //                     shape: const RoundedRectangleBorder(
                  //   //                       borderRadius: BorderRadius.only(
                  //   //                         topLeft: Radius.circular(12.0),
                  //   //                         topRight: Radius.circular(12.0),
                  //   //                       ),
                  //   //                     ),
                  //   //                     builder: (BuildContext context) {
                  //   //                       return const LoginPopupScreen();
                  //   //                     });
                  //   //                 return;
                  //   //               }
                  //   //               _currentIdx = 1;
                  //   //             }),
                  //   //           ),
                  //   //           BottomTabButton(
                  //   //             icon: "shop",
                  //   //             isSelected: getTabSelected(2),
                  //   //             onTap: () => setState(() => _currentIdx = 2),
                  //   //           ),
                  //   //           BottomTabButton(
                  //   //             icon: "networking",
                  //   //             isSelected: getTabSelected(3),
                  //   //             onTap: () => setState(() {
                  //   //               UserProvider userProvider =
                  //   //                   Provider.of<UserProvider>(context,
                  //   //                       listen: false);
                  //   //               final user = userProvider.user;

                  //   //               debugPrint(user.memNo);
                  //   //               if (user.memNo == "") {
                  //   //                 showModalBottomSheet(
                  //   //                     context: context,
                  //   //                     isScrollControlled: true,
                  //   //                     shape: const RoundedRectangleBorder(
                  //   //                       borderRadius: BorderRadius.only(
                  //   //                         topLeft: Radius.circular(12.0),
                  //   //                         topRight: Radius.circular(12.0),
                  //   //                       ),
                  //   //                     ),
                  //   //                     builder: (BuildContext context) {
                  //   //                       return const LoginPopupScreen();
                  //   //                     });
                  //   //                 return;
                  //   //               }
                  //   //               _currentIdx = 3;
                  //   //             }),
                  //   //           ),
                  //   //           BottomTabButton(
                  //   //             icon: "profile",
                  //   //             isSelected: getTabSelected(4),
                  //   //             onTap: () => setState(() => _currentIdx = 4),
                  //   //           ),
                  //   //         ],
                  //   //       ),
                  //   //     ),
                  //   //   ),
                  //   // ),
                  // ),
                  isFirstUse
                      ? SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.black.withOpacity(0.4),
                                alignment: Alignment.center,
                                child:
                                    Image.asset('assets/icons/init_guide.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isFirstUse = false;
                                    setIsFirstUse();
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      : const SizedBox(width: 0, height: 0)
                ],
              ),
            ),
          );
        });
  }
}

class _BottomActions extends StatefulWidget {
  const _BottomActions({Key? key}) : super(key: key);

  @override
  State<_BottomActions> createState() => __BottomActionsState();
}

class __BottomActionsState extends State<_BottomActions> {
  void scrollToTop() {
    final ScrollController? primaryScrollController =
        PrimaryScrollController.of(context);
    if (primaryScrollController != null && primaryScrollController.hasClients) {
      primaryScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutCirc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var sheetHeight = 44.toWidth + ShownyStyle.safeAreaPadding();
    return Consumer<MainLandingProvider>(builder: (ctx, prov, child) {
      return Stack(
        children: [
          Container(
            height: sheetHeight,
            padding: EdgeInsets.only(bottom: ShownyStyle.safeAreaPadding()),
            decoration: const BoxDecoration(
              color: ShownyStyle.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 3),
                    blurRadius: 8,
                    spreadRadius: 0),
                BoxShadow(
                    color: Color(0x08000000),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 0),
                BoxShadow(
                    color: Color(0x26000000),
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0)
              ],
            ),
            child: Builder(
              builder: (context) {
                MainLandingType type = prov.currentType;

                return Row(
                  children: [
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          bool isActive = type == MainLandingType.home;
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              if (isActive) {
                                scrollToTop();
                              } else {
                                prov.setPage(type: MainLandingType.home);
                              }
                            },
                            child: Column(
                              children: [
                                const Spacer(),
                                Image.asset(
                                  'assets/icons/bnb_home${isActive ? '_black' : ''}.png',
                                  width: 24,
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          bool isActive = type == MainLandingType.feed;
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              if (isActive) {
                                scrollToTop();
                              } else {
                                prov.setPage(type: MainLandingType.feed);
                              }
                            },
                            child: Column(
                              children: [
                                const Spacer(),
                                Image.asset(
                                  'assets/icons/bnb_feed${isActive ? '_black' : ''}.png',
                                  width: 24,
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          // bool isActive = type == MainLandingType.upload;
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              MainLandingType prev = prov.currentType;
                              prov.setPage(type: MainLandingType.upload);
                              Navigator.push(
                                context,
                                FadePageRoute(
                                  builder: (context) => const UploadWrapper(),
                                ),
                              ).then((value) {
                                prov.setPage(type: prev);
                              });
                              // if (isActive) {
                              //   scrollToTop();
                              // } else {
                              //   prov.setPage(type: MainLandingType.upload);
                              // }
                            },
                            child: Column(
                              children: [
                                const Spacer(),
                                Image.asset(
                                  'assets/icons/bnb_upload.png',
                                  width: 24,
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          bool isActive = type == MainLandingType.shop;
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              if (isActive) {
                                scrollToTop();
                              } else {
                                prov.setPage(type: MainLandingType.shop);
                              }
                            },
                            child: Column(
                              children: [
                                const Spacer(),
                                Image.asset(
                                  'assets/icons/bnb_shop${isActive ? '_black' : ''}.png',
                                  width: 24,
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          bool isActive = type == MainLandingType.profile;
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              if (isActive) {
                                scrollToTop();
                              } else {
                                prov.setPage(type: MainLandingType.profile);
                              }
                            },
                            child: Column(
                              children: [
                                const Spacer(),
                                Image.asset(
                                  'assets/icons/bnb_profile${isActive ? '_black' : ''}.png',
                                  width: 24,
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
