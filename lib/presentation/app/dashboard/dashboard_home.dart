import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/app/dashboard/dashboard_page.dart';
import 'package:zcart_seller/presentation/order/order_main_page.dart';
import 'package:zcart_seller/presentation/settings.dart/settings_home.dart';

class DashboardHome extends HookConsumerWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    const screens = [
      DashboardPage(),
      OrderMainPage(index: 0),
      SettingsHome(),
    ];

    return ValueListenableBuilder(
        valueListenable: DashboardUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: DashboardUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                elevation: 5,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: DashboardUtility.index.value,
                onTap: (value) {
                  DashboardUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.dashboard),
                      label: 'dashboard'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list_alt_sharp),
                      label: 'orders'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.settings), label: 'settings'.tr()),
                ]),
          );
        });
  }
}
