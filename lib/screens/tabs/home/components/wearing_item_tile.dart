import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/utils/formatter.dart';

class WearingItemTile extends StatelessWidget {
  const WearingItemTile({
    super.key,
    required this.itemUrl,
    required this.brandName,
    required this.itemName,
    required this.price,
    required this.onPressed,
  });

  final String? itemUrl;
  final String? brandName;
  final String? itemName;
  final int? price;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          pressedOpacity: 1.0,
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (itemUrl != null)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Image.network(itemUrl!, fit: BoxFit.cover,
                        errorBuilder: (context, error, StackTrace) {
                      return Container(
                        color: Colors.black12,
                      );
                    }),
                  )
                else
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.grey[300],
                  ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 32 - 100),
                  height: 80,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brandName ?? '',
                      style: Constants.textFieldErrorStyle
                          .copyWith(fontSize: 13.0),
                    ),
                    const SizedBox(height: 2.0),
                    SizedBox(
                      child: Text(
                        (itemName ?? '').trim().isEmpty
                            ? ''
                            : itemName!,
                        style: Constants.defaultTextStyle.copyWith(fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      price != null
                          ? '${Formatter.formatNumber(price!)} 원'
                          : '가격 정보 없음',
                      style: Constants.appBarTitleStyle.copyWith(fontSize: 13.0),
                    ),
                  ],
                ),
                )
                ,
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
