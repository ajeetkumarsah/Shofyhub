import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class AddAdminNote extends HookConsumerWidget {
  final int orderId;
  const AddAdminNote({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final noteController = useTextEditingController();
    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'note_added'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    final loading = ref.watch(orderProvider.select((value) => value.loading));

    return AlertDialog(
      title: const Text('Add a Note'),
      content: KTextField(controller: noteController, lebelText: 'Note'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(orderProvider.notifier)
                .adminNote(orderId, noteController.text);
          },
          child: loading
              ? const SizedBox(child: CircularProgressIndicator())
              : Text(
                  'save'.tr(),
                ),
        ),
      ],
    );
  }
}
