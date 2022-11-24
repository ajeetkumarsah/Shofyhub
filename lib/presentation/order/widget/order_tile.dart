import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/order/order_delivaryboy.dart';
import 'package:zcart_seller/domain/app/order/order_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/order/fullfill_order_dialog.dart';
import 'package:zcart_seller/presentation/order/widget/assign_delivery_boy_dialog.dart';

import 'archive_order_confirmation.dart';
import 'order_status_dialog.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key? key,
    required this.order,
    this.isFullfilled = false,
  }) : super(key: key);

  final OrderModel order;
  final bool isFullfilled;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20).r,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.orderNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Container(
                    height: 20.h,
                    // width: 50.h,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: order.paymentStatus == 'PAID'
                          ? const Color.fromARGB(255, 179, 224, 180)
                          : const Color(0xffF7D2CD),
                    ),
                    child: Center(
                      child: Text(
                        order.paymentStatus,
                        style: TextStyle(
                          color: order.paymentStatus == 'PAID'
                              ? const Color.fromARGB(255, 45, 107, 47)
                              : const Color(0xffFC5553),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Date",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  Text(
                    order.orderDate,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Delivery boy:",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  order.deliveryBoy != OrderDelivaryBoyModel.init()
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AssigenDelivaryBoyScreen(
                                orderId: order.id,
                              ),
                            );
                          },
                          child: Container(
                            height: 20.h,
                            width: 60.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                            child: Center(
                              child: Text(
                                order.deliveryBoy.niceName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AssigenDelivaryBoyScreen(
                                orderId: order.id,
                              ),
                            );
                          },
                          child: Container(
                            height: 20.h,
                            width: 60.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                            child: const Center(
                              child: Text(
                                "Assign",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Customer:",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    order.customerName,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Grand Total:",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    order.grandTotal,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Status:",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        order.orderStatus,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => OrderStatusDialog(
                                    orderId: order.id,
                                    orderStatus: order.orderStatus,
                                  ));
                        },
                        child: const Icon(
                          Icons.pending_actions,
                          size: 17,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              !isFullfilled
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: Constants.kLightCardBgColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.w,
                                    color: Constants.kBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                )),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ArchivedOrderConfirmation(
                                        orderId: order.id,
                                      ));
                            },
                            child: SizedBox(
                              height: 40.h,
                              child: const Icon(
                                Icons.archive,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.kLightCardBgColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.w,
                                    color: Constants.kBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                )),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => FullfillorderDialog(
                                        tarckingId: order.trackingId,
                                        orderId: order.id,
                                      ));
                            },
                            child: SizedBox(
                              height: 40.h,
                              child: const Center(
                                child: Text(
                                  "Fulfil Order",
                                  style:
                                      TextStyle(color: Constants.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: Constants.kLightCardBgColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.w,
                                    color: Constants.kBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                )),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ArchivedOrderConfirmation(
                                        orderId: order.id,
                                      ));
                            },
                            child: SizedBox(
                              height: 40.h,
                              child: const Icon(
                                Icons.archive,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
