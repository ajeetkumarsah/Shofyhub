import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';

class InventoryItemTile extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final String sku;
  final String condition;
  final int quantity;
  final Function()? quickUpdate;
  const InventoryItemTile(
      {Key? key,
      required this.quickUpdate,
      required this.condition,
      required this.quantity,
      required this.sku,
      required this.title,
      required this.image,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 135.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Image.network(image),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Container(
                // height: 135.h,
                width: 170.w,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      'SKU: $sku',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: 7.h),
                    Container(
                      height: 25.h,
                      // width: 90.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.shade300),
                      child: Center(
                        child: Text(
                          condition,
                          style: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      'Quantity: $quantity',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      price,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: quickUpdate,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: MyColor.appbarColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'Quick Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.w),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'Delete Product',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
