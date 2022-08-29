import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePass extends StatelessWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 5.h),
          Text(
            'Are you sure?',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                color: Colors.grey.shade700),
          ),
          SizedBox(height: 15.h),
          Text(
            'Do you want to change password?',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                color: Colors.grey.shade700),
          ),
          SizedBox(height: 15.h),
          Text(
            '''You'll be sent a password rest link on your email''',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 15.sp,
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
