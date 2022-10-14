import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/delivary_boys/delivary_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/presentation/order/widget/order_tile.dart';
import 'package:zcart_seller/presentation/order_details_page/order_details_screen.dart';

class OrderListPage extends HookConsumerWidget {
  final String? filter;
  const OrderListPage({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(orderProvider(filter).notifier).getMoreOrders();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider(filter).notifier).getOrders();
        ref.read(delivaryProvider.notifier).getDelivaryBoys();
      });
      return null;
    }, []);

    final orderPaginationModel =
        ref.watch(orderProvider(filter).notifier).orderPaginationModel;

    final orderList = ref.watch(orderProvider(filter)).orderList;
    final loading = ref.watch(orderProvider(filter)).loading;

    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                return ref.read(orderProvider(filter).notifier).getOrders();
              },
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ).r,
                controller: scrollController,
                itemCount: orderList.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 20,
                  color: Color(0xffEFEFEF),
                ),
                itemBuilder: (context, index) {
                  if ((index == orderList.length - 1) &&
                      orderList.length < orderPaginationModel.meta.total!) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
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
            ),
    );
  }
}
