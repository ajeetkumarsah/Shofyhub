import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/models/inventory/inventory_details_model.dart';
import 'package:alpesportif_seller/presentation/stock/inventory/widgets/sub_title_text.dart';
import 'package:alpesportif_seller/presentation/stock/inventory/widgets/title_text.dart';

class ProductTile extends StatelessWidget {
  final InventoryDetailsModel productDetails;
  const ProductTile({Key? key, required this.productDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(title: 'Name:'),
          SizedBox(height: 8.h),
          SubTitleText(
            subTitleText: productDetails.data?.product?.name ?? "N/A",
          ),
          SizedBox(height: 15.h),
          // const TitleText(
          //   title: 'Categories:',
          // ),
          // SizedBox(height: 10.h),
          // ListView.separated(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: 5,
          //   itemBuilder: (context, index) => const CategoriesButtons(
          //     buttonName: 'Bechtelar, Powlowski and Koelpin',
          //   ),
          //   separatorBuilder: (context, index) => SizedBox(
          //     height: 10.h,
          //   ),
          // ),
          // SizedBox(height: 28.h),
          TitleText(
            title: '${productDetails.data?.product?.gtinType ?? "N/A"}:',
          ),
          SizedBox(height: 8.h),
          SubTitleText(
            subTitleText: productDetails.data?.product?.gtin ?? "N/A",
          ),
          SizedBox(height: 28.h),
          const TitleText(
            title: 'MPN:',
          ),
          SizedBox(height: 8.h),
          SubTitleText(
            subTitleText: productDetails.data?.product?.mpn ?? "N/A",
          ),
          // SizedBox(height: 8.h),
          // const TitleText(
          //   title: 'Manufacturer:',
          // ),
          // SizedBox(height: 8.h),
          // const SubTitleText(
          //   subTitleText: 'Lemke-Klocko',
          // ),
          // SizedBox(height: 8.h),
          // const TitleText(
          //   title: 'Origin Country:',
          // ),
          // SizedBox(height: 8.h),
          // const SubTitleText(
          //   subTitleText: 'Belgium',
          // ),
          SizedBox(height: 8.h),
          const TitleText(
            title: 'Requires Shipping:',
          ),
          SizedBox(height: 8.h),
          SubTitleText(
            subTitleText:
                (productDetails.data?.freeShipping ?? false) ? 'Yes' : 'No',
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
