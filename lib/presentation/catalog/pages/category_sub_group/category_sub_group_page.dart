import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/utility.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/category_sub_group_list_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/trash_category_sub_group_list_page.dart';

class CategorySubgroupPage extends HookConsumerWidget {
  final String groupName;
  final int id;
  const CategorySubgroupPage(
      {Key? key, required this.id, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var screens = [
      CategorySubgroupListPage(
        id: id,
        groupName: groupName,
      ),
      TrashCategorySubgroupListPage(
        id: id,
        groupName: groupName,
      ),
    ];

    return ValueListenableBuilder(
        valueListenable: CategorySubGroupUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: CategorySubGroupUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: CategorySubGroupUtility.index.value,
                onTap: (value) {
                  CategorySubGroupUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list),
                      label: 'category_sub_group'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
