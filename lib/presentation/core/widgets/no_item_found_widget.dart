import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_forever,
            size: 80,
            color: Constants.kDarkCardBgColor,
          ),
          SizedBox(height: 20.h),
          Text(
            'no_item_available'.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Constants.kDarkCardBgColor,
            ),
          ),
        ],
      ),
    );
  }
}
