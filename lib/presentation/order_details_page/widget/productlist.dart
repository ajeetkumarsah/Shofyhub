import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Productlist extends StatelessWidget {
  final int quantity;
  final String price;
  final String name;
  final String desc;
  final String image;
  const Productlist(
      {Key? key,
      required this.desc,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 39.h,
          width: 39.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 170.w),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              constraints: BoxConstraints(maxWidth: 170.w),
              child: Text(
                desc,
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        Column(
          children: [
            Text(
              price,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'QTY $quantity',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}
