import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubTitleText extends StatelessWidget {
  final String subTitleText;
  const SubTitleText({
    Key? key,
    required this.subTitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitleText,
      style: TextStyle(
        color: const Color(0xFF4D4D4D),
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
