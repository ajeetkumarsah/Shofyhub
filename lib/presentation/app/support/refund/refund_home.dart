import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/app/support/refund/close_refund_page.dart';
import 'package:zcart_seller/presentation/app/support/refund/open_refund_page.dart';

class RefundHome extends StatelessWidget {
  const RefundHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const screens = [
      OpenRefundPage(),
      CloseRefundPage(),
    ];
    return ValueListenableBuilder(
        valueListenable: RefundUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: RefundUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: RefundUtility.index.value,
                onTap: (value) {
                  RefundUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list), label: 'open'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.close), label: 'closed'.tr()),
                ]),
          );
        });
  }
}
