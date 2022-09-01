import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/presentation/order/widget/archived_order_tile.dart';
import 'package:zcart_seller/presentation/order/widget/delete_order_dialog.dart';

import '../../../application/app/order/order_provider.dart';

class ArcivedOrder extends HookConsumerWidget {
  const ArcivedOrder({Key? key}) : super(key: key);

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
          CherryToast.info(
            title: const Text('Successfully Unarcived'),
            animationType: AnimationType.fromTop,
          ).show(context);

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          next.failure.showDialogue(context);
        }
      }
    });
    final orderList = ref.watch(
        orderProvider(OrderFilter.archived).select((value) => value.orderList));
    final loading = ref.watch(
        orderProvider(OrderFilter.archived).select((value) => value.loading));
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 60.h,
      //   backgroundColor:  Constants.appbarColor,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(22.r),
      //     ),
      //   ),
      //   title: const Text('Arcived Orders'),
      //   elevation: 0,
      // ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(15.0),
              itemCount: orderList.length,
              itemBuilder: (context, index) => ArchivedOrderTile(
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteOrderDialog(
                      orderId: orderList[index].id,
                    ),
                  );
                },
                buttonName: 'Unarchive',
                orderNumber: orderList[index].orderNumber,
                orderAmount: orderList[index].grandTotal,
                // name: 'Riaz',
                date: orderList[index].orderDate,
                items: orderList[index].itemCount,
                onpress: () {
                  ref
                      .read(orderProvider(OrderFilter.archived).notifier)
                      .unarchiveOrder(orderList[index].id);
                  buttonPressed.value = true;
                },
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 15.h,
              ),
            ),
    );
  }
}
