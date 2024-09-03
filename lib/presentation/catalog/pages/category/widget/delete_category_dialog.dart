import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/category/categories/categories_provider.dart';
import 'package:alpesportif_seller/application/app/category/categories/categories_state.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';

class DeleteCategoryDialog extends HookConsumerWidget {
  final int id;
  final int categorySubGroupId;
  const DeleteCategoryDialog({
    Key? key,
    required this.id,
    required this.categorySubGroupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<CategoryState>(categoryProvider(id), (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none()) {
          ref
              .read(categoryProvider(categorySubGroupId).notifier)
              .getAllCategories();
          ref
              .read(categoryProvider(categorySubGroupId).notifier)
              .getTrashCategories();
          Navigator.of(context).pop();
          NotificationHelper.success(message: 'item_deleted'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    final loading =
        ref.watch(categoryProvider(id).select((value) => value.loading));
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'delete_category'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.h,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text('are_you_sure_delete_this_item'.tr()),
      ),
      actions: [
        const Divider(
          height: 1,
          thickness: 1,
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.h,
                      width: 85.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        border: Border.all(
                          color: Theme.of(context).shadowColor.withOpacity(.5),
                        ),
                      ),
                      child: Center(
                        child: Text('cancel'.tr()),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 85.w,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      onPressed: () async {
                        await ref
                            .read(categoryProvider(id).notifier)
                            .deleteCategory(id);
                      },
                      child: loading
                          ? const Center(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            )
                          : Text(
                              "delete".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
