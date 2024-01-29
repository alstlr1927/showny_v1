import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../components/page_route.dart';
import '../../../../models/store_good_model.dart';
import '../store_good_detail_screen.dart';

class NewestStoreProductList extends StatefulWidget {
  const NewestStoreProductList({super.key});

  @override
  State<NewestStoreProductList> createState() => _NewestStoreProductListState();
}

class _NewestStoreProductListState extends State<NewestStoreProductList> {
  List<Map<String, dynamic>> categories = [
    {'title': '아우터', 'code': '001'},
    {'title': '상의', 'code': '002'},
    {'title': '하의', 'code': '003'},
    {'title': '신발', 'code': '004'},
    {'title': '액세서리', 'code': '005'},
    {'title': '잡화', 'code': '006'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...categories
            .map(
              (item) => _NewestProuctList(
                title: item['title'],
                categoryCode: item['code'],
              ),
            )
            .toList(),
      ],
    );
  }
}

class _NewestProuctList extends StatefulWidget {
  final String title;
  final String categoryCode;
  const _NewestProuctList({
    Key? key,
    required this.title,
    required this.categoryCode,
  }) : super(key: key);

  @override
  State<_NewestProuctList> createState() => __NewestProuctListState();
}

class __NewestProuctListState extends State<_NewestProuctList> {
  late UserProvider userProvider;
  List<StoreGoodModel> newestList = [];

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    _getNewestProduct();
  }

  Future _getNewestProduct() async {
    ApiHelper.shared.getGoodsList(
        userProvider.user.memNo,
        '',
        '',
        widget.categoryCode,
        '',
        1,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        0,
        1, (response) {
      newestList = [...response.goodsList];
      setState(() {});
    }, (error) {
      newestList = [];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (newestList.isEmpty) {
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
            itemCount: newestList.length > 6 ? 6 : newestList.length,
            itemBuilder: (context, index) {
              StoreGoodModel item = newestList[index];
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
                          child: Image.network(
                            item.goodsImageUrlList.first,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.white,
                              );
                            },
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 130.toWidth,
                      //   height: 130.toWidth,
                      //   decoration: BoxDecoration(
                      //       color: Colors.green[300],
                      //       border: Border.all(width: 1, color: Colors.amber)),
                      // ),
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
