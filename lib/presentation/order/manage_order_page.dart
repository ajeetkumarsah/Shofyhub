import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/carriers/carriers_provider.dart';
import 'package:zcart_seller/application/app/delivary%20boys/delivary_boy_provider.dart';
import 'package:zcart_seller/application/app/order/order_details_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_status_provider.dart';
import 'package:zcart_seller/presentation/order/widget/add_admin_note.dart';
import 'package:zcart_seller/presentation/order/widget/archive_order_confirmation.dart';
import 'package:zcart_seller/presentation/order/widget/cancle_order_confirmation_dialog.dart';
import 'package:zcart_seller/presentation/order/widget/order_status_dialog.dart';
import 'package:zcart_seller/presentation/order/widget/view_address_popup.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_button.dart';

import 'proceed_order_page.dart';
import '../widget_for_all/color.dart';
import 'fullfill_order_dialog.dart';

class ManageOrderPage extends HookConsumerWidget {
  final int id;
  const ManageOrderPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(delivaryBoyProvider.notifier).getDelivaryBoys();
        ref.read(orderDetailsProvider(id).notifier).getOrderDetails();
        ref.read(carriersProvider.notifier).getCarrier();
        ref.read(orderStatusProvider.notifier).getOrderStatus();
        // ref.read(orderDetailsProvider(id).notifier).getInvoice();
      });
      return null;
    }, []);
    final orderDetails = ref.watch(orderDetailsProvider(id)).orderDetails;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Manage Order'),
        elevation: 0,
        actions: [
          PopupMenuButton(
              onSelected: (index) {
                if (index == 1) {
                  showDialog(
                      context: context,
                      builder: (context) => AddAdminNote(
                            orderId: orderDetails.id,
                          ));
                } else if (index == 2) {
                  showDialog(
                      context: context,
                      builder: (context) => ArchivedOrderConfirmation(
                            orderId: orderDetails.id,
                          ));
                } else if (index == 3) {
                  showDialog(
                      context: context,
                      builder: (context) => FullfillorderDialog(
                            orderId: orderDetails.id,
                            tarckingId: orderDetails.tracking_id,
                          ));
                } else if (index == 4) {
                  showDialog(
                      context: context,
                      builder: (context) => OrderStatusDialog(
                            orderId: orderDetails.id,
                            orderStatus: orderDetails.order_status,
                          ));
                }
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text("Add note"),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text("Archive order"),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text("Fullfill order"),
                    ),
                    const PopupMenuItem(
                      value: 4,
                      child: Text("Update order status"),
                    )
                  ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15).r,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderDetails.items.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: const Color(0xffF5F5F5),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10).r,
                        child: Container(
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.white,
                          ),
                          child: Image.network(orderDetails.items[index].image),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 140.w,
                              ),
                              child: Text(
                                orderDetails.items[index].slug,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(orderDetails.items[index].unit_price),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 140.w,
                              ),
                              child: Text(
                                orderDetails.items[index].description,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  orderDetails.items[index].total,
                                  style: const TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: 145.w,
                                ),
                                Text(
                                    "Qty: ${orderDetails.items[index].quantity}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
              ),

              Material(
                elevation: 4,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Order details:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(
                        thickness: 0.7.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Order id: ${orderDetails.order_number}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Customer details:",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "name: ${orderDetails.customer?.name}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Phone: ${orderDetails.customer?.phone_number}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // Text(
                      //   "Address: ${orderDetails.shipping_address}",
                      //   style: TextStyle(
                      //     fontSize: 16.sp,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Order status: ${orderDetails.order_status}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Payment status: ${orderDetails.payment_status}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Order date: ${orderDetails.order_date}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Payment method: ${orderDetails.payment_method.name}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffEA2264),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => ViewAddressPopup(
                                  billingAddress: orderDetails.billing_address,
                                  shippingAddress:
                                      orderDetails.shipping_address));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_city_sharp),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Text("View Address"),
                          ],
                        ),
                      ),
                      if (orderDetails.order_status != 'DELIVERED')
                        OutlinedButton(
                          onPressed: () {
                            ref
                                .read(orderProvider(null).notifier)
                                .markAsDelivered(orderDetails.id, true);
                            ref
                                .read(orderDetailsProvider(id).notifier)
                                .getOrderDetails();
                          },
                          child: const Text('Mark as Delivered'),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Material(
                elevation: 4,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price details:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(
                        thickness: 0.7.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total selling amount:",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            orderDetails.total,
                            style: TextStyle(
                              fontSize: 16.sp,
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
                          Text(
                            "Shipping:",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            orderDetails.shipping,
                            style: TextStyle(
                              fontSize: 16.sp,
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
                          Text(
                            "Tax:",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            orderDetails.taxes,
                            style: TextStyle(
                              fontSize: 16.sp,
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
                          Text(
                            "Discount:",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            orderDetails.discount,
                            style: TextStyle(
                              fontSize: 16.sp,
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
                          Text(
                            "packaging:",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            orderDetails.packaging,
                            style: TextStyle(
                              fontSize: 16.sp,
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
                          Text(
                            "handling:",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            orderDetails.handling,
                            style: TextStyle(
                              fontSize: 16.sp,
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
                          Text(
                            "Total amount:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            orderDetails.grand_total,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (orderDetails.payment_status == "UNPAID") {
                            ref
                                .read(orderDetailsProvider(id).notifier)
                                .markAsPaid();
                          } else {
                            ref
                                .read(orderDetailsProvider(id).notifier)
                                .markAsUnpaid();
                          }
                        },
                        child: Text(
                          orderDetails.payment_status == "UNPAID"
                              ? 'Mark as Paid'
                              : 'Mark as Unpaid',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),

              // TextButton(
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) =>
              //             PDFScreen(orderId: orderDetails.id)));
              //   },
              //   child: const Text(
              //     'Show Invoice',
              //   ),
              // ),

              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: KButton(
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CancelOrderDialog(
                      orderId: orderDetails.id,
                    ),
                  );
                },
                child: const Text("Cancel"),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: KButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ProceedOrderScreen(
                      orderId: orderDetails.id,
                    ),
                  );
                },
                child: const Text("Proceed"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
