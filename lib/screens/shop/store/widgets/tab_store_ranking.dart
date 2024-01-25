import 'package:dartx/dartx.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../components/page_route.dart';
import '../../../../models/brand_search_model.dart';
import '../../../../models/get_storelist_response_model.dart';
import '../../../../models/store_good_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/showny_style.dart';
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
                SizedBox(height: 8.toWidth),
                _buildMoreBrandButton(),
                SizedBox(height: 24.toWidth),
                _buildProductTitle(),
                SizedBox(height: 24),
                _buildProductRankingGrid(),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
      child: ShownyButton(
        onPressed: () {
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
        option: ShownyButtonOption.fill(
          text: '더 많은 브랜드 보기',
          theme: ShownyButtonFillTheme.violet,
          style: ShownyButtonFillStyle.fullRegular,
        ),
      ),
    );
    // return CommonButtonWidget(
    //   text: "더 많은 브랜드 보기",
    //   radius: 10,
    //   height: 48,
    //   color: black,
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         ShownyPageRoute(
    //           builder: (context) => BrandSearchScreen(
    //             selectBrand: (selectBrandData) {
    //               Future.delayed(const Duration(milliseconds: 500), () {
    //                 moveStoreDetailWithBrand(context, selectBrandData);
    //               });
    //             },
    //           ),
    //         ));
    //   },
    // );
  }

  Widget _buildProductTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          child: Text(
            tr("brand.see_more_brands"),
            style: ShownyStyle.body2(
                color: ShownyStyle.black, weight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.toWidth),
          child: Text(
            tr("brand.most_sold_products"),
            style: ShownyStyle.overline(
              color: ShownyStyle.black,
            ),
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
          padding: EdgeInsets.only(left: 16.toWidth, right: 16.toWidth),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.toWidth,
            childAspectRatio: 170 / 335,
          ),
          itemBuilder: (context, index) {
            return _ProductRankingListItem(
                index: index,
                item: value
                    .getStoreMainPageData()
                    ?.data
                    ?.goodsRankingList?[index]);
          },
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
      ),
    );
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
    return Padding(
      padding: EdgeInsets.only(bottom: 16.toWidth),
      child: GestureDetector(
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
              SizedBox(
                width: 18.toWidth,
                child: Text(
                  "${item.rank}",
                  style: ShownyStyle.caption(color: Color(0xff777777)),
                ),
              ),
              SizedBox(width: 6.toWidth),
              Container(
                height: 32.toWidth,
                width: 32.toWidth,
                decoration: BoxDecoration(
                    color: ShownyStyle.white,
                    border: Border.all(color: greyExtraLight),
                    shape: BoxShape.circle,
                    boxShadow: ShownyStyle.elevation_01dp()),
                child: Image.network("${item.brandImage}"),
              ),
              SizedBox(width: 12.toWidth),
              Text(
                "${item.brandNm}",
                style: ShownyStyle.caption(color: Color(0xff777777)),
              ),
              const Spacer(),
              _getBrandUpDownString('${item.upDown}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBrandUpDownString(String val) {
    int valToInt = 0;
    String text = '';

    Color color = Colors.black;
    try {
      valToInt = val.toInt();
    } catch (e) {
      valToInt = 0;
    }

    if (valToInt == 0) {
      text = '-';
    } else if (valToInt > 0) {
      text = '${valToInt}↑';
      color = ShownyStyle.mainRed;
    } else if (valToInt < 0) {
      text = '${valToInt.abs()}↓';
      color = ShownyStyle.mainPurple;
    }

    return Text(
      text,
      style: ShownyStyle.caption(color: color),
    );
  }
}

class _ProductRankingListItem extends StatelessWidget {
  final StoreGoodModel? item;
  final int index;
  const _ProductRankingListItem({
    Key? key,
    this.item,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item?.goodsNo == null) {
          return;
        }
        Navigator.push(
            context,
            ShownyPageRoute(
              builder: (context) =>
                  StoreGoodDetailScreen(goodsNo: item?.goodsNo ?? ""),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item?.goodsImageUrlList[0] ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 10.toWidth,
                child: Container(
                  width: 30.toWidth,
                  height: 30.toWidth,
                  padding: EdgeInsets.only(bottom: 8.toWidth),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(lable),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}위",
                      style: ShownyStyle.overline(
                          color: ShownyStyle.white, weight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.toWidth),
          Text(
            item?.brandNm ?? "",
            style: ShownyStyle.caption(
                color: ShownyStyle.black, weight: FontWeight.w600),
          ),
          SizedBox(height: 4.toWidth),
          Text(
            item?.goodsNm ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: ShownyStyle.caption(color: ShownyStyle.black),
          ),
          SizedBox(height: 8.toWidth),
          Text(
            '${(item?.goodsPrice ?? 0).formatPrice()} 원',
            style: ShownyStyle.body2(
                color: ShownyStyle.black, weight: FontWeight.w700),
          ),
          SizedBox(height: 2.toWidth),
          Text(
            "즉시 구매가",
            style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
          ),
          SizedBox(height: 4.toWidth),
          Row(
            children: [
              Image.asset('assets/icons/shop/heart_icon.png',
                  height: 14.toWidth, width: 14.toWidth),
              SizedBox(width: 4.toWidth),
              Text(
                (item?.heartCount ?? 0).toString(),
                style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
              ),
              SizedBox(width: 8.toWidth),
              Image.asset('assets/icons/shop/grade_icon.png',
                  height: 14.toWidth, width: 14.toWidth),
              SizedBox(width: 4.toWidth),
              Text(
                '${item?.grade}(${item?.reviewCount})',
                style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
