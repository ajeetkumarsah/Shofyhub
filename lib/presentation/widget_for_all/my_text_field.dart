import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final IconData icone;
  final String? hintText;
  const MyTextField(
      {Key? key, required this.icone, this.hintText, this.lebelText})
      : super(key: key);
  final String? lebelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.grey,
          width: 1.w,
        ),
      ),
      child: TextField(
        //textAlign: TextAlign.start,
        decoration: InputDecoration(
          prefixIcon: Icon(icone),
          border: InputBorder.none,
          hintText: hintText,
          alignLabelWithHint: true,
          labelText: lebelText ?? '',
        ),
      ),
    );
  }
}
