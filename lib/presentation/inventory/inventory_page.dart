import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/inventory/inventory_list_page.dart';
import 'package:zcart_seller/presentation/inventory/trash_inventory_page.dart';

class InventoryPage extends HookConsumerWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    const screens = [
      InventoryListPage(),
      TrashInventoryPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: Utility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: Utility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: Utility.index.value,
                onTap: (value) {
                  Utility.index.value = value;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'Inventories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.delete), label: 'Trash'),
                ]),
          );
        });
  }
}
