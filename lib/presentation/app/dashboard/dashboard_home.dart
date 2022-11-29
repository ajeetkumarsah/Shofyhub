import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/notification/notification_provider.dart';
import 'package:zcart_seller/application/core/shared_prefs.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/infrastructure/app/notification/notification_repo.dart';
import 'package:zcart_seller/presentation/app/dashboard/dashboard_page.dart';
import 'package:zcart_seller/presentation/order/order_main_page.dart';
import 'package:zcart_seller/presentation/settings.dart/settings_home.dart';
import 'package:zcart_seller/presentation/support/live_chat/chat_home.dart';

class DashboardHome extends HookConsumerWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        // Post FCM token
        final fcmToken = await SharedPref.getFcmToken();
        NotificationRepo().postFcmToken(token: fcmToken);

        final notificatiornFromPrefs = await SharedPref.getNotifications();
        ref
            .read(notificationProvider)
            .saveAllNotification(notificatiornFromPrefs);
      });
      return null;
    }, []);

    const screens = [
      DashboardPage(),
      OrderMainPage(index: 0),
      ChatHome(),
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
                      icon: const Icon(Icons.message), label: 'messages'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.settings), label: 'settings'.tr()),
                ]),
          );
        });
  }
}
