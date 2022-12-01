import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/delivary_boy_page.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/roles_page.dart';
import 'package:zcart_seller/presentation/shop/pages/taxes/tax_page.dart';
import 'package:zcart_seller/presentation/shop/pages/user/user_page.dart';

class ShopHome extends StatelessWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: index,
      length: 4,
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
              isScrollable: true,
              indicatorWeight: 4,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white10),
              tabs: [
                Tab(
                  text: 'shop_user'.tr(),
                ),
                Tab(
                  text: 'delivery_boy'.tr(),
                ),
                Tab(
                  text: 'user_roles'.tr(),
                ),
                Tab(
                  text: 'taxes'.tr(),
                ),
              ]),
        ),
        body: const TabBarView(children: [
          UserPage(),
          DeliveryBoyPage(),
          RolesPage(),
          TaxPage(),
        ]),
      ),
    );
  }
}
