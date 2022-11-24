import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/presentation/order/widget/order_conteiner.dart';
import 'package:zcart_seller/presentation/order_details_page/order_details_screen.dart';

class UnfullfilledOrder extends HookConsumerWidget {
  const UnfullfilledOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final orderList =
        ref.watch(orderProvider.select((value) => value.unFulfillOrderList));
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(15.0),
        itemCount: orderList.length,
        itemBuilder: (context, index) => OrderContainer(
          buttonName: 'Manage Order',
          orderNumber: orderList[index].orderNumber,
          orderAmount: orderList[index].grandTotal,
          date: orderList[index].orderDate,
          items: orderList[index].itemCount,
          onpress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OrderDetailsScreen(
                          id: orderList[index].id,
                        )));
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 15.h,
        ),
      ),
    );
  }
}
