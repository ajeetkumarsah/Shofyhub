import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubgroupListTile extends StatelessWidget {
  final String image;
  final String title;
  final String categoryCount;
  final Function()? onPressed;
  const SubgroupListTile({
    Key? key,
    required this.image,
    required this.title,
    required this.categoryCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: Container(
        padding: const EdgeInsets.all(10),
        height: 80.h,
        width: 70.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white70,
        ),
        child: Image.network(image),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
      ),
      // trailing: IconButton(
      //   onPressed: onPressed,
      //   icon: const Icon(Icons.create),
      // ),
      subtitle: Text(
        'Categories : $categoryCount',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
