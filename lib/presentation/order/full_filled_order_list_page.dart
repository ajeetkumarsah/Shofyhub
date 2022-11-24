import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/delivary_boys/delivary_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/presentation/order/widget/order_tile.dart';
import 'package:zcart_seller/presentation/order_details_page/order_details_screen.dart';

class FullFilledOrderListPage extends HookConsumerWidget {
  const FullFilledOrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(orderProvider.notifier).getMoreFullFilledOrders();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider.notifier).getFullFilledOrders();
        ref.read(delivaryProvider.notifier).getDelivaryBoys();
      });
      return null;
    }, []);

    final orderPaginationModel =
        ref.watch(orderProvider.notifier).fulfilledOrderPaginationModel;

    final orderList = ref.watch(orderProvider).fullfillOrderList;
    final loading = ref.watch(orderProvider).loading;

    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                return ref.read(orderProvider.notifier).getFullFilledOrders();
              },
              child: orderList.isEmpty
                  ? Center(child: Text('no_item_found'.tr()))
                  : ListView.separated(
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
                            orderList.length <
                                orderPaginationModel.meta.total!) {
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
                                isFullfilled: true,
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
