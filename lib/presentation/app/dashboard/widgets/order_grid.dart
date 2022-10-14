import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/refunds/refund_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/domain/app/dashboard/statistic_model.dart';
import 'package:zcart_seller/presentation/app/dashboard/out_of_stock_page.dart';
import 'package:zcart_seller/presentation/order/archived_order_list_page.dart';
import 'package:zcart_seller/presentation/order/order_main_page.dart';
import 'package:zcart_seller/presentation/support/refund/refund_home.dart';

import 'store_report_item.dart';

class OrderGrid extends HookConsumerWidget {
  const OrderGrid({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  final StatisticModel statistics;

  @override
  Widget build(BuildContext context, ref) {
    final totalUnfullfilledOrder = ref.watch(
        orderProvider(OrderFilter.unfullfill)
            .select((value) => value.orderList.length));
    final totalArchivedOrder = ref.watch(orderProvider(OrderFilter.archived)
        .select((value) => value.orderList.length));
    final totalRefunds =
        ref.watch(refundProvider.select((value) => value.openRefunds.length));
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          StoreReportItems(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const OrderMainPage(
                        index: 1,
                      )));
            },
            icon: FontAwesomeIcons.boxesPacking,
            itemValues: totalUnfullfilledOrder.toString(),
            itemName: 'UNFULFILLED ORDERS',
          ),
          StoreReportItems(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ArchivedOrderListPage()));
            },
            icon: FontAwesomeIcons.cartArrowDown,
            itemValues: '$totalArchivedOrder',
            itemName: 'ARCHIVED ORDERS',
          ),
          StoreReportItems(
            icon: FontAwesomeIcons.calendarDay,
            itemValues: statistics.yesterdaysSaleAmount,
            itemName: 'YESTERDAY\'S TOTAL',
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const OutOfStockItemsPage()));
            },
            child: StoreReportItems(
              icon: FontAwesomeIcons.store,
              itemValues: statistics.stockOutCount.toString(),
              itemName: 'STOCK OUTS',
            ),
          ),
          StoreReportItems(
            icon: FontAwesomeIcons.person,
            itemValues: statistics.stockCount.toString(),
            itemName: 'TOTAL STOCK',
          ),
          StoreReportItems(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const RefundHome(hasAppbar: true)));
            },
            icon: FontAwesomeIcons.sellcast,
            itemValues: '$totalRefunds',
            itemName: 'REFUND REQUESTS',
          ),
        ],
      ),
    );
  }
}
