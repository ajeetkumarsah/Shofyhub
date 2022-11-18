import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_details_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_details_state.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class EditCategorySubGroupDialog extends HookConsumerWidget {
  final int categorySubGroupId;
  final int categoryGroupId;

  const EditCategorySubGroupDialog(
      {Key? key,
      required this.categorySubGroupId,
      required this.categoryGroupId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(categorySubGroupDetalsProvider(categorySubGroupId).notifier)
            .getCategorySubGroupDetailsData();
      });
      return null;
    }, []);

    final nameController = useTextEditingController();
    final descController = useTextEditingController();

    final active = useState(true);
    final buttonPressed = useState(false);

    final loading = ref.watch(categorySubGroupProvider(categoryGroupId)
        .select((value) => value.loading));
    final dataLoading = ref.watch(
        categorySubGroupDetalsProvider(categorySubGroupId)
            .select((value) => value.loading));

    ref.listen<CategorySubGroupDetalsState>(
        categorySubGroupDetalsProvider(categorySubGroupId), (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.categorySubGroupDetails.name;
        descController.text = next.categorySubGroupDetails.description;
        active.value = next.categorySubGroupDetails.active;
      }
    });

    final data = ref.watch(categorySubGroupDetalsProvider(categorySubGroupId)
        .select((value) => value.categorySubGroupDetails));

    ref.listen<CategorySubGroupState>(categorySubGroupProvider(categoryGroupId),
        (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none()) {
          if (buttonPressed.value) {
            Navigator.of(context).pop();
            NotificationHelper.success(message: 'item_updated'.tr());

            buttonPressed.value = false;
          }
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Text('edit_category_sub_group'.tr()),
      content: SingleChildScrollView(
        child: dataLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KTextField(
                      controller: nameController, lebelText: 'name'.tr()),
                  SizedBox(
                    height: 10.h,
                    width: 300.w,
                  ),
                  KTextField(
                      controller: descController,
                      lebelText: 'description'.tr()),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text('active'.tr()),
                      Checkbox(
                          value: active.value,
                          onChanged: (value) {
                            active.value = value!;
                          }),
                    ],
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'cancel'.tr(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                descController.text.isNotEmpty) {
              buttonPressed.value = true;
              ref
                  .read(categorySubGroupProvider(categoryGroupId).notifier)
                  .updateCategorySubGroup(
                      categorySubGroupId: categorySubGroupId,
                      categoryGroupId: categoryGroupId,
                      name: nameController.text.isEmpty
                          ? data.name
                          : nameController.text,
                      slug: nameController.text.isEmpty
                          ? data.name
                          : nameController.text,
                      description: descController.text.isEmpty
                          ? data.description
                          : descController.text,
                      active: active.value == true ? 1 : 0);
            } else {
              NotificationHelper.info(message: 'please_fill_all_fields'.tr());

              // CherryToast.info(
              //   title: const Text('please_fill_all_fields'),
              //   animationType: AnimationType.fromTop,
              // ).show(context);
            }
          },
          child:
              loading ? const CircularProgressIndicator() : Text('save'.tr()),
        ),
      ],
    );
  }
}
