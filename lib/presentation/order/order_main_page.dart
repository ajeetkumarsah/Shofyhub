import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/carriers/carriers_provider.dart';
import 'package:zcart_seller/application/app/order/order_status_provider.dart';
import 'package:zcart_seller/presentation/New%20order/new_order.dart';
import 'package:zcart_seller/presentation/order/widget/arcived_order.dart';
import 'package:zcart_seller/presentation/widget_for_all/color.dart';

import '../../application/app/delivary boys/delivary_boy_provider.dart';

class OrderMainPage extends HookConsumerWidget {
  final int index;
  const OrderMainPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(delivaryBoyProvider.notifier).getDelivaryBoys();

        ref.read(carriersProvider.notifier).getCarrier();
        ref.read(orderStatusProvider.notifier).getOrderStatus();
        // ref.read(orderDetailsProvider(id).notifier).getInvoice();
      });
      return null;
    }, []);
    return DefaultTabController(
      initialIndex: index,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: MyColor.appbarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22.r),
            ),
          ),
          title: const Text('Orders'),
          elevation: 0,
          bottom: TabBar(
              physics: const NeverScrollableScrollPhysics(),
              indicatorWeight: 4,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white10),
              tabs: const [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Unfulfilled',
                ),
                Tab(
                  text: 'Archived',
                ),
              ]),
        ),
        body: const TabBarView(children: [
          NewOrderPage(allOrder: true),
          NewOrderPage(
            allOrder: false,
          ),
          ArcivedOrder(),
        ]),
      ),
    );
  }
}
