import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/dispute/dispute_provider.dart';
import 'package:zcart_seller/application/app/order%20management/dispute/dispute_state.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/order%20management/dispute/dispute_status_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class DisputeResponseDialog extends HookConsumerWidget {
  final int disputeId;
  const DisputeResponseDialog({Key? key, required this.disputeId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final messageController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    const List<DisputeStatus> disputeStatusList = [
      DisputeStatus(id: 1, title: 'New'),
      DisputeStatus(id: 2, title: 'Open'),
      DisputeStatus(id: 3, title: 'Waiting'),
      DisputeStatus(id: 4, title: 'Solved'),
      DisputeStatus(id: 5, title: 'Closed'),
      DisputeStatus(id: 6, title: 'Appealed'),
    ];
    final ValueNotifier<DisputeStatus> selectedDisputeStatus =
        useState(disputeStatusList[0]);

    ref.listen<DisputeState>(disputeProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'response_added'.tr());
          // CherryToast.info(
          //   title: const Text('Response Added'),
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
    final loading = ref.watch(disputeProvider.select((value) => value.loading));

    return AlertDialog(
      title: const Text('Add a Response'),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${"status".tr()} *',
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 50.h,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  style: TextStyle(color: Colors.grey.shade800),
                  isExpanded: true,
                  value: selectedDisputeStatus.value,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: disputeStatusList.map<DropdownMenuItem<DisputeStatus>>(
                      (DisputeStatus value) {
                    return DropdownMenuItem<DisputeStatus>(
                      value: value,
                      child: Text(
                        value.title,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: (DisputeStatus? newValue) {
                    selectedDisputeStatus.value = newValue!;
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),
            KMultiLineTextField(
              controller: messageController,
              lebelText: 'Reply',
              maxLines: 4,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel'.tr(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(disputeProvider.notifier).responseDispute(disputeId,
                selectedDisputeStatus.value.id, messageController.text);
          },
          child: loading
              ? const CircularProgressIndicator()
              : Text(
                  'reply'.tr(),
                ),
        ),
      ],
    );
  }
}
