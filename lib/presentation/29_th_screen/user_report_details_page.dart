import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';

class UserReportDetailPage extends HookConsumerWidget {
  const UserReportDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        leading: const Icon(Icons.arrow_back),
        title: const Text('User Report Detail'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REPORT OVERVIEW',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Name: ',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15.sp,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'John Doe',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      RichText(
                        text: TextSpan(
                          text: 'Product id: ',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15.sp,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'PID0000004',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      RichText(
                        text: TextSpan(
                          text: 'User id: ',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15.sp,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '2gnrjfljMfdjK00U4r3',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      RichText(
                        text: TextSpan(
                          text: 'Reported on: ',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15.sp,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '30 May 2022, 08:06 PM',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DESCRIPTION',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Fake product',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 6.h),
                    child: Text(
                      'PRODUCT DETAIL',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                              child: Image.asset('assets/images/c1.png'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 135.h,
                        width: 170.w,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cadbury Dark Milk',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Total views: 10',
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Category: Chocolate, biscuts & snacks',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: MyColor.appbarColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              'View Product',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
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
                              'Edit Product',
                              style: TextStyle(
                                color: Colors.grey.shade700,
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
                    height: 8.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
