 
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/presentation/widget_for_all/zcart_appbar.dart';

import 'widget/archived_order_tile.dart';

class ArchivedOrderListPage extends HookConsumerWidget {
  const ArchivedOrderListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider(OrderFilter.archived).notifier).getOrders();
      });
      return null;
    }, []);
    final buttonPressed = useState(false);
    ref.listen<OrderState>(orderProvider(OrderFilter.archived),
        (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() &&
            next.orderList != previous?.orderList &&
            buttonPressed.value) {
          NotificationHelper.success(message: 'successfully_unarchived'.tr());
          // CherryToast.info(
          //   title: const Text('Successfully Unarcived'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          next.failure.showDialogue(context);
        }
      }
    });

    final orderList = ref.watch(orderProvider(OrderFilter.archived)).orderList;
    return Scaffold(
      appBar: const ZcartAppBar(title: 'Archived orders'),
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
          return ArchivedOrderTile(
            order: order,
            unArchive: () {
              ref
                  .read(orderProvider(OrderFilter.archived).notifier)
                  .unarchiveOrder(orderList[index].id);
              buttonPressed.value = true;
            },
          );
        },
      ),
    );
  }
}
