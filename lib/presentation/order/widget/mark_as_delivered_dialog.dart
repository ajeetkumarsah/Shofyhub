import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_details_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';

class MarkAsDeliveredDialog extends HookConsumerWidget {
  final int orderId;
  const MarkAsDeliveredDialog({Key? key, required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(orderProvider).loading;

    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'marked_as_delivered'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
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
            ref.read(orderProvider.notifier).markAsDelivered(orderId, true);
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
