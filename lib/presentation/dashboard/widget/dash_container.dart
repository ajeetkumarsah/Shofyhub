import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashContainer extends StatelessWidget {
  final String number;
  final String text;
  final Color circularColor;
  final IconData icone;
  final VoidCallback onTapped;
  final Color iconeColor;
  const DashContainer(
      {Key? key,
      required this.number,
      required this.text,
      required this.circularColor,
      required this.icone,
      required this.iconeColor,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        height: 90.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey, width: 1.w),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number,
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 55.h,
                width: 55.w,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: circularColor),
                child: Icon(
                  icone,
                  size: 30.sp,
                  color: iconeColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
