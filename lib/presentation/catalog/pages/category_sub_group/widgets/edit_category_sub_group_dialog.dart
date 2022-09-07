import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_details_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_details_state.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_state.dart';
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
            CherryToast.info(
              title: const Text('Category sub-group edited'),
              animationType: AnimationType.fromTop,
            ).show(context);
            buttonPressed.value = false;
          }
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.error(
            title: Text(
              next.failure.error,
            ),
            toastPosition: Position.bottom,
          ).show(context);
        }
      }
    });

    return AlertDialog(
      title: const Text('Edit Category Group'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KTextField(controller: nameController, lebelText: 'Name'),
            SizedBox(
              height: 10.h,
              width: 300.w,
            ),
            KTextField(controller: descController, lebelText: 'Description'),
            SizedBox(height: 10.h),
            Row(
              children: [
                const Text('Active:'),
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
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
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
                      active: active.value);
            } else {
              CherryToast.info(
                title: const Text('Please fill all fields'),
                animationType: AnimationType.fromTop,
              ).show(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
