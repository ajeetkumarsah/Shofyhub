import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/core/utility.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/shop/pages/taxes/tax_list_page.dart';
import 'package:alpesportif_seller/presentation/shop/pages/taxes/trash_tax_list_page.dart';

class TaxPage extends HookConsumerWidget {
  const TaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      TaxUtility.index.value = 0;
      return null;
    }, []);

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
