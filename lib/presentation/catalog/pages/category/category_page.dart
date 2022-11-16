import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/category_list_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/trash_category_list_page.dart';

class CategoryPage extends HookConsumerWidget {
  final String subGroupName;
  final int categorySubGroupId;
  const CategoryPage(
      {Key? key, required this.subGroupName, required this.categorySubGroupId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var screens = [
      CategoryListPage(
        subGroupName: subGroupName,
        categorySubGroupId: categorySubGroupId,
      ),
      TrashCategoryListPage(
        subGroupName: subGroupName,
        categorySubGroupId: categorySubGroupId,
      ),
    ];

    return ValueListenableBuilder(
      valueListenable: CategoryUtility.index,
      builder: (context, value, child) {
        return Scaffold(
          body: IndexedStack(
            index: CategoryUtility.index.value,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Constants.appbarColor,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 12,
              currentIndex: CategoryUtility.index.value,
              onTap: (value) {
                CategoryUtility.index.value = value;
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.list), label: 'category'.tr()),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.delete), label: 'trash'.tr()),
              ]),
        );
      },
    );
  }
}
