import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/carriers/carriers_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/carriers/carrier_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class FullfillorderDialog extends HookConsumerWidget {
  final int orderId;
  final String tarckingId;
  const FullfillorderDialog(
      {Key? key, required this.tarckingId, required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // useEffect(() {
    //   Future.delayed(const Duration(milliseconds: 100), () async {
    //     ref.read(carriersProvider.notifier).getCarrier();
    //   });
    //   return null;
    // }, []);

    final List<CarrierModel> carriers = ref.watch(carriersProvider).carriers;
    final ValueNotifier<CarrierModel?> selectedCarrier = useState(null);
    final trackingIdController = useTextEditingController(text: tarckingId);
    final sendNotification = useState(true);
    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'item_updated'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    final loading = ref.watch(orderProvider.select((value) => value.loading));

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      title: const Center(
        child: Text("Full Fill Order"),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KTextField(
                  controller: trackingIdController, lebelText: 'TrackingId'),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "SHIPPING CARRIER*",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
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
                    value: selectedCarrier.value,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: carriers.map<DropdownMenuItem<CarrierModel>>(
                        (CarrierModel value) {
                      return DropdownMenuItem<CarrierModel>(
                        value: value,
                        child: Text(
                          value.name,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    onChanged: (CarrierModel? newValue) {
                      selectedCarrier.value = newValue!;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  sendNotification.value
                      ? InkWell(
                          onTap: () =>
                              sendNotification.value = !sendNotification.value,
                          child: const Icon(Icons.check_box_rounded))
                      : InkWell(
                          onTap: () =>
                              sendNotification.value = !sendNotification.value,
                          child: const Icon(Icons.check_box_outline_blank)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      "Send a notification email to customer ",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("*Required fields"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(orderProvider.notifier).fulfillOrder(
                          orderId,
                          carriers.isNotEmpty ? selectedCarrier.value!.id : 0,
                          trackingIdController.text,
                          sendNotification.value);
                    },
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text("Update"),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
