import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/widget/category_list_tile.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/widget/create_new_category_page.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';

class CategoryListPage extends HookConsumerWidget {
  final String subGroupName;
  final int categorySubGroupId;
  const CategoryListPage(
      {Key? key, required this.categorySubGroupId, required this.subGroupName})
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
                .read(categoryProvider(categorySubGroupId).notifier)
                .getMoreCategories();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(categoryProvider(categorySubGroupId).notifier)
            .getAllCategories();
      });
      return null;
    }, []);

    final categoryPaginationModel = ref
        .watch(categoryProvider(categorySubGroupId).notifier)
        .categoryPaginationModel;

    final categoryList =
        ref.watch(categoryProvider(categorySubGroupId)).allCategoris;
    final loading = ref.watch(
        categoryProvider(categorySubGroupId).select((value) => value.loading));
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateNewCategoryPage(
                    categorySubgroupId: categorySubGroupId,
                  )));
        },
        label: Text('add_category'.tr()),
        icon: const Icon(Icons.add),
      ),
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
            Text('category_list'.tr()),
            Text(
              subGroupName,
              style: TextStyle(fontSize: 13.sp),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : categoryList.isEmpty
              ? const NoItemFound()
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .refresh(categoryProvider(categorySubGroupId).notifier)
                        .getAllCategories();
                  },
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      if ((index == categoryList.length - 1) &&
                          categoryList.length <
                              categoryPaginationModel.meta.total!) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return InkWell(
                        child: CategoryListTile(
                          category: categoryList[index],
                        ),
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
