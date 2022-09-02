import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/presentation/order/widget/order_tile.dart';
import 'package:zcart_seller/presentation/order_details_page/order_details_screen.dart';

class OrderListPage extends HookConsumerWidget {
  final String? filter;
  const OrderListPage({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider(filter).notifier).getOrders();
      });
      return null;
    }, []);

    final orderList = ref.watch(orderProvider(filter)).orderList;
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: ListView.separated(
        padding: const EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
        ).r,
        itemCount: orderList.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 20,
          color: Color(0xffEFEFEF),
        ),
        itemBuilder: (context, index) {
          final order = orderList[index];
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OrderDetailsScreen(
                                id: order.id,
                              )));
                },
                child: OrderTile(
                  order: order,
                  filter: filter,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
