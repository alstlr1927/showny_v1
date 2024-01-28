import 'package:flutter/material.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class NewestStoreProductList extends StatefulWidget {
  const NewestStoreProductList({super.key});

  @override
  State<NewestStoreProductList> createState() => _NewestStoreProductListState();
}

class _NewestStoreProductListState extends State<NewestStoreProductList> {
  @override
  Widget build(BuildContext context) {
    // ApiHelper.shared.getGoodsList
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NewestOuterList(),
        _NewestOuterList(),
        _NewestOuterList(),
        _NewestOuterList(),
        _NewestOuterList(),
        _NewestOuterList(),
      ],
    );
  }
}

class _NewestOuterList extends StatefulWidget {
  const _NewestOuterList({super.key});

  @override
  State<_NewestOuterList> createState() => __NewestOuterListState();
}

class __NewestOuterListState extends State<_NewestOuterList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          child: Text(
            '아우터',
            style: ShownyStyle.body2(weight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 14.toWidth),
        SizedBox(
          height: 215.toWidth,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 130.toWidth,
                child: Column(
                  children: [
                    Container(
                      width: 130.toWidth,
                      height: 130.toWidth,
                      decoration: BoxDecoration(
                          color: Colors.green[300],
                          border: Border.all(width: 1, color: Colors.amber)),
                    ),
                    SizedBox(height: 10.toWidth),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '여 모노그램 로고 반팔티 셔츠 J218885',
                            style: ShownyStyle.caption(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.toWidth),
                          Text(
                            '53,100원',
                            style: ShownyStyle.caption(weight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
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
