import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/presentation/order/fullfill_order_dialog.dart';
import 'package:zcart_seller/presentation/order/proceed_order_page.dart';
import 'package:zcart_seller/presentation/order/widget/archive_order_confirmation.dart';
import 'package:zcart_seller/presentation/order/widget/order_status_dialog.dart';
import 'package:zcart_seller/presentation/order_details_page/order_details_screen.dart';

class NewOrderPage extends HookConsumerWidget {
  final bool allOrder;
  const NewOrderPage({Key? key, required this.allOrder}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider(OrderFilter.unfullfill).notifier).getOrders();
        ref.read(orderProvider(null).notifier).getOrders();
      });
      return null;
    }, []);
    final unfullfilledOrderList = ref.watch(
        orderProvider(OrderFilter.unfullfill)
            .select((value) => value.orderList));
    final allOrderList = ref.watch(orderProvider(null)).orderList;
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: ListView.separated(
        padding: const EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
        ).r,
        itemCount:
            allOrder ? allOrderList.length : unfullfilledOrderList.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 20,
          color: Color(0xffEFEFEF),
        ),
        itemBuilder: (context, index) {
          final order =
              allOrder ? allOrderList[index] : unfullfilledOrderList[index];
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OrderDetailsScreen(
                                id: order.id,
                              )));
                },
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 20)
                          .r,
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
                                          ? const Color.fromARGB(
                                              255, 45, 107, 47)
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
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ProceedOrderScreen(
                                      orderId: order.id,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 16.h,
                                  width: 50.h,
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
                                          builder: (context) =>
                                              OrderStatusDialog(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40.h,
                                width: 240.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xffE5EFFA),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1.w,
                                          color: const Color(0xff683CB7),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      )),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            FullfillorderDialog(
                                              tarckingId: order.trackingId,
                                              orderId: order.id,
                                            ));
                                  },
                                  child: const Text(
                                    "Fulfil Order",
                                    style: TextStyle(
                                      color: Color(0xff683CB7),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                                width: 40.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      primary: const Color(0xffE5EFFA),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1.w,
                                          color: const Color(0xff683CB7),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      )),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            ArchivedOrderConfirmation(
                                              orderId: order.id,
                                            ));
                                  },
                                  child: const Icon(
                                    Icons.archive,
                                    color: Color(0xff683CB7),
                                    // size: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
