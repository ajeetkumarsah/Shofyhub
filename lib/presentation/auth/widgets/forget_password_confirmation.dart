import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_button.dart';

class ForgetPasswordConfirmation extends StatelessWidget {
  const ForgetPasswordConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Forget Password'),
      insetPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 5.h, width: 300.w),
          const Text('The password reset link sent! Please check your email.'),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: 100.w,
          child: KButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok')),
        ),
      ],
    );
  }
}
