import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/app/order%20management/refunds/pages/close_refund_page.dart';
import 'package:zcart_seller/presentation/app/order%20management/refunds/pages/open_refund_page.dart';

class RefundHome extends StatelessWidget {
  const RefundHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: index,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Constants.appbarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22.r),
            ),
          ),
          title: const Text('Refunds'),
          elevation: 0,
          bottom: TabBar(
              indicatorWeight: 4,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white10),
              tabs: const [
                Tab(
                  text: 'Open',
                ),
                Tab(
                  text: 'Closed',
                ),
                // Tab(
                //   text: 'Products',
                // ),
              ]),
        ),
        body: const TabBarView(children: [
          OpenRefundPage(),
          CloseRefundPage(),
        ]),
      ),
    );
  }
}
