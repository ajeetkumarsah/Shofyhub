import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';

class ArchivedOrderConfirmation extends HookConsumerWidget {
  final int orderId;
  final String? filter;
  final bool? details;
  const ArchivedOrderConfirmation(
      {Key? key, required this.orderId, this.filter, this.details = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<OrderState>(orderProvider(OrderFilter.archived),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          if (details == true) {
            Navigator.of(context).pop();
          }
          NotificationHelper.success(message: 'successfully_archived'.tr());
          // CherryToast.info(
          //   title: const Text('Successfully Arcived'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);

          // CherryToast.error(
          //   title: Text(
          //     next.failure.error,
          //   ),
          //   toastPosition: Position.bottom,
          // ).show(context);
        }
      }
    });
    final loading = ref.watch(
        orderProvider(OrderFilter.archived).select((value) => value.loading));
    return AlertDialog(
      title: const Text("Archive Order"),
      content: const Text("Are you sure you want to archive this order?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(orderProvider(OrderFilter.archived).notifier)
                .archiveOrder(orderId, reloadList: () {
              ref.read(orderProvider(filter).notifier).getOrders();
              ref
                  .read(orderProvider(OrderFilter.unfullfill).notifier)
                  .getOrders();
              ref.read(orderProvider(OrderFilter.unpaid).notifier).getOrders();
            });
            // Navigator.of(context).pop();
          },
          child: loading
              ? SizedBox(width: 40.w, child: const CircularProgressIndicator())
              : const Text(
                  'Confirm',
                ),
        ),
      ],
    );
  }
}
