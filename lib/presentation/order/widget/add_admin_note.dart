 
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
    ref.listen<OrderState>(orderProvider(null), (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'note_added'.tr());
          // CherryToast.info(
          //   title: const Text('Note Added'),
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
    final loading =
        ref.watch(orderProvider(null).select((value) => value.loading));

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
                .read(orderProvider(null).notifier)
                .adminNote(orderId, noteController.text);
            // Navigator.pop(context);
          },
          child: loading
              ? const SizedBox(child: CircularProgressIndicator())
              : const Text(
                  'Save',
                ),
        ),
      ],
    );
  }
}
