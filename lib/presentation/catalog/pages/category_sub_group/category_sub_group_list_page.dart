import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/category_sub_group/widgets/category_sub_group_list_tile.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/category_sub_group/widgets/create_category_sub_group_dialog.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';

class CategorySubgroupListPage extends HookConsumerWidget {
  final String groupName;
  final int id;
  const CategorySubgroupListPage(
      {Key? key, required this.id, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref
                .read(categorySubGroupProvider(id).notifier)
                .getMoreCategorySubGroup();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(categorySubGroupProvider(id).notifier).getCategorySubGroup();
      });
      return null;
    }, []);
    final categorySubGroup = ref.watch(
        categorySubGroupProvider(id).select((value) => value.categorySubGroup));

    final categorySubGropuPaginationModel = ref
        .watch(categorySubGroupProvider(id).notifier)
        .categorySubGropuPaginationModel;
    final loading = ref
        .watch(categorySubGroupProvider(id).select((value) => value.loading));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('category_sub_group'.tr()),
            Text(
              groupName,
              style: TextStyle(fontSize: 13.sp),
            ),
          ],
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => CreateCategorySubGroupDialog(
                    categoryGroupId: id,
                  ));
        },
        label: const Text(
          'Add sub-group',
        ),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Constants.buttonColor,
              ),
            )
          : categorySubGroup.isEmpty
              ? const NoItemFound()
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .refresh(categorySubGroupProvider(id).notifier)
                        .getCategorySubGroup();
                  },
                  child: ListView.separated(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    itemCount: categorySubGroup.length,
                    itemBuilder: (context, index) {
                      if ((index == categorySubGroup.length - 1) &&
                          categorySubGroup.length <
                              categorySubGropuPaginationModel.meta.total!) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return CategorySubgroupListTile(
                        categoryGroupId: id,
                        categorySubGroup: categorySubGroup[index],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3.h,
                    ),
                  ),
                ),
    );
  }
}
