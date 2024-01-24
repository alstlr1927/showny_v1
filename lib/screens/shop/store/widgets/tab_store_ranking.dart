import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../components/page_route.dart';
import '../../../../models/brand_search_model.dart';
import '../../../../models/get_storelist_response_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/showny_style.dart';
import '../../../../utils/theme.dart';
import '../../../../widgets/common_button_widget.dart';
import '../brand_search_screen.dart';
import '../providers/store_provider.dart';
import '../store_good_detail_screen.dart';
import '../store_goods_list_screen.dart';

class TabStoreRanking extends StatefulWidget {
  const TabStoreRanking({super.key});

  @override
  State<TabStoreRanking> createState() => _TabStoreRankingState();
}

class _TabStoreRankingState extends State<TabStoreRanking> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverTween(
          child: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.toWidth),
                _buildBrandTitle(),
                SizedBox(height: 20.toWidth),
                _buildRankingList(),
                SizedBox(height: 24),
                _buildMoreBrandButton(),
                SizedBox(height: 40),
                _buildProductTitle(),
                SizedBox(height: 24),
                // _buildProductRankingGrid(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          child: Text(
            tr("brand.brand_ranking_list"),
            style: ShownyStyle.body2(
                color: ShownyStyle.black, weight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.toWidth),
          child: Text(
            tr("brand.Check_out_our_top_selling_brands"),
            style: ShownyStyle.overline(
              color: ShownyStyle.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRankingList() {
    return Consumer<StoreProvider>(
      builder: (context, provider, child) =>
          provider.getIsStoreMainDataLoading()
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: provider
                      .getStoreMainPageData()!
                      .data!
                      .brandRankingList!
                      .length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _BrandRankingListItem(
                      item: provider
                          .getStoreMainPageData()!
                          .data!
                          .brandRankingList![index],
                    );
                  },
                ),
    );
  }

  Widget _buildMoreBrandButton() {
    return CommonButtonWidget(
      text: "더 많은 브랜드 보기",
      radius: 10,
      height: 48,
      color: black,
      onTap: () {
        // var filterProvider =
        //     Provider.of<StoreDetailFilterProvider>(context, listen: false);
        // var provider = Provider.of<StoreProvider>(context, listen: false);
        // var selected =
        //     provider.getStoreMainPageData()!.data!.brandRankingList![0];
        // filterProvider.setSelectedBrand(BrandData(
        //     cateCd: selected.brandCd!,
        //     cateNm: selected.brandNm!,
        //     brandImgUrl: selected.brandImage!));
        Navigator.push(
            context,
            ShownyPageRoute(
              builder: (context) => BrandSearchScreen(
                selectBrand: (selectBrandData) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    moveStoreDetailWithBrand(context, selectBrandData);
                  });
                },
              ),
            ));
      },
    );
  }

  Widget _buildProductTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 24,
            child: Text(
              tr("brand.see_more_brands"),
              style: themeData().textTheme.titleMedium,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            tr("brand.most_sold_products"),
            style: themeData().textTheme.labelSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildProductRankingGrid() {
    return Consumer<StoreProvider>(
      builder: (context, value, child) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              value.getStoreMainPageData()?.data?.goodsRankingList?.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 16, right: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: ((((ScreenUtil().screenWidth - 48) / 2)) /
                  (((ScreenUtil().screenWidth - 48) / 2) + 190))),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if (value
                      .getStoreMainPageData()
                      ?.data
                      ?.goodsRankingList![index]
                      .goodsNo ==
                  null) {
                return;
              }
              Navigator.push(
                  context,
                  ShownyPageRoute(
                    builder: (context) => StoreGoodDetailScreen(
                        goodsNo: value
                                .getStoreMainPageData()
                                ?.data
                                ?.goodsRankingList![index]
                                .goodsNo ??
                            ""),
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: ((ScreenUtil().screenWidth - 48) / 2) * 5 / 4,
                      width: ((ScreenUtil().screenWidth - 48) / 2),
                      decoration: BoxDecoration(
                          color: greyExtraLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.network(
                          value
                                  .getStoreMainPageData()
                                  ?.data
                                  ?.goodsRankingList![index]
                                  .goodsImageUrlList[0] ??
                              "",
                          width: ((ScreenUtil().screenWidth - 48) / 2),
                          height: ((ScreenUtil().screenWidth - 48) / 2) * 5 / 4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(lable),
                          ),
                        ),
                        child: Center(
                            child: Text("${index + 1}위",
                                style: themeData()
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: white))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  value
                          .getStoreMainPageData()
                          ?.data
                          ?.goodsRankingList?[index]
                          .brandNm ??
                      "",
                  style: themeData().textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  value
                          .getStoreMainPageData()
                          ?.data
                          ?.goodsRankingList?[index]
                          .goodsNm ??
                      "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: themeData().textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${(value.getStoreMainPageData()?.data?.goodsRankingList?[index].goodsPrice ?? 0).formatPrice()} 원',
                  style: themeData().textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "즉시 구매가",
                  style:
                      themeData().textTheme.bodySmall!.apply(color: textColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.asset(unselectedHeartIcon, height: 16, width: 16),
                    SizedBox(
                      width: ScreenUtil().screenWidth * 0.01,
                    ),
                    Text(
                      (value
                                  .getStoreMainPageData()
                                  ?.data
                                  ?.goodsRankingList?[index]
                                  .heartCount ??
                              0)
                          .toString(),
                      style: themeData()
                          .textTheme
                          .bodySmall!
                          .apply(color: textColor),
                    ),
                    SizedBox(
                      width: ScreenUtil().screenWidth * 0.02,
                    ),
                    Image.asset(heartReport),
                    SizedBox(
                      width: ScreenUtil().screenWidth * 0.01,
                    ),
                    Text(
                      (value
                                  .getStoreMainPageData()
                                  ?.data
                                  ?.goodsRankingList?[index]
                                  .reviewCount ??
                              0)
                          .toString(),
                      style: themeData()
                          .textTheme
                          .bodySmall!
                          .apply(color: textColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void moveStoreDetailWithBrand(BuildContext context, BrandData brandData) {
    Navigator.push(
        context,
        ShownyPageRoute(
          builder: (context) => StoreGoodsListScreen(
              mainCategory: 2, subCategory: 0, brandData: brandData),
        ));
  }
}

class _BrandRankingListItem extends StatelessWidget {
  final BrandRankingList item;
  const _BrandRankingListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var selected = item;
        Navigator.push(
            context,
            ShownyPageRoute(
              builder: (context) => StoreGoodsListScreen(
                  mainCategory: 2,
                  subCategory: 0,
                  brandData: BrandData(
                    cateNm: selected.brandNm!,
                    cateCd: selected.brandCd!,
                    brandImgUrl: selected.brandImage!,
                  )),
            ));
      },
      child: Container(
        width: double.infinity,
        color: white,
        child: Row(
          children: [
            Text(
              "${item.rank}",
              style: ShownyStyle.caption(color: Color(0xff777777)),
            ),
            SizedBox(
              width: ScreenUtil().screenWidth * 0.03,
            ),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                border: Border.all(color: greyExtraLight),
                shape: BoxShape.circle,
              ),
              child: Image.network("${item.brandImage}"),
            ),
            SizedBox(
              width: ScreenUtil().screenWidth * 0.03,
            ),
            Text(
              "${item.brandNm}",
              style: ShownyStyle.caption(color: Color(0xff777777)),
            ),
            const Spacer(),
            Text("${item.upDown}", style: themeData().textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
