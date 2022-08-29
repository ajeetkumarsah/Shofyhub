import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_vendor/presentation/account_setting/account_setting_page.dart';
import 'package:zcart_vendor/presentation/delivery_details_page/delivery_details_page.dart';
import 'package:zcart_vendor/presentation/delivery_orders_page/delivery_orders_page.dart';
import 'package:zcart_vendor/presentation/previously_completed_orders_page/radio_dialogue.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';

class PreviouslyCompletedOrdersPage extends StatelessWidget {
  const PreviouslyCompletedOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Previously Completed Orders'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const RadioDialogue(),
              );
            },
            icon: const Icon(Icons.ac_unit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 334.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order id: OID00000078',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF353636),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Items: 1',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF353636),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Total amount: Rs.51.20',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF353636),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            RichText(
                              text: TextSpan(
                                text: 'Delivery status: ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF353636),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Delivered',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF62AD66),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DeliveryDetailsPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 110.w,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: const Color(0xFF9B9B9C),
                                  width: 1.w,
                                )),
                            child: Center(
                              child: Text(
                                'Delivery details',
                                style: TextStyle(
                                  color: const Color(0xFF353636),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 167.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Details',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF353636),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 1.h,
                            width: double.infinity,
                            color: const Color(0xFFF2F2F2),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer name: John Doe',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Mobile no: +919988776655',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Delivery address:',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    '2100 Stevens Creek Blvd, Cupertino \nCA, 95014, USA',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEA2264),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Icon(
                                        Icons.map,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: const EdgeInsets.all(20),
                height: 334.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order id: OID00000078',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF353636),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Items: 1',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF353636),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Total amount: Rs.51.20',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF353636),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            RichText(
                              text: TextSpan(
                                text: 'Delivery status: ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF353636),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Delivered',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF62AD66),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DeliveryDetailsPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 110.w,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: const Color(0xFF9B9B9C),
                                  width: 1.w,
                                )),
                            child: Center(
                              child: Text(
                                'Delivery details',
                                style: TextStyle(
                                  color: const Color(0xFF353636),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 167.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Details',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF353636),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 1.h,
                            width: double.infinity,
                            color: const Color(0xFFF2F2F2),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer name: John Doe',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Mobile no: +919988776655',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'Delivery address:',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    '2100 Stevens Creek Blvd, Cupertino \nCA, 95014, USA',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF646465),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEA2264),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Icon(
                                        Icons.map,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveryOrdersPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PreviouslyCompletedOrdersPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.timer_rounded),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AcountSettingsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_box),
              ),
              label: ''),
        ],
        currentIndex: 1,
      ),
    );
  }
}
