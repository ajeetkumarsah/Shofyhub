import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_group/category_group_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_group/trash_category_group_page.dart';

class CategoryGroupHome extends HookConsumerWidget {
  const CategoryGroupHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      CategoryGroup.index.value = 0;
      return null;
    }, []);

    const screens = [
      CategoryGroupPage(),
      TrashCategoryGroupPage(),
    ];

    return ValueListenableBuilder(
        valueListenable: CategoryGroup.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: CategoryGroup.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: CategoryGroup.index.value,
                onTap: (value) {
                  CategoryGroup.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list),
                      label: 'category_groups'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
