import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/stock/suppliers/supplier_list_page.dart';
import 'package:zcart_seller/presentation/stock/suppliers/trash_supplier_list_page.dart';

class SupplierPage extends HookConsumerWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    const screens = [
      SupplierListPage(),
      TrashSupplierPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: SupplierUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: SupplierUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: SupplierUtility.index.value,
                onTap: (value) {
                  SupplierUtility.index.value = value;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'Suppliers'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.delete), label: 'Trash'),
                ]),
          );
        });
  }
}
