 
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_details_provider.dart';
import 'package:zcart_seller/application/app/order/order_details_state.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_status_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/order/order_status_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_button.dart';

class OrderStatusDialog extends HookConsumerWidget {
  final int orderId;
  final String orderStatus;
  const OrderStatusDialog(
      {Key? key, required this.orderId, required this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final statusList =
        ref.watch(orderStatusProvider.select((value) => value.orderStatus));
    final OrderStatusModel status = (statusList
        .where((element) => element.name.toUpperCase() == orderStatus)
        .toList()[0]);
    final selectedStatus = useState(status);
    final notifyCustomer = useState(true);

    ref.listen<OrderDetailsState>(orderDetailsProvider(orderId),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          ref.read(orderProvider(null).notifier).getOrders();
          ref.read(orderProvider(OrderFilter.unfullfill).notifier).getOrders();
          ref.read(orderProvider(OrderFilter.unfullfill).notifier).getOrders();

          NotificationHelper.success(message: 'order_status_updated'.tr());

          // CherryToast.info(
          //   title: const Text('Order Status Updated'),
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
    final loading = ref
        .watch(orderDetailsProvider(orderId).select((value) => value.loading));
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      title: const Text(
        "Update Status",
      ),
      content: SizedBox(
        width: 300.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: statusList.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    statusList[index].name == selectedStatus.value.name
                        ? InkWell(
                            onTap: () {
                              selectedStatus.value = statusList[index];
                            },
                            child: const Icon(
                              Icons.check_circle,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              selectedStatus.value = statusList[index];
                            },
                            child: const Icon(
                              Icons.circle_outlined,
                            ),
                          ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      statusList[index].name,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text(
                  "Note: refund amount of rs.2443 will be creadited in the wallet"),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  notifyCustomer.value
                      ? InkWell(
                          onTap: () {
                            notifyCustomer.value = !notifyCustomer.value;
                          },
                          child: const Icon(
                            Icons.check_box,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            notifyCustomer.value = !notifyCustomer.value;
                          },
                          child: const Icon(
                            Icons.check_box_outline_blank_rounded,
                          ),
                        ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Notify Customer?',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              KButton(
                  onPressed: () {
                    ref
                        .read(orderDetailsProvider(orderId).notifier)
                        .updateOrderStatus(
                            int.parse(selectedStatus.value.id), true);
                  },
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Update Status')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.black54, fontSize: 15.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
