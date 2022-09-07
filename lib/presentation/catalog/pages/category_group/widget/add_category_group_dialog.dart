import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_state.dart';
import 'package:zcart_seller/domain/app/category/category%20group/create_category_group_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class AddCategoryGroupDialog extends HookConsumerWidget {
  const AddCategoryGroupDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final metaTitleController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final iconController = useTextEditingController();
    final orderController = useTextEditingController();
    final buttonPressed = useState(false);
    final active = useState(true);

    ref.listen<CategoryGroupState>(categoryGroupProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          Navigator.of(context).pop();
          CherryToast.info(
            title: const Text('Category group added'),
            animationType: AnimationType.fromTop,
          ).show(context);

          buttonPressed.value = false;
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
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('Add Category Group'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('* Required fields.',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              SizedBox(height: 10.h),
              KTextField(
                controller: nameController,
                lebelText: 'Name *',
                validator: (text) =>
                    ValidatorLogic.requiredField(text, fieldName: 'Name'),
              ),
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
                  controller: metaDescController,
                  lebelText: 'Meta description'),
              SizedBox(height: 10.h),
              KTextField(controller: iconController, lebelText: 'Icon'),
              SizedBox(height: 10.h),
              KTextField(
                controller: orderController,
                lebelText: 'Order',
                numberFormatters: true,
              ),
              SizedBox(height: 10.h),
              SwitchListTile(
                value: active.value,
                onChanged: (value) => active.value = value,
                title: const Text('Active status'),
              ),
            ],
          ),
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
            if (formKey.currentState?.validate() ?? false) {
              final categoryGroupModel = CreateCategoryGroupModel(
                name: nameController.text,
                slug: nameController.text
                    .toLowerCase()
                    .replaceAll(RegExp(r' '), '-'),
                desc: descController.text,
                metaTitle: metaTitleController.text,
                meatDesc: metaDescController.text,
                icon: iconController.text,
                order: orderController.text == ''
                    ? 0
                    : int.parse(orderController.text),
                active: active.value,
              );
              buttonPressed.value = true;
              ref
                  .read(categoryGroupProvider.notifier)
                  .createCategoryGroup(categoryGroupModel);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
