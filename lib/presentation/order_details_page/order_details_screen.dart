import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/carriers/carriers_provider.dart';
import 'package:alpesportif_seller/application/app/delivary_boys/delivary_provider.dart';
import 'package:alpesportif_seller/application/app/order/order_details_provider.dart';
import 'package:alpesportif_seller/application/app/order/order_status_provider.dart';
import 'package:alpesportif_seller/application/app/settings/shop_settings_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/order/widget/add_admin_note.dart';
import 'package:alpesportif_seller/presentation/order/widget/archive_order_confirmation.dart';
import 'package:alpesportif_seller/presentation/order/widget/cancle_order_confirmation_dialog.dart';
import 'package:alpesportif_seller/presentation/order/widget/mark_as_delivered_dialog.dart';
import 'package:alpesportif_seller/presentation/order/widget/mark_as_paid_undaip_dialog.dart';
import 'package:alpesportif_seller/presentation/order/widget/order_status_dialog.dart';
import 'package:alpesportif_seller/presentation/order_details_page/widget/productlist.dart';
import 'package:alpesportif_seller/presentation/support/refund/initiate_refund_page.dart';

class OrderDetailsScreen extends HookConsumerWidget {
  final int id;
  const OrderDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(delivaryProvider.notifier).getDelivaryBoys();
        ref.read(orderDetailsProvider(id).notifier).getOrderDetails();
        ref.read(carriersProvider.notifier).getCarrier();
        ref.read(orderStatusProvider.notifier).getOrderStatus();
        // ref.read(orderDetailsProvider(id).notifier).getInvoice();
      });
      return null;
    }, []);
    final orderDetails = ref.watch(orderDetailsProvider(id)).orderDetails;
    final loading =
        ref.watch(orderDetailsProvider(id).select((value) => value.loading));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        toolbarHeight: 70.h,
        backgroundColor: Constants.appbarColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
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
                            details: true,
                            orderId: orderDetails.id,
                          ));
                } else if (index == 3) {
                  showDialog(
                      context: context,
                      builder: (context) => MarkAsDeliveredDialog(
                            orderId: orderDetails.id,
                          ));
                } else if (index == 4) {
                  showDialog(
                      context: context,
                      builder: (context) => OrderStatusDialog(
                            orderId: orderDetails.id,
                            orderStatus: orderDetails.order_status,
                          ));
                } else if (index == 5) {
                  showDialog(
                      context: context,
                      builder: (context) => InitiateRefundPage(
                            orderId: orderDetails.id,
                            orderNuber: orderDetails.order_number,
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
                    if (orderDetails.order_status != 'DELIVERED')
                      const PopupMenuItem(
                        value: 3,
                        child: Text("Mark as Delivered"),
                      ),
                    if (orderDetails.order_status != 'FULFILLED')
                      const PopupMenuItem(
                        value: 4,
                        child: Text("Update order status"),
                      ),
                    const PopupMenuItem(
                      value: 5,
                      child: Text("Initiate Refund"),
                    )
                  ])
        ],
      ),
      backgroundColor: const Color(0xffefefef),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderDetails.items.length,
                    itemBuilder: (context, index) => Productlist(
                      desc: orderDetails.items[index].description,
                      name: orderDetails.items[index].slug,
                      quantity: orderDetails.items[index].quantity,
                      price: orderDetails.items[index].total,
                      image: orderDetails.items[index].image,
                    ),
                    separatorBuilder: (context, index) => Column(
                      children: [
                        SizedBox(height: 14.h),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Selling Amount',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.total,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.shipping,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.taxes,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.discount,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Packaging',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.packaging,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Handling',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.handling,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.grand_total,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        orderDetails.order_number,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name:',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.customerName,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone:',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.customer_phone_number,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order status:',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.order_status,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Status:',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.payment_status,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Date:',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.order_date,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method:',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        orderDetails.payment_method.name,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Shipping Address:',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    // height: 60.h,
                    width: 179.w,
                    child: Text(
                      orderDetails.shipping_address,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Billing Address:',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 60.h,
                    width: 179.w,
                    child: Text(
                      orderDetails.billing_address,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
      ),
      bottomNavigationBar: loading
          ? const SizedBox()
          : ref.watch(shopSettingsProvider).systemConfigs.vendorGetPaid
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 37.h,
                        width: 160.w,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => CancelOrderDialog(
                                orderId: orderDetails.id,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFFD0D0),
                              shape: const StadiumBorder()),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Color(0xffF80000)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 37.h,
                        width: 160.w,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => MarkAsPaidUnpaidDialog(
                                orderId: orderDetails.id,
                                isPaid: orderDetails.payment_status == "UNPAID"
                                    ? false
                                    : true,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff683CB7),
                              shape: const StadiumBorder()),
                          child: Text(
                            orderDetails.payment_status == "UNPAID"
                                ? 'Mark as Paid'
                                : 'Mark as Unpaid',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: SizedBox(
                    height: 37.h,
                    width: 160.w,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CancelOrderDialog(
                            orderId: orderDetails.id,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFD0D0),
                          shape: const StadiumBorder()),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xffF80000)),
                      ),
                    ),
                  ),
                ),
    );
  }
}
