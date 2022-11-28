import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventory_details_model/inventory_details_model.dart';
import 'package:zcart_seller/presentation/inventory/widgets/left_side_text.dart';
import 'package:zcart_seller/presentation/inventory/widgets/right_side_text.dart';

class OfferTile extends StatelessWidget {
  final InventoryDetailsModel productDetails;
  const OfferTile({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: productDetails.hasOffer
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(
                      title: 'Offer Price:',
                    ),
                    RightSideText(
                      subTitle: '\$${productDetails.offerPrice}',
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(
                      title: 'Offer Start:',
                    ),
                    RightSideText(
                      subTitle: productDetails.offerStart
                          .replaceFirst(RegExp(r'T'), ' ')
                          .replaceFirst(RegExp(r'.000000Z'), ''),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(
                      title: 'Offer End:',
                    ),
                    RightSideText(
                      subTitle: productDetails.offerEnd
                          .replaceFirst(RegExp(r'T'), ' ')
                          .replaceFirst(RegExp(r'.000000Z'), ''),
                    ),
                  ],
                ),
              ],
            )
          : Text(
              'This listing doesn\'t have any active offer.',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
    );
  }
}
