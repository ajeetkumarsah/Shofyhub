import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreOptionItems extends StatelessWidget {
  final String itemIcon;

  final String itemName;

  const MoreOptionItems({
    Key? key,
    required this.itemIcon,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: const Color(0xFF683CB7),
          child: ImageIcon(
            AssetImage(itemIcon),
            color: Colors.white,
            size: 60,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          itemName,
          style: TextStyle(
            color: const Color(0xFF484848),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
