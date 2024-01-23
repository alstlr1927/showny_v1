import 'package:easy_localization/easy_localization.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/main.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/app_bar_widget.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';

import '../../api/new_api/api_helper.dart';
import 'widgets/store_good_detail_basic_info_widget.dart';
import 'widgets/store_good_detail_boottom_widget.dart';
import 'widgets/store_good_detail_image_widget.dart';
import 'widgets/store_good_detail_more_style_widget.dart';
import 'widgets/store_good_detail_tab1_widget.dart';
import 'widgets/store_good_detail_tab2_widget.dart';
import 'widgets/store_good_detail_tab3_widget.dart';
import 'widgets/store_good_detail_tab4_widget.dart';
import 'widgets/store_good_detail_tab_widget.dart';

class StoreGoodDetailScreen extends StatefulWidget {
  final String goodsNo;

  const StoreGoodDetailScreen({super.key, required this.goodsNo});

  @override
  State<StoreGoodDetailScreen> createState() => _StoreGoodDetailScreen();
}

class _StoreGoodDetailScreen extends State<StoreGoodDetailScreen> {
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerBottom = ScrollController();

  StoreGoodModel? goodsData;
  int tabIndex = 0;

  GlobalKey tab1Key = GlobalKey();
  GlobalKey tab2Key = GlobalKey();
  GlobalKey tab3Key = GlobalKey();
  GlobalKey tab4Key = GlobalKey();

  final GlobalKey<ExtendedNestedScrollViewState> _key =
      GlobalKey<ExtendedNestedScrollViewState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getStoreGoodModel();
    });

    eventBus.on<StoreGoodModel>().listen((event) {
      setState(() {});
    });
  }

  getStoreGoodModel() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String memNo = user.memNo;

    ApiHelper.shared.getGoodsDetail(memNo, widget.goodsNo, (getStoreGoodModel) {
      setState(() {
        goodsData = getStoreGoodModel;

        Future.delayed(const Duration(milliseconds: 100), () {
          _key.currentState?.innerController.addListener(() {
            final RenderBox renderBox1 =
                tab1Key.currentContext!.findRenderObject() as RenderBox;
            final RenderBox renderBox2 =
                tab2Key.currentContext!.findRenderObject() as RenderBox;
            final RenderBox renderBox3 =
                tab3Key.currentContext!.findRenderObject() as RenderBox;
            // final RenderBox renderBox4 =
            //     tab4Key.currentContext!.findRenderObject() as RenderBox;

            final height1 = renderBox1.size.height;
            final height2 = renderBox1.size.height + renderBox2.size.height;
            final height3 = renderBox1.size.height +
                renderBox2.size.height +
                renderBox3.size.height;

            setState(() {
              if (_key.currentState!.innerController.offset < height1) {
                tabIndex = 0;
              } else if (_key.currentState!.innerController.offset < height2) {
                tabIndex = 1;
              } else if (_key.currentState!.innerController.offset < height3) {
                tabIndex = 2;
              } else {
                tabIndex = 3;
              }
            });
          });
        });
      });
    }, (error) {});
  }

  void scrollToTab(GlobalKey key) {
    double maxScrollExtent =
        _key.currentState?.outerController.position.maxScrollExtent ?? 0;

    if (_key.currentState == null) {
      return;
    }

    if (_key.currentState!.outerController.offset < maxScrollExtent) {
      _key.currentState?.outerController.animateTo(
        maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      Future.delayed(const Duration(milliseconds: 300), () {
        _key.currentState?.outerController.jumpTo(maxScrollExtent);
      });
    }

    Future.delayed(
        Duration(
            milliseconds:
                _key.currentState!.outerController.offset < maxScrollExtent
                    ? 301
                    : 0), () {
      _key.currentState?.innerPositions.forEach((position) {
        final RenderBox renderBox1 =
            tab1Key.currentContext!.findRenderObject() as RenderBox;
        final RenderBox renderBox2 =
            tab2Key.currentContext!.findRenderObject() as RenderBox;
        final RenderBox renderBox3 =
            tab3Key.currentContext!.findRenderObject() as RenderBox;
        // final RenderBox renderBox4 =
        //     tab4Key.currentContext!.findRenderObject() as RenderBox;

        double toPosition = 0;
        if (key == tab1Key) {
          toPosition = 0;
        } else if (key == tab2Key) {
          toPosition = renderBox1.size.height;
        } else if (key == tab3Key) {
          toPosition = renderBox1.size.height + renderBox2.size.height;
        } else if (key == tab4Key) {
          toPosition = renderBox1.size.height +
              renderBox2.size.height +
              renderBox3.size.height;
        }

        position.animateTo(toPosition,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      });
    });
  }

  void scrollAnimation(offset) {}

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBarWidget(
          title: tr("store.store"),
          rightImageUrl: shareIcon,
          rightOnTap: () {}),
      body: SafeArea(
        child: goodsData == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : goodsData?.memberRequestLink == ""
                ? Stack(children: [
                    ExtendedNestedScrollView(
                        key: _key,
                        physics: const ClampingScrollPhysics(),
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return <Widget>[
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  StoreGoodDetailImageWidget(
                                      goodsData: goodsData!),
                                  StoreGoodDetailBasicInfoWidget(
                                      goodsData: goodsData!),
                                  const Divider(
                                    height: 8,
                                    color: Color(0xFFF0F0F0),
                                    thickness: 8,
                                  ),
                                  StoreGoodDetailMoreStyleWidget(
                                      goodsData: goodsData!),
                                ],
                              ),
                            ),
                          ];
                        },
                        body: Column(
                          children: [
                            StoreGoodDetailTabWidget(
                                goodsData: goodsData!,
                                tabIndex: tabIndex,
                                onSelectedTab: (index) {
                                  setState(() {
                                    tabIndex = index;
                                    GlobalKey key = tab1Key;
                                    switch (tabIndex) {
                                      case 0:
                                        key = tab1Key;
                                        break;
                                      case 1:
                                        key = tab2Key;
                                        break;
                                      case 2:
                                        key = tab3Key;
                                        break;
                                      case 3:
                                        key = tab4Key;
                                        break;
                                      default:
                                        key = tab1Key;
                                        break;
                                    }
                                    scrollToTab(key);
                                  });
                                }),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  children: [
                                    StoreGoodDetailTab1Widget(
                                      key: tab1Key,
                                      goodsData: goodsData!,
                                    ),
                                    StoreGoodDetailTab2Widget(
                                      key: tab2Key,
                                      goodsData: goodsData!,
                                    ),
                                    StoreGoodDetailTab3Widget(
                                      key: tab3Key,
                                      goodsData: goodsData!,
                                    ),
                                    StoreGoodDetailTab4Widget(
                                      key: tab4Key,
                                      goodsData: goodsData!,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    goodsData == null
                        ? const SizedBox()
                        : Container(
                            alignment: Alignment.bottomCenter,
                            child: StoreGoodDetailBottomWidget(
                              goodsData: goodsData!,
                              selectHeart: () {
                                if (goodsData == null) {
                                  return;
                                }
                                if (goodsData!.isHeart == true) {
                                  goodsData!.heartCount -= 1;
                                } else {
                                  goodsData!.heartCount += 1;
                                }
                                StoreHelper.setHeartClick(
                                    context, user.memNo, goodsData!);
                              },
                            ),
                          )
                  ])
                : Stack(
                    children: [
                      SingleChildScrollView(
                          child: Column(
                        children: [
                          StoreGoodDetailImageWidget(goodsData: goodsData!),
                          StoreGoodDetailBasicInfoWidget(goodsData: goodsData!),
                          const Divider(
                            height: 8,
                            color: Color(0xFFF0F0F0),
                            thickness: 8,
                          ),
                          StoreGoodDetailMoreStyleWidget(goodsData: goodsData!),
                          const SizedBox(
                            height: 80,
                          )
                        ],
                      )),
                      goodsData == null
                          ? const SizedBox()
                          : Container(
                              alignment: Alignment.bottomCenter,
                              child: StoreGoodDetailBottomWidget(
                                goodsData: goodsData!,
                                selectHeart: () {
                                  if (goodsData == null) {
                                    return;
                                  }
                                  if (goodsData!.isHeart == true) {
                                    goodsData!.heartCount -= 1;
                                  } else {
                                    goodsData!.heartCount += 1;
                                  }
                                  StoreHelper.setHeartClick(
                                      context, user.memNo, goodsData!);
                                },
                              ),
                            )
                    ],
                  ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80, right: 16),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.16),
                blurRadius: 8,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                arrowUpIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: isSelected ? black : checkBoxColor),
      ),
    );
  }
}
