import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/category/categories/categories_provider.dart';
import 'package:zcart_vendor/application/app/category/categories/categories_state.dart';
import 'package:zcart_vendor/presentation/widget_for_all/k_text_field.dart';

class AddCategoryDialog extends HookConsumerWidget {
  final int categoryId;
  const AddCategoryDialog({Key? key, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final featuredController = useTextEditingController();
    final metaTitleController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final buttonPressed = useState(false);
    ref.listen<CategorisState>(categoryProvider(categoryId), (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          Navigator.of(context).pop();
          CherryToast.info(
            title: const Text('Category group added'),
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
      title: const Text('Add Category Group'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KTextField(controller: nameController, lebelText: 'Name'),
          SizedBox(height: 10.h),
          KTextField(controller: descController, lebelText: 'Description'),
          SizedBox(height: 10.h),
          KTextField(controller: featuredController, lebelText: 'featured'),
          SizedBox(height: 10.h),
          KTextField(controller: metaTitleController, lebelText: 'Meta title'),
          SizedBox(height: 10.h),
          KTextField(
              controller: metaDescController, lebelText: 'Meta description'),
        ],
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
              // final categoryModel = CreateCategoryModel(
              //     categorySubGroupId: categoryId,
              //     name: nameController.text,
              //     slug: nameController.text
              //         .toLowerCase()
              //         .replaceAll(RegExp(r' '), '-'),
              //     description: descController.text,

              //     metaTitle: metaTitleController.text,
              //     metaDescription: metaDescController.text,
              //     attributeIds: );
              // buttonPressed.value = true;
              // ref
              //     .read(categoryProvider(categoryId).notifier)
              //     .createNewCategory(categoryModel);
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
