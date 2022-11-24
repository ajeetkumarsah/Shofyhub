import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/order/order_model.dart';

import '../../../infrastructure/app/constants.dart';
import 'order_status_dialog.dart';

class ArchivedOrderTile extends StatelessWidget {
  const ArchivedOrderTile(
      {Key? key, required this.order, required this.unArchive})
      : super(key: key);

  final OrderModel order;
  final void Function() unArchive;

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
                    height: 16.h,
                    width: 50.h,
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
              SizedBox(
                height: 40.h,
                width: 240.w,
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
                  onPressed: unArchive,
                  child: const Text(
                    "Unarchive Order",
                    style: TextStyle(
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
