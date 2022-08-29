import 'package:flutter/material.dart';
import 'package:zcart_vendor/config/config.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/views/custom/inline_title_info_item.dart';
import 'package:zcart_vendor/views/orders/orders_page.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel order;

  const OrderListItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        color: MyConfig.accentColor,
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InlineTitleInfoItem(info: order.id, title: 'Order ID'),
              Text(order.date),
            ],
          ),
          const SizedBox(height: defaultPadding / 3),
          InlineTitleInfoItem(info: "\$${order.total}", title: 'Order amount'),
          const SizedBox(height: defaultPadding / 3),
          InlineTitleInfoItem(title: "Name", info: order.customerName),
          const SizedBox(height: defaultPadding / 3),
          InlineTitleInfoItem(title: "Items", info: order.itemCount.toString()),
          const SizedBox(height: defaultPadding / 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text("Manage Order"),
              ),
              Chip(
                label: Text(order.status),
              )
            ],
          )
        ],
      ),
    );
  }
}
