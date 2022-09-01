import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class StoreReportItems extends StatelessWidget {
  final void Function()? onTap;
  final String itemValues;
  final String itemName;
  final IconData icon;
  const StoreReportItems(
      {Key? key,
      this.onTap,
      required this.itemValues,
      required this.itemName,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Constants.iconColor,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              itemValues,
              style: TextStyle(
                color: Constants.iconColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              itemName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
