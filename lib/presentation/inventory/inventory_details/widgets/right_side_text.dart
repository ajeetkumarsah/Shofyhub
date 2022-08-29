import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightSideText extends StatelessWidget {
  final String subTitle;
  const RightSideText({
    Key? key,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 160.w,
      ),
      child: Text(
        subTitle,
        textAlign: TextAlign.end,
        style: TextStyle(
          color: const Color(0xFF4D4D4D),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
