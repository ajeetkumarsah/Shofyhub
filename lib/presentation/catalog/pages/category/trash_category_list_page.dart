import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/trash_category_list_tile.dart';

class TrashCategoryListPage extends HookConsumerWidget {
  final String subGroupName;
  final int categorySubGroupId;
  const TrashCategoryListPage(
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
                .getMoreTrashCategories();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(categoryProvider(categorySubGroupId).notifier)
            .getTrashCategories();
      });
      return null;
    }, []);

    final trashCategoryPaginationModel = ref
        .watch(categoryProvider(categorySubGroupId).notifier)
        .trashCategoryPaginationModel;

    final trashCategoryList =
        ref.watch(categoryProvider(categorySubGroupId)).trashCategoris;
    final loading = ref.watch(
        categoryProvider(categorySubGroupId).select((value) => value.loading));
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
          : trashCategoryList.isEmpty
              ? Center(
                  child: Text(
                    'no_item_available'.tr(),
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .refresh(categoryProvider(categorySubGroupId).notifier)
                        .getTrashCategories();
                  },
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    itemCount: trashCategoryList.length,
                    itemBuilder: (context, index) {
                      if ((index == trashCategoryList.length - 1) &&
                          trashCategoryList.length <
                              trashCategoryPaginationModel.meta.total!) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return InkWell(
                        child: TrashCategoryListTile(
                          category: trashCategoryList[index],
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
