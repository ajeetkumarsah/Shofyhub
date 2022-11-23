import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(categoryGroupProvider.notifier).getAllCategoryGroup();
      });

      return null;
    }, []);

    final categoryGroupList = ref.watch(categoryGroupProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const AddCategoryGroupDialog());
        },
        label: const Text('add_new').tr(),
        icon: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .refresh(categoryGroupProvider.notifier)
              .getAllCategoryGroup();
        },
        child: categoryGroupList.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                      itemCount: categoryGroupList.allCategoryGroups.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CategorySubgroupPage(
                                  groupName: categoryGroupList
                                      .allCategoryGroups[index].name,
                                  id: categoryGroupList
                                      .allCategoryGroups[index].id)));
                        },
                        child: CategoryGroupTile(
                          categoryGroup:
                              categoryGroupList.allCategoryGroups[index],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3.h,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
