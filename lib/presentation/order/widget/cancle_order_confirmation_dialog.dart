import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/order/order_provider.dart';

class CancelOrderDialog extends HookConsumerWidget {
  final int orderId;
  const CancelOrderDialog({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return AlertDialog(
      title: const Text("Cancel Order"),
      content: const Text("Are you sure you want to cancel this order?"),
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
            ref.read(orderProvider(null).notifier).cancleOrder(orderId, true);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Confirm',
          ),
        ),
      ],
    );
  }
}
