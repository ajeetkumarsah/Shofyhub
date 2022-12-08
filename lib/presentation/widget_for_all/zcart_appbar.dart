import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/notification/notification_provider.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/notification/notification_page.dart';
import 'package:zcart_seller/presentation/settings.dart/settings_home.dart';

class ZcartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ZcartAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Constants.appbarColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SettingsHome()));
                  },
                  child: Container(
                      constraints:
                          const BoxConstraints(maxHeight: 50, maxWidth: 50),
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(left: 10, right: 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.network(
                        ref.watch(shopSettingsProvider
                            .select((value) => value.shopSettings.logo)),
                        errorBuilder: (c, e, s) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      )),
                );
              }),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Expanded(
                child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationPage()),
                );
              },
              icon: Consumer(builder: (context, ref, child) {
                int notificationCount =
                    ref.watch(notificationProvider).notificationCount;
                return notificationCount > 0
                    ? Badge(
                        padding: const EdgeInsets.all(6),
                        badgeColor: Constants.kGreenColor,
                        badgeContent: Text(
                          notificationCount.toString(),
                          style: TextStyle(color: Constants.kLightCardBgColor),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      );
              }),
            )),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
