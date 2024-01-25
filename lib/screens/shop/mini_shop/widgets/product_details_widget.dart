import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/minishop_product_model.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/theme.dart';

class ProductDetailsWidget extends StatefulWidget {
  final MinishopProductModel minishopProduct;

  const ProductDetailsWidget({Key? key, required this.minishopProduct})
      : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              // SizedBox(
              //   height: 24,
              //   width: 24,
              //   child: Image.network(widget.minishopProduct.brandImageUrl,
              //       fit: BoxFit.cover),
              // ),
              // const SizedBox(
              //   width: 4,
              // ),
              SizedBox(
                height: 24,
                child: Text(widget.minishopProduct.brand,
                    style: themeData().textTheme.bodySmall),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('product_detail.product_name_text'),
                      style: themeData()
                          .textTheme
                          .bodySmall!
                          .copyWith(color: greyLight),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      tr('product_detail.price_text'),
                      style: themeData()
                          .textTheme
                          .bodySmall!
                          .copyWith(color: greyLight),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      tr('product_detail.size_text'),
                      style: themeData()
                          .textTheme
                          .bodySmall!
                          .copyWith(color: greyLight),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      tr('product_detail.actual_size_text'),
                      style: themeData()
                          .textTheme
                          .bodySmall!
                          .copyWith(color: greyLight),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      tr('product_detail.delivery_fee_text'),
                      style: themeData()
                          .textTheme
                          .bodySmall!
                          .copyWith(color: greyLight),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.minishopProduct.name,
                      style: themeData().textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.minishopProduct.price.formatPrice()} 원',
                      style: themeData().textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.minishopProduct.actualSize,
                      style: themeData().textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.minishopProduct.viewSize,
                      style: themeData().textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.minishopProduct.deliveryPrice.formatPrice()} 원',
                      style: themeData().textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(tr('product_detail.detail_text'),
                    style: themeData()
                        .textTheme
                        .bodySmall!
                        .copyWith(color: greyLight)),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: size.width,
            child: SizedBox(
              width: size.width * 0.8,
              child: Text(
                widget.minishopProduct.description,
                style: themeData().textTheme.bodySmall,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
