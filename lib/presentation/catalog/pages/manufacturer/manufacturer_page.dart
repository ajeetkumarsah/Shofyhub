import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/manufacturer_list_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/trash_manufacturer_page.dart';

class ManufacrurerPage extends HookConsumerWidget {
  const ManufacrurerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      ManufacturerUtility.index.value = 0;
      return null;
    }, []);

    const screens = [
      ManufacturerListPage(),
      TrashManufacturerPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: ManufacturerUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: ManufacturerUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: ManufacturerUtility.index.value,
                onTap: (value) {
                  ManufacturerUtility.index.value = value;
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
