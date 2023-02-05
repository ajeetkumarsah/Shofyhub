import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class SingleImageUpload extends StatelessWidget {
  const SingleImageUpload({
    Key? key,
    required this.title,
    required this.image,
    required this.clearFunction,
    required this.picFunction,
  }) : super(key: key);

  final File? image;
  final String title;
  final Function picFunction;
  final Function clearFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: image != null
                  ? Container(
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Constants.kBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )),
                    )
                  : Container(
                      height: 120,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Constants.kBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Icon(Icons.image),
                      ),
                    ),
            ),
            SizedBox(width: 20.h),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.kDarkCardBgColor,
                    ),
                    onPressed: () {
                      clearFunction();
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40.h,
                      child: Center(
                        child: Text(
                          'clear_image'.tr(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.buttonColor,
                    ),
                    onPressed: () {
                      picFunction();
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40.h,
                      child: Center(
                        child: Text(
                          'upload'.tr(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
