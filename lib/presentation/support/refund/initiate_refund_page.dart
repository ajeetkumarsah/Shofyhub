
import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/refunds/refund_provider.dart';
import 'package:zcart_seller/application/app/order%20management/refunds/refund_state.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/order/order_details/refuncd_status_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

import '../../../../infrastructure/app/constants.dart';

class InitiateRefundPage extends HookConsumerWidget {
  final int orderId;
  final String orderNuber;
  const InitiateRefundPage(
      {Key? key, required this.orderId, required this.orderNuber})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final shopId =
        ref.watch(authProvider.select((value) => value.user.shop_id));

    final loading = ref.watch(refundProvider.select((value) => value.loading));

    final orderNumberController = useTextEditingController();
    final amountController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final refundGood = useState(false);
    final fullfilledOrder = useState(false);
    final notify = useState(true);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    const List<RefundStatus> refundStatusList = [
      RefundStatus(id: 1, title: 'New'),
      RefundStatus(id: 2, title: 'Approved'),
      RefundStatus(id: 2, title: 'Declined'),
    ];
    final ValueNotifier<RefundStatus> selectedRefundStatus =
        useState(refundStatusList[0]);

    orderNumberController.text = orderNuber;
    ref.listen<RefundState>(refundProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(
              message: 'refund_created_successfully'.tr());
          // CherryToast.info(
          //   title: Text('refund_created_successfully'.tr()),
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text('initiate_refund'.tr()),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: orderNumberController,
                    lebelText: '${'order_number'.tr()} *',
                    readOnly: true,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    '${"status".tr()} *',
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    // height: 50.h,
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
                        value: selectedRefundStatus.value,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        items: refundStatusList
                            .map<DropdownMenuItem<RefundStatus>>(
                                (RefundStatus value) {
                          return DropdownMenuItem<RefundStatus>(
                            value: value,
                            child: Text(
                              value.title,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        onChanged: (RefundStatus? newValue) {
                          selectedRefundStatus.value = newValue!;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: amountController,
                    lebelText: '${'refund_amount'.tr()} *',
                    numberFormatters: true,
                    validator: (text) => ValidatorLogic.requiredField(text,
                        fieldName: 'refund_amount'.tr()),
                  ),
                  SizedBox(height: 10.h),
                  SwitchListTile(
                    value: refundGood.value,
                    onChanged: (value) => refundGood.value = value,
                    title: Text('refund_goods'.tr()),
                  ),
                  SizedBox(height: 10.h),
                  SwitchListTile(
                    value: fullfilledOrder.value,
                    onChanged: (value) => fullfilledOrder.value = value,
                    title: Text('fullfilled_order'.tr()),
                  ),
                  SizedBox(height: 10.h),
                  KMultiLineTextField(
                    controller: descriptionController,
                    lebelText: 'description'.tr(),
                    maxLines: 4,
                  ),
                  SizedBox(height: 10.h),
                  SwitchListTile(
                    value: notify.value,
                    onChanged: (value) => notify.value = value,
                    title: Text('send_notification_email'.tr()),
                  ),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.buttonColor),
                    onPressed: loading
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              ref.read(refundProvider.notifier).initiateRefund(
                                    amount: amountController.text,
                                    description: descriptionController.text,
                                    notifyCustomer:
                                        notify.value == true ? 1 : 0,
                                    orderFulfilled:
                                        fullfilledOrder.value == true
                                            ? 'on'
                                            : 'off',
                                    returnGoods:
                                        refundGood.value == true ? 'on' : 'off',
                                    orderId: orderId,
                                    shopId: shopId,
                                    status: selectedRefundStatus.value.id,
                                  );
                            }
                          },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50.h,
                      child: Center(
                        child: loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Text(
                                'initiate'.tr(),
                              ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
