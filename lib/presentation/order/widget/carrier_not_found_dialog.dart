import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarrierNotFoundDialog extends HookConsumerWidget {
  const CarrierNotFoundDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'carrier_not_found'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.h,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text('carrier_not_found_please_add'.tr()),
      ),
      actions: [
        const Divider(
          height: 1,
          thickness: 1,
        ),
        SizedBox(
          height: 15.h,
        ),
        const SizedBox(),
        Padding(
          padding: EdgeInsets.only(right: 25.w),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40.h,
              width: 85.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(
                  color: Theme.of(context).shadowColor.withOpacity(.5),
                ),
              ),
              child: Center(
                child: Text('ok'.tr()),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
