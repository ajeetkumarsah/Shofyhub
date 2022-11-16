import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/attribute_list_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/trash_attributes_list_page.dart';

class AttributePage extends HookConsumerWidget {
  const AttributePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    const screens = [
      AttributeListPage(),
      TrashAttributeListPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: AttributeUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: AttributeUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: AttributeUtility.index.value,
                onTap: (value) {
                  AttributeUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list), label: 'attributes'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
