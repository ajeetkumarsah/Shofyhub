import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/core/utility.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/stock/warehouse/trash_warehouse_page.dart';
import 'package:alpesportif_seller/presentation/stock/warehouse/warehouse_list_page.dart';

class WarehousePage extends HookConsumerWidget {
  const WarehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      WarehouseUtility.index.value = 0;
      return null;
    }, []);

    const screens = [
      WarehouseListPage(),
      TrashWarehousePage(),
    ];

    return ValueListenableBuilder(
        valueListenable: WarehouseUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: WarehouseUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: WarehouseUtility.index.value,
                onTap: (value) {
                  WarehouseUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list), label: 'warehouses'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
