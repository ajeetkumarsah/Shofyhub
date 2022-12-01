import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/roles_list_page.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/trash_roles_list_page.dart';

class RolesPage extends HookConsumerWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      RolesUtility.index.value = 0;
      return null;
    }, []);

    const screens = [
      RolesListPage(),
      TrashRolesListPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: RolesUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: RolesUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: RolesUtility.index.value,
                onTap: (value) {
                  RolesUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list), label: 'user_roles'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
