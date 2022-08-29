import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArchivedOrderTile extends StatelessWidget {
  final String buttonName;
  final String orderNumber;
  final String orderAmount;
  // final String name;
  final String date;
  final int items;
  final Function()? onDelete;
  final Function()? onpress;
  const ArchivedOrderTile(
      {Key? key,
      required this.buttonName,
      required this.date,
      required this.items,
      required this.onpress,
      required this.orderAmount,
      required this.orderNumber,
      required this.onDelete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color.fromARGB(255, 243, 242, 242)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Order id: ',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16.sp,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: orderNumber,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              text: 'Order amount: ',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16.sp,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Rs.$orderAmount',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          // RichText(
          //   text: TextSpan(
          //     text: 'Name: ',
          //     style: TextStyle(
          //       color: Colors.grey.shade700,
          //       fontSize: 16.sp,
          //     ),
          //     children: <InlineSpan>[
          //       TextSpan(
          //         text: name,
          //         style: TextStyle(
          //             fontSize: 16.sp,
          //             color: Colors.grey.shade700,
          //             fontWeight: FontWeight.w500),
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onpress,
                child: Container(
                  height: 38.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey, width: 1.w),
                  ),
                  child: Center(
                    child: Text(
                      buttonName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30.sp,
                  )),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: 'Items: ',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: items.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
