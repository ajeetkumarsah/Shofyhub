import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_details_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';

class MarkAsDeliveredDialog extends HookConsumerWidget {
  final int orderId;
  const MarkAsDeliveredDialog({Key? key, required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(orderProvider(null)).loading;

    ref.listen<OrderState>(orderProvider(null), (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          ref.read(orderProvider(null).notifier).getOrders();
          ref.read(orderProvider(OrderFilter.unfullfill).notifier).getOrders();

          CherryToast.info(
            title: Text('marked_as_delivered'.tr()),
            animationType: AnimationType.fromTop,
          ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.error(
            title: Text(
              next.failure.error,
            ),
            toastPosition: Position.bottom,
          ).show(context);
        }
      }
    });
    return AlertDialog(
      title: Text("mark_as_delivered".tr()),
      content: Text("are_you_sure_mark_as_delivered".tr()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'cancel'.tr(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(orderProvider(null).notifier)
                .markAsDelivered(orderId, true);
            ref.read(orderDetailsProvider(orderId).notifier).getOrderDetails();
          },
          child: loading
              ? const CircularProgressIndicator()
              : Text(
                  'confirm'.tr(),
                ),
        ),
      ],
    );
  }
}
