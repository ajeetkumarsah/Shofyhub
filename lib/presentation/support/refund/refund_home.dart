import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/support/refund/close_refund_page.dart';
import 'package:zcart_seller/presentation/support/refund/open_refund_page.dart';

class RefundHome extends HookConsumerWidget {
  const RefundHome({Key? key, this.hasAppbar = false}) : super(key: key);
  final bool hasAppbar;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      RefundUtility.index.value = 0;
      return null;
    }, []);

    const screens = [
      OpenRefundPage(),
      CloseRefundPage(),
    ];
    return ValueListenableBuilder(
        valueListenable: RefundUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            appBar: !hasAppbar
                ? const PreferredSize(
                    preferredSize: Size.fromHeight(0), child: SizedBox())
                : AppBar(
                    toolbarHeight: 60.h,
                    backgroundColor: Constants.appbarColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(22.r),
                      ),
                    ),
                    title: Text('refund'.tr()),
                    elevation: 0,
                  ),
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
