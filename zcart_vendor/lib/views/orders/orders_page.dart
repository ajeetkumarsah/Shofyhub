import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/views/orders/components/order_list_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: _orders.length,
        itemBuilder: (context, index) => OrderListItem(order: _orders[index]),
      ),
    );
  }
}

List<OrderModel> _orders = [
  for (var i = 0; i < 30; i++)
    OrderModel(
      id: "1232434BDHSHD",
      customerName: "K M Shahriar Hossain",
      date: "30 Sep 2021",
      total: "32.90",
      status: "Completed",
      itemCount: 2,
    )
];

class OrderModel {
  String id;
  String customerName;
  String date;
  String total;
  String status;
  int itemCount;
  OrderModel({
    required this.id,
    required this.customerName,
    required this.date,
    required this.total,
    required this.status,
    required this.itemCount,
  });
}
