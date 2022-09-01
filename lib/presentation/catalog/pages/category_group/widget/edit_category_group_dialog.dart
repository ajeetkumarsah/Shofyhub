import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_family_provider.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_family_state.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_state.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class EditCategoryGroupDialog extends HookConsumerWidget {
  final int categoryGroupId;

  const EditCategoryGroupDialog({Key? key, required this.categoryGroupId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(categoryGroupFamilyProvider(categoryGroupId).notifier)
            .getCategoryGroupDetails();
      });
      return null;
    }, []);

    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final metaTitleController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final iconController = useTextEditingController();
    final orderController = useTextEditingController();
    final buttonPressed = useState(false);
    final active = useState(false);

    ref.listen<CategoryGroupFamilyState>(
        categoryGroupFamilyProvider(categoryGroupId), (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.categoryGroupDetails.name;
        descController.text = next.categoryGroupDetails.description;
        metaTitleController.text = next.categoryGroupDetails.metaTitle;
        metaDescController.text = next.categoryGroupDetails.metaDescription;
        iconController.text = next.categoryGroupDetails.icon;
        orderController.text = next.categoryGroupDetails.order.toString();
        active.value = next.categoryGroupDetails.active;
      }
    });

    ref.listen<CategoryGroupState>(categoryGroupProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none()) {
          if (buttonPressed.value) {
            Navigator.of(context).pop();
            CherryToast.info(
              title: const Text('Category group edited'),
              animationType: AnimationType.fromTop,
            ).show(context);
            buttonPressed.value = false;
          }
        } else if (next.failure != CleanFailure.none()) {
          Navigator.of(context).pop();
          next.failure.showDialogue(context);
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
            SizedBox(height: 10.h),
            KTextField(controller: descController, lebelText: 'Description'),
            SizedBox(height: 10.h),
            KTextField(
                controller: metaTitleController, lebelText: 'Meta title'),
            SizedBox(height: 10.h),
            KTextField(
                controller: metaDescController, lebelText: 'Meta description'),
            SizedBox(height: 10.h),
            KTextField(controller: iconController, lebelText: 'Icon'),
            SizedBox(height: 10.h),
            KTextField(controller: orderController, lebelText: 'Order'),
            SizedBox(height: 10.h),
            SwitchListTile(
              value: active.value,
              onChanged: (value) => active.value = value,
              title: const Text('Active status'),
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
              buttonPressed.value = true;
              ref.read(categoryGroupProvider.notifier).updateCategoryGroup(
                    categoryGroupId: categoryGroupId,
                    name: nameController.text,
                    slug: nameController.text,
                    description: descController.text,
                    metaTitle: metaTitleController.text,
                    metaDescription: metaDescController.text,
                    order: int.parse(orderController.text),
                    icon: iconController.text,
                    active: active.value,
                  );
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
