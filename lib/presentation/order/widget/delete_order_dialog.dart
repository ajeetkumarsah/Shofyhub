import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/models/clean_failure.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';

class DeleteOrderDialog extends HookConsumerWidget {
  final int orderId;
  const DeleteOrderDialog({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<OrderState>(orderProvider(null), (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          ref.read(orderProvider(null).notifier).getOrders();
          ref.read(orderProvider(OrderFilter.unfullfill).notifier).getOrders();
          ref.read(orderProvider(OrderFilter.archived).notifier).getOrders();

          CherryToast.info(
            title: const Text('Order Status Updated'),
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
      title: const Text("Delete Order"),
      content: const Text("Are you sure you want to delete this order?"),
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
                .deleteOrder(orderId);
          },
          child: const Text(
            'Confirm',
          ),
        ),
      ],
    );
  }
}
