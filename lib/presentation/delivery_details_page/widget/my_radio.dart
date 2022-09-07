import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRadio extends StatefulWidget {
  const MyRadio({Key? key}) : super(key: key);

  @override
  State<MyRadio> createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380.h,
      width: 350.w,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          RadioListTile(
              title: Text(
                'Customar is not available',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
              ),
              value: 1,
              groupValue: 1,
              onChanged: (val) {
                setState(() {
                  value == val!;
                });
              }),
          RadioListTile(
              title: Text(
                'Customar is not responding',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
              ),
              value: 2,
              groupValue: 2,
              onChanged: (val) {
                setState(() {
                  value == val!;
                });
              }),
          RadioListTile(
              title: Text(
                'Customar is not accept the order',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
              ),
              value: 3,
              groupValue: 3,
              onChanged: (val) {
                setState(() {
                  value == val!;
                });
              }),
          RadioListTile(
              title: Text(
                '''I can't deliver the order''',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
              ),
              value: 3,
              groupValue: 3,
              onChanged: (val) {
                setState(() {
                  value == val!;
                });
              }),
          RadioListTile(
              title: Text(
                'Other',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
              ),
              value: 3,
              groupValue: 3,
              onChanged: (val) {
                setState(() {
                  value == val!;
                });
              }),
          Text(
            'NOTE: Refund amount of Rs.224 will be\n creditedin the wallet',
            style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 45.w),
            ),
            child: const Text(
              'Cancle Order',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
