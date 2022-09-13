import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../infrastructure/app/constants.dart';

class InitiateRefundPage extends HookConsumerWidget {
  final int orderId;
  const InitiateRefundPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // final shopId =
    //     ref.watch(authProvider.select((value) => value.user.shop_id));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Initiate Refund'),
        elevation: 0,
      ),
    );
  }
}
