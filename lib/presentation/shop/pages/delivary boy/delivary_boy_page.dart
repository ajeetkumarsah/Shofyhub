import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/delivery_boy_list_page.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/trash_delivery_boy_list_page.dart';

class DeliveryBoyPage extends HookConsumerWidget {
  const DeliveryBoyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    const screens = [
      DelivaryBoyListPage(),
      TrashDelivaryBoyListPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: DeliveryBoyUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: DeliveryBoyUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: DeliveryBoyUtility.index.value,
                onTap: (value) {
                  DeliveryBoyUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list), label: 'delivery_boy'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
