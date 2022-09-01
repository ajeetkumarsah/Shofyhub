import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class MoreOptionItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;
  const MoreOptionItems(
      {Key? key, required this.title, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
              radius: 30.r,
              backgroundColor: Constants.iconColor,
              child: Icon(
                icon,
                color: Colors.white,
                size: 20.sp,
              )),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF484848),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
