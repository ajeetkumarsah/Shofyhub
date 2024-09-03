import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/order/order_provider.dart';
import 'package:alpesportif_seller/application/app/order/order_state.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';

class CancelOrderDialog extends HookConsumerWidget {
  final int orderId;
  const CancelOrderDialog({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'order_status_updated'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
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
            ref.read(orderProvider.notifier).cancleOrder(orderId, true);
          },
          child: const Text(
            'Confirm',
          ),
        ),
      ],
    );
  }
}
