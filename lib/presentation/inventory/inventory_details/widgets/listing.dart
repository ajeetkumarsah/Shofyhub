import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_vendor/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';
import 'package:zcart_vendor/presentation/inventory/inventory_details/widgets/left_side_text.dart';
import 'package:zcart_vendor/presentation/inventory/inventory_details/widgets/right_side_text.dart';

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
                subTitle: productDetails.sku,
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
                subTitle: productDetails.salePrice,
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
                subTitle: productDetails.stockQuantity.toString(),
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
                subTitle: productDetails.minOrderQuantity.toString(),
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
                subTitle: productDetails.condition,
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
                subTitle: productDetails.conditionNote,
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
                subTitle: productDetails.shippingWeight,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children:  [
          //     LeftSideText(
          //       title: 'Packagings:',
          //     ),
          //     RightSideText(
          //       subTitle: 'not available',
          //     ),
          //   ],
          // ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LeftSideText(
                title: 'Supplier:',
              ),
              RightSideText(
                subTitle: productDetails.supplierId.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
