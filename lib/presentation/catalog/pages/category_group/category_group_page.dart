import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/category_sub_group_page.dart';
import 'widget/add_category_group_dialog.dart';
import 'widget/category_group_tile.dart';

class CategoryGroupPage extends HookConsumerWidget {
  const CategoryGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final categoryGroupList = ref.watch(
        categoryGroupProvider.select((value) => value.allCategoryGroups));
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const AddCategoryGroupDialog());
        },
        label: const Text('Add new'),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: categoryGroupList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategorySubgroupPage(
                          groupName: categoryGroupList[index].name,
                          id: categoryGroupList[index].id)));
                },
                child: CategoryGroupTile(
                  categoryGroup: categoryGroupList[index],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.separated(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     itemCount: categoryGroupList.length,
          //     itemBuilder: (context, index) => CategoryGroupTile(
          //       categoryGroup: categoryGroupList[index],
          //     ),
          //     separatorBuilder: (context, index) => SizedBox(
          //       height: 10.h,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
