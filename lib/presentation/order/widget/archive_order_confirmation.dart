import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/order/order_provider.dart';
import 'package:zcart_vendor/application/app/order/order_state.dart';

class ArchivedOrderConfirmation extends HookConsumerWidget {
  final int orderId;
  const ArchivedOrderConfirmation({Key? key, required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<OrderState>(orderProvider(OrderFilter.archived),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: const Text('Successfully Arcived'),
            animationType: AnimationType.fromTop,
          ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.info(
            title: const Text('Something went wrong'),
            animationType: AnimationType.fromTop,
          ).show(context);
          next.failure.showDialogue(context);
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
                .archiveOrder(orderId);
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
