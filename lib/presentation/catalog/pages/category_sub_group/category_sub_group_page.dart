import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/widgets/add_category_sub_group_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/widgets/category_sub_group_list_tile.dart';

class CategorySubgroupPage extends HookConsumerWidget {
  final String groupName;
  final int id;
  const CategorySubgroupPage(
      {Key? key, required this.id, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(categorySubGroupProvider(id).notifier).getCategorySubGroup();
      });
      return null;
    }, []);
    final categoryGroupList = ref.watch(
        categorySubGroupProvider(id).select((value) => value.categorySubGroup));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text(groupName),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AddCategorySubGroupDialog(
                    categoryGroupId: id,
                  ));
        },
        label: const Text(
          'Add sub-group',
        ),
        icon: const Icon(Icons.add),
      ),
      body: categoryGroupList.isEmpty
          ? const Center(
              child: Text('No item available'),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: categoryGroupList.length,
              itemBuilder: (context, index) => CategorySubgroupListTile(
                categoryGroupId: id,
                categorySubGroup: categoryGroupList[index],
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
    );
  }
}
