import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ProductDetailsWidget extends StatefulWidget {
  final MinishopProductModel minishopProduct;

  const ProductDetailsWidget({Key? key, required this.minishopProduct}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildBrandInfo(),
          const SizedBox(height: 40),
          _buildProductInfo(),
          const SizedBox(height: 8),
          _buildProductContentTitle(size),
          const SizedBox(height: 8),
          _buildProductContent(size),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  SizedBox _buildProductContent(Size size) {
    return SizedBox(
      width: size.width,
      child: SizedBox(
        width: size.width * 0.8,
        child: Text(
          widget.minishopProduct.description,
          style: ShownyStyle.caption(color: ShownyStyle.black),
        ),
      ),
    );
  }

  SizedBox _buildProductContentTitle(Size size) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            tr('product_detail.detail_text'),
            style: ShownyStyle.caption(
              color: Color(0xFF7777777),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildBrandInfo() {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                widget.minishopProduct.brandImageUrl,
              ),
              fit: BoxFit.cover,
            ),
            boxShadow: ShownyStyle.elevation_01dp(),
          ),
        ),
        const SizedBox(width: 4),
        SizedBox(
          height: 24,
          child: Center(
            child: Text(
              widget.minishopProduct.brand,
              style: ShownyStyle.caption(),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildProductInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('product_detail.product_name_text'),
                style: ShownyStyle.caption(
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                tr('product_detail.price_text'),
                style: ShownyStyle.caption(
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                tr('product_detail.size_text'),
                style: ShownyStyle.caption(
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                tr('product_detail.actual_size_text'),
                style: ShownyStyle.caption(
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                tr('product_detail.delivery_fee_text'),
                style: ShownyStyle.caption(
                  color: Color(0xFF777777),
                ),
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
                style: ShownyStyle.caption(
                  color: ShownyStyle.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${widget.minishopProduct.price.formatPrice()} 원',
                style: ShownyStyle.caption(
                  color: ShownyStyle.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.minishopProduct.actualSize,
                style: ShownyStyle.caption(
                  color: ShownyStyle.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.minishopProduct.viewSize,
                style: ShownyStyle.caption(
                  color: ShownyStyle.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${widget.minishopProduct.deliveryPrice.formatPrice()} 원',
                style: ShownyStyle.caption(
                  color: ShownyStyle.black,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
