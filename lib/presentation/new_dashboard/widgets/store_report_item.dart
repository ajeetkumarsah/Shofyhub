import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreReportItems extends StatelessWidget {
  final String itemIcon;
  final String itemValues;
  final String itemName;

  const StoreReportItems({
    Key? key,
    required this.itemIcon,
    required this.itemValues,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageIcon(
          AssetImage(itemIcon),
          color: const Color(0xFF683CB7),
          size: 50,
        ),
        Text(
          itemValues,
          style: TextStyle(
            color: const Color(0xFF683CB7),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            itemName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
