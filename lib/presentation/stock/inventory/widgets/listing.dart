import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:zcart_seller/models/inventory/inventory_details_model.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/left_side_text.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/right_side_text.dart';

class ListingTile extends StatelessWidget {
  final InventoryDetailsModel productDetails;
  const ListingTile({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'SKU:',
              ),
              RightSideText(
                subTitle: productDetails.data?.sku ?? "N/A",
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'Price:',
              ),
              RightSideText(
                subTitle: productDetails.data?.salePrice ?? "N/A",
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'Stock Quantity:',
              ),
              RightSideText(
                subTitle:
                    productDetails.data?.stockQuantity.toString() ?? "N/A",
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'Min Order quantity:',
              ),
              RightSideText(
                subTitle:
                    productDetails.data?.minOrderQuantity.toString() ?? "N/A",
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'Condition:',
              ),
              RightSideText(
                subTitle: productDetails.data?.condition ?? "N/A",
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LeftSideText(
                title: 'Condition Note:',
              ),
              RightSideText(
                subTitle: productDetails.data?.conditionNote ?? "N/A",
              ),
            ],
          ),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'Shipping Weight:',
              ),
              RightSideText(
                subTitle:
                    productDetails.data?.shippingWeight.toString() ?? "N/A",
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'Supplier:',
              ),
              RightSideText(
                subTitle: productDetails.data?.supplierId.toString() ?? "N/A",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
