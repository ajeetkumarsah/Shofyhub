import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/delivary_boy_page.dart';
import 'package:zcart_seller/presentation/shop/pages/user/user_page.dart';

class ShopHome extends StatelessWidget {
  const ShopHome({Key? key}) : super(key: key);

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
          title: const Text('Shop'),
          elevation: 0,
          bottom: TabBar(
              indicatorWeight: 4,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white10),
              tabs: const [
                Tab(
                  text: 'Shop User',
                ),
                Tab(
                  text: 'Delivary Boy',
                ),
                // Tab(
                //   text: 'Products',
                // ),
              ]),
        ),
        body: const TabBarView(children: [
          UserPage(),
          DelivaryBoyPage(),
          // TaxesPage(),
        ]),
      ),
    );
  }
}
