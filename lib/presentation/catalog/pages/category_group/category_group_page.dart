import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_vendor/presentation/catalog/pages/category_subgroup/sub_category_group.dart';
import 'widget/add_category_group_dialog.dart';
import 'widget/category_container.dart';

class CategoryGroupPage extends HookConsumerWidget {
  const CategoryGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final categoryGroupList = ref.watch(
        categoryGroupProvider.select((value) => value.allCategoryGroups));
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.green[100],
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const AddCategoryGroupDialog());
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.green[700],
                  ),
                  label: Text('Add category group',
                      style: TextStyle(color: Colors.green[700]))),
            ],
          ),
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
                child: CateContainer(
                  onPressed: () {},
                  image: categoryGroupList[index].coverImage,
                  title: categoryGroupList[index].name,
                  desc: categoryGroupList[index].description,
                  categoryGroup: categoryGroupList[index],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
