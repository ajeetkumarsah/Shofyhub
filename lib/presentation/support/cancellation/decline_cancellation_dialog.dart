import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/cancellation/cancellation_provider.dart';
import 'package:zcart_seller/application/app/order%20management/cancellation/cancellation_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';

class DeclineCancellationDialog extends HookConsumerWidget {
  final int id;
  const DeclineCancellationDialog({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(cancellationProvider).loading;

    ref.listen<CancellationState>(cancellationProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'cancellation_declined'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    return AlertDialog(
      title: const Text("Decline Cancealltion"),
      content: const Text("Are you sure you wanto Decline this Cancellation"),
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
            ref.read(cancellationProvider.notifier).declineCancellation(id);
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
