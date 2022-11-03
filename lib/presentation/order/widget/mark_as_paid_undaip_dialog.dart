 
import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_details_provider.dart';
import 'package:zcart_seller/application/app/order/order_details_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';

class MarkAsPaidUnpaidDialog extends HookConsumerWidget {
  final int orderId;
  final bool isPaid;
  const MarkAsPaidUnpaidDialog(
      {Key? key, required this.orderId, required this.isPaid})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref
        .watch(orderDetailsProvider(orderId).select((value) => value.loading));

    ref.listen<OrderDetailsState>(orderDetailsProvider(orderId),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          ref.read(orderDetailsProvider(orderId).notifier).getOrderDetails();
          NotificationHelper.success(
              message:
                  isPaid ? 'marked_as_unpaid'.tr() : 'marked_as_paid'.tr());
          // CherryToast.info(
          //   title: isPaid
          //       ? Text('marked_as_unpaid'.tr())
          //       : Text('marked_as_paid'.tr()),
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
    return AlertDialog(
      title: isPaid ? Text('mark_as_unpaid'.tr()) : Text('mark_as_paid'.tr()),
      content: isPaid
          ? Text("are_you_sure_mark_as_unpaid".tr())
          : Text("are_you_sure_mark_as_paid".tr()),
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
            if (isPaid) {
              ref
                  .read(orderDetailsProvider(orderId).notifier)
                  .markAsUnpaid(ref);
            } else {
              ref.read(orderDetailsProvider(orderId).notifier).markAsPaid(ref);
            }
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
