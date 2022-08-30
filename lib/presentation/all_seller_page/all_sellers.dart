import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/presentation/all_seller_page/widget/seller_full_info.dart';
import 'package:zcart_seller/presentation/widget_for_all/color.dart';

class AllSellers extends StatelessWidget {
  const AllSellers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('All Sellers'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SellerFullInfo(),
              SizedBox(height: 15.h),
              const SellerFullInfo(),
              SizedBox(height: 15.h),
              const SellerFullInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
