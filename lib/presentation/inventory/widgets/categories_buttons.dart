import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesButtons extends StatelessWidget {
  final String buttonName;
  const CategoriesButtons({
    Key? key,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF683CB7),
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF4D4D4D),
        ),
      ),
    );
  }
}
