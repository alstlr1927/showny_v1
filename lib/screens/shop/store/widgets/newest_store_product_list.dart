import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/shop/store/providers/store_tab_home_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../components/page_route.dart';
import '../../../../models/store_good_model.dart';
import '../store_good_detail_screen.dart';

class NewestStoreProductList extends StatelessWidget {
  const NewestStoreProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreTabHomeProvider>(
      builder: (context, prov, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...Category.values.map((item) {
              return _NewestProuctList(
                title: item.name,
                newestList: _getNewest(prov, item),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  List<StoreGoodModel> _getNewest(StoreTabHomeProvider prov, Category item) {
    switch (item.code) {
      case '001':
        return prov.outerList;
      case '002':
        return prov.topList;
      case '003':
        return prov.bottomList;
      case '004':
        return prov.shoesList;
      case '005':
        return prov.accessoryList;
      case '006':
        return prov.stuffList;
      default:
        return [];
    }
  }
}

class _NewestProuctList extends StatefulWidget {
  final String title;
  final List<StoreGoodModel> newestList;
  const _NewestProuctList({
    Key? key,
    required this.title,
    required this.newestList,
  }) : super(key: key);

  @override
  State<_NewestProuctList> createState() => __NewestProuctListState();
}

class __NewestProuctListState extends State<_NewestProuctList> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.newestList.isEmpty) {
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          child: Text(
            widget.title,
            style: ShownyStyle.body2(weight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 14.toWidth),
        SizedBox(
          height: 215.toWidth,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                widget.newestList.length > 6 ? 6 : widget.newestList.length,
            itemBuilder: (context, index) {
              StoreGoodModel item = widget.newestList[index];
              if (item.goodsImageUrlList.isEmpty) {
                return SizedBox();
              }
              return BaseButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      ShownyPageRoute(
                        builder: (context) =>
                            StoreGoodDetailScreen(goodsNo: item.goodsNo),
                      ));
                },
                child: Container(
                  width: 130.toWidth,
                  margin: EdgeInsets.only(right: 14.toWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ShownyImage(
                            imageUrl: item.goodsImageUrlList.first,
                            fit: BoxFit.cover,
                          ),
                          // child: Image.network(
                          //   item.goodsImageUrlList.first,
                          //   fit: BoxFit.cover,
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return Container(
                          //       color: Colors.white,
                          //     );
                          //   },
                          // ),
                        ),
                      ),
                      SizedBox(height: 10.toWidth),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40.toWidth,
                              width: double.infinity,
                              child: Text(
                                '${item.goodsNm}',
                                style: ShownyStyle.caption(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 6.toWidth),
                            Text(
                              '${item.goodsPrice.formatPrice()} 원',
                              style:
                                  ShownyStyle.caption(weight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.toWidth),
      ],
    );
  }
}
