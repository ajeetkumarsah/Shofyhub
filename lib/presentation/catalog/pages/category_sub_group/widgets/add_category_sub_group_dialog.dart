import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_state.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/create_category_sub_group_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class AddCategorySubGroupDialog extends HookConsumerWidget {
  final int categoryGroupId;
  const AddCategorySubGroupDialog({Key? key, required this.categoryGroupId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final metaTitleController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final active = useState(true);
    final orderController = useTextEditingController();

    final buttonPressed = useState(false);

    ref.listen<CategorySubGroupState>(categorySubGroupProvider(categoryGroupId),
        (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          Navigator.of(context).pop();
          CherryToast.info(
            title: const Text('Category sub group added'),
            animationType: AnimationType.fromTop,
          ).show(context);

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          Navigator.of(context).pop();
          next.failure.showDialogue(context);
        }
      }
    });
    return AlertDialog(
      title: const Text('Add Category Sub Group'),
      insetPadding: EdgeInsets.zero,
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
            KTextField(
                controller: metaTitleController, lebelText: 'Meta title'),
            SizedBox(height: 10.h),
            KTextField(
                controller: metaDescController, lebelText: 'Meta description'),
            SizedBox(height: 10.h),
            KTextField(controller: orderController, lebelText: 'Order'),
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
                descController.text.isNotEmpty &&
                metaTitleController.text.isNotEmpty &&
                metaDescController.text.isNotEmpty) {
              final createCategorySubGroupModel = CreateCategorySubGroupModel(
                categoryGroupId: categoryGroupId,
                name: nameController.text,
                slug: nameController.text
                    .toLowerCase()
                    .replaceAll(RegExp(r' '), '-'),
                description: descController.text,
                metaTitle: metaTitleController.text,
                metaDescription: metaDescController.text,
                active: active.value,
                order: int.parse(orderController.text),
              );

              buttonPressed.value = true;
              ref
                  .read(categorySubGroupProvider(categoryGroupId).notifier)
                  .createCategorySubGroup(createCategorySubGroupModel);
            } else {
              CherryToast.info(
                title: const Text('Please fill all fields'),
                animationType: AnimationType.fromTop,
              ).show(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
