import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
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
      });
      return null;
    }, []);

    DateTime? currentBackPressTime;

    final settings = ref.watch(shopSettingsProvider);

    const screens = [
      DashboardPage(),
      OrderMainPage(index: 0),
      ChatHome(),
      SettingsHome(),
    ];

    const screensWithoutChat = [
      DashboardPage(),
      OrderMainPage(index: 0),
      SettingsHome(),
    ];

    return (settings.systemConfigs.enableChat &&
            settings.shopConfigs.enableLiveChat)
        ? ValueListenableBuilder(
            valueListenable: DashboardUtility.index,
            builder: (context, value, child) {
              return WillPopScope(
                onWillPop: () async {
                  if (DashboardUtility.index.value == 0) {
                    DateTime now = DateTime.now();
                    if (currentBackPressTime == null ||
                        now.difference(currentBackPressTime!) >
                            const Duration(seconds: 2)) {
                      currentBackPressTime = now;
                      NotificationHelper.info(
                          message: 'tap_again_to_leave'.tr());
                      return Future.value(false);
                    }
                    return Future.value(true);
                  } else {
                    DashboardUtility.index.value = 0;
                    return false;
                  }
                },
                child: Scaffold(
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
                          icon: const Icon(Icons.message),
                          label: 'messages'.tr()),
                      BottomNavigationBarItem(
                          icon: const Icon(Icons.settings),
                          label: 'settings'.tr()),
                    ],
                  ),
                ),
              );
            })
        : ValueListenableBuilder(
            valueListenable: NoLiveChatDashboardUtility.index,
            builder: (context, value, child) {
              return Scaffold(
                body: IndexedStack(
                  index: NoLiveChatDashboardUtility.index.value,
                  children: screensWithoutChat,
                ),
                bottomNavigationBar: BottomNavigationBar(
                    elevation: 5,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Constants.appbarColor,
                    unselectedItemColor: Colors.grey,
                    selectedFontSize: 12,
                    currentIndex: NoLiveChatDashboardUtility.index.value,
                    onTap: (value) {
                      NoLiveChatDashboardUtility.index.value = value;
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: const Icon(Icons.dashboard),
                          label: 'dashboard'.tr()),
                      BottomNavigationBarItem(
                          icon: const Icon(Icons.list_alt_sharp),
                          label: 'orders'.tr()),
                      BottomNavigationBarItem(
                          icon: const Icon(Icons.settings),
                          label: 'settings'.tr()),
                    ]),
              );
            });
  }
}
