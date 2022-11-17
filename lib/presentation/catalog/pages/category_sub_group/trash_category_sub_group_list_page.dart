import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/widgets/trash_category_sub_group_list_tile.dart';

class TrashCategorySubgroupListPage extends HookConsumerWidget {
  final String groupName;
  final int id;
  const TrashCategorySubgroupListPage(
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
                .getMoreTrashCategorySubGroup();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(categorySubGroupProvider(id).notifier)
            .getTrashCategorySubGroup();
      });
      return null;
    }, []);
    final state = ref.watch(categorySubGroupProvider(id));

    final trashCategorySubGropuPaginationModel = ref
        .watch(categorySubGroupProvider(id).notifier)
        .trashCategorySubGropuPaginationModel;

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
            const Text('Category sub-group'),
            Text(
              groupName,
              style: TextStyle(fontSize: 13.sp),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: state.loading
          ? Center(
              child: CircularProgressIndicator(
                color: Constants.buttonColor,
              ),
            )
          : state.categorySubGroup.isEmpty
              ? Center(
                  child: Text('no_item_available'.tr()),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .refresh(categorySubGroupProvider(id).notifier)
                        .getTrashCategorySubGroup();
                  },
                  child: ListView.separated(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    itemCount: state.categorySubGroup.length,
                    itemBuilder: (context, index) {
                      if ((index == state.categorySubGroupTrash.length - 1) &&
                          state.categorySubGroupTrash.length <
                              trashCategorySubGropuPaginationModel
                                  .meta.total!) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return TrashCategorySubgroupListTile(
                        categoryGroupId: id,
                        categorySubGroup: state.categorySubGroupTrash[index],
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
