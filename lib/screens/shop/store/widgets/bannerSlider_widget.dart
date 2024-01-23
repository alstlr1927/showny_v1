import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/theme.dart';

import '../../../../../utils/colors.dart';
import '../providers/mini_shop_banner_provider.dart';

class BannerSliderWidget extends StatefulWidget {
  final int index;

  const BannerSliderWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<BannerSliderWidget> createState() => _BannerSliderWidgetState();
}

class _BannerSliderWidgetState extends State<BannerSliderWidget> {
  int currentIndex = 1;
  // List image = [
  //   splash,
  //   adidasLogo,
  //   product1,
  //   product2,
  //   product3,
  //   product4,
  // ];

  getBanner() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Provider.of<MiniShopBannerProvider>(context, listen: false)
        .getBannerList(user.memId, "0");
  }

  getMiniShopBanner() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    Provider.of<MiniShopBannerProvider>(context, listen: false)
        .getMiniShopBannerData(user.memId, "0");
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getBanner();
      getMiniShopBanner();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<MiniShopBannerProvider>(
      builder: (context, bannerProvider, child) => Stack(
        children: [
          CarouselSlider.builder(
            itemCount:
                // image.length,
                widget.index == 0
                    ? (bannerProvider.getBannerMiniShopModel?.data ?? []).length
                    : (bannerProvider.getBannerListResponseModel?.data ?? [])
                        .length,
            itemBuilder: (context, index, realIndex) {
              return
                  // Image.asset(image[index]);
                  widget.index == 0
                      ? bannerProvider.getIsMiniShopBannerLoading()
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: Image.network(
                                "${bannerProvider.getBannerMiniShopModel!.data![index].bannerImg}",
                                fit: BoxFit.fitWidth,
                                width: size.width,
                                height: size.height,
                              ),
                            )
                      : bannerProvider.getIsBannerLoading()
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: Image.network(
                                bannerProvider.getBannerListResponseModel!
                                    .data![index].bannerImg
                                    .toString(),
                                fit: BoxFit.fitWidth,
                                width: size.width,
                                height: size.height,
                              ),
                            );
            },
            options: CarouselOptions(
              height: 240,
              viewportFraction: 1,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index + 1;
                });
              },
            ),
          ),
          Positioned(
            right: 12,
            bottom: 15,
            child: Container(
              height: 24,
              width: 48,
              decoration: BoxDecoration(
                color: black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$currentIndex',
                    style:
                        themeData().textTheme.bodySmall!.copyWith(color: white),
                  ),
                  // Text(
                  //   ' / ${image.length}',
                  //   style: themeData()
                  //       .textTheme
                  //       .labelMedium
                  //       ?.apply(color: white),
                  // ),
                  (widget.index == 0)
                      ? Text(
                          ' / ${(bannerProvider.getBannerMiniShopModel?.data ?? []).length}',
                          style: themeData()
                              .textTheme
                              .bodySmall!
                              .copyWith(color: white),
                        )
                      : Text(
                          ' / ${(bannerProvider.getBannerListResponseModel?.data ?? []).length}',
                          style: themeData()
                              .textTheme
                              .bodySmall!
                              .copyWith(color: white),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
