import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/order%20management/cancellation/cancellation_provider.dart';
import 'package:alpesportif_seller/application/app/order%20management/cancellation/cancellation_state.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';

class ApproveCancellationDialog extends HookConsumerWidget {
  final int id;
  const ApproveCancellationDialog({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(cancellationProvider).loading;

    ref.listen<CancellationState>(cancellationProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'cancellation_approved'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    return AlertDialog(
      title: const Text("Approve Cancealltion"),
      content: const Text("Are you sure you wanto Approve this Cancellation"),
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
            ref.read(cancellationProvider.notifier).approveCancellation(id);
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
