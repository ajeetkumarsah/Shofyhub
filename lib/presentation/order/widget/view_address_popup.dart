import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_button.dart';

class ViewAddressPopup extends StatelessWidget {
  final String shippingAddress;
  final String billingAddress;
  const ViewAddressPopup(
      {Key? key, required this.billingAddress, required this.shippingAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Address'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipping Addrass:",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(shippingAddress),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Billing Addrass:",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(billingAddress),
        ],
      ),
      actions: [
        KButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
