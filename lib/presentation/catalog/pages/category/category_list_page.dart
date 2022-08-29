import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/category/categories/categories_provider.dart';
import 'package:zcart_vendor/application/app/category/categories/category_attribute_provider.dart';
import 'package:zcart_vendor/presentation/catalog/pages/category/category_list_tile.dart';
import 'package:zcart_vendor/presentation/catalog/pages/category/widget/create_new_category_page.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';

class CategoryListPage extends HookConsumerWidget {
  final String subGroupName;
  final int id;
  const CategoryListPage(
      {Key? key, required this.id, required this.subGroupName})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(categoryProvider(id).notifier).getAllCategories();
        ref.read(categoryAttributeProvider.notifier).getAttribuits();
      });
      return null;
    }, []);
    final categoryList =
        ref.watch(categoryProvider(id).select((value) => value.allCategoris));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text(subGroupName),
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
                    showDialog(
                        context: context,
                        builder: (context) => CreateNewCategoryPage(
                              categorySubgroupId: id,
                            ));
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.green[700],
                  ),
                  label: Text('Add category',
                      style: TextStyle(color: Colors.green[700]))),
            ],
          ),
          categoryList.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'No Category Available',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) => InkWell(
                      child: CategoryListTile(
                        onPressed: () {},
                        image: categoryList[index].coverImage,
                        title: categoryList[index].name,
                        featured: categoryList[index].featured,
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
