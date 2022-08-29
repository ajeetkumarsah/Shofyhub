import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_vendor/presentation/catalog/pages/category/category_list_page.dart';
import 'package:zcart_vendor/presentation/catalog/pages/category_subgroup/widgets/subgroup_list_tile.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';

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
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text(groupName),
        elevation: 0,
      ),
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
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => const AddCategoryGroupDialog());
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.green[700],
                  ),
                  label: Text('Add category sub-group',
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
                      builder: (context) => CategoryListPage(
                          id: categoryGroupList[index].id,
                          subGroupName: categoryGroupList[index].name)));
                },
                child: SubgroupListTile(
                  onPressed: () {},
                  image: categoryGroupList[index].coverImage,
                  title: categoryGroupList[index].name,
                  categoryCount:
                      categoryGroupList[index].categoriesCount.toString(),
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
