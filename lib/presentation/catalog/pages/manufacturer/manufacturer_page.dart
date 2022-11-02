import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/manufacturer_list_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/trash_manufacturer_page.dart';

class ManufacrurerPage extends HookConsumerWidget {
  const ManufacrurerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    const screens = [
      ManufacturerListPage(),
      TrashManufacturerPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: ProductUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: ProductUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: ProductUtility.index.value,
                onTap: (value) {
                  ProductUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list),
                      label: 'manufacturers'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
