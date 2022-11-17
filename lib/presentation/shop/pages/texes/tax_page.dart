import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/texes/tax_list_page.dart';
import 'package:zcart_seller/presentation/shop/pages/texes/trash_tax_list_page.dart';

class TaxPage extends HookConsumerWidget {
  const TaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    const screens = [
      TaxListPage(),
      TrashTaxListPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: TaxUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: TaxUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: TaxUtility.index.value,
                onTap: (value) {
                  TaxUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list), label: 'taxes'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
