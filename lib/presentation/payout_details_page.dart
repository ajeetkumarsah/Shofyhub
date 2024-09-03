import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/delivery_orders_page/delivery_orders_page.dart';

class PayoutDetails extends StatefulWidget {
  const PayoutDetails({Key? key}) : super(key: key);

  @override
  State<PayoutDetails> createState() => _PayoutDetailsState();
}

class _PayoutDetailsState extends State<PayoutDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Payout Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //
              Column(
                children: [
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payout details',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
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
                                text: 'Payout id: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'PAYID0009',
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
                                text: 'Payout amount: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Rs.1500.00',
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
                                text: 'Notes: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'NA',
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
                                text: 'Status: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Requested',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
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
                ],
              ),
              SizedBox(height: 10.h),
              //
              Column(
                children: [
                  Container(
                    height: 130.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank details',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
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
                                text: 'Account no: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '00884516',
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
                                text: 'Account holder name: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Test seller',
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
                                text: 'Bank name: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'IDFC Bank',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
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
                ],
              ),
              //
              SizedBox(height: 10.h),
              Column(
                children: [
                  Container(
                    height: 165.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seller details',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
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
                                text: 'Seller name: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Jone Doe',
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
                                text: 'Mobile no: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '+184662546',
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
                                text: 'E-mail: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'jonedoe@gmail.com',
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
                                text: 'Address: ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text:
                                        'infinit Loop,Apple campus \n Cupertino,Ca,USA',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
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
                ],
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveryOrdersPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.appbarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: SizedBox(
                  height: 30.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Mark as complete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Cancel payout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
