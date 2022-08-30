import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';

class DeleteOrderDialog extends HookConsumerWidget {
  final int orderId;
  const DeleteOrderDialog({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
