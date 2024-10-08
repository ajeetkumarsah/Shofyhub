import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/core/utility.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/shop/pages/user/trash_user_list_page.dart';
import 'package:alpesportif_seller/presentation/shop/pages/user/user_list_page.dart';

class UserPage extends HookConsumerWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      ShopUserUtility.index.value = 0;
      return null;
    }, []);

    const screens = [
      UserListPage(),
      TrashUserListPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: ShopUserUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: ShopUserUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: ShopUserUtility.index.value,
                onTap: (value) {
                  ShopUserUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list), label: 'shop_user'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
