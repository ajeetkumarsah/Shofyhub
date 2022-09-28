import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_provider.dart';
import 'package:zcart_seller/application/app/category/categories/categories_state.dart';
import 'package:zcart_seller/application/app/category/categories/category_family_provider.dart';
import 'package:zcart_seller/application/app/category/categories/category_family_state.dart';
import 'package:zcart_seller/application/app/form/attribute_list_provider.dart';
import 'package:zcart_seller/domain/app/category/categories/update_category_model.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';

class EditCategoryDialog extends HookConsumerWidget {
  final int categoryId;
  const EditCategoryDialog({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(categoryFamilyProvider(categoryId).notifier)
            .getCategoryGroupDetails();

        ref.read(attributeListProvider.notifier).loadData();
      });
      return null;
    }, []);
    final ValueNotifier<IList<KeyValueData>> selectedAttributes =
        useState(const IListConst([]));
    final nameController = useTextEditingController();
    final descController = useTextEditingController();

    final buttonPressed = useState(false);
    final active = useState(false);

    final attributeLoading =
        ref.watch(attributeListProvider.select((value) => value.loading));
    final attributes =
        ref.watch(attributeListProvider.select((value) => value.dataList));
    final category = ref.watch(categoryFamilyProvider(categoryId)
        .select((value) => value.categoryDetails));

    final categoryLoading = ref.watch(
        categoryProvider(category.categorySubGroupId)
            .select((value) => value.loading));

    final loading = ref.watch(
        categoryFamilyProvider(categoryId).select((value) => value.loading));

    ref.listen<CategoryFamilyState>(categoryFamilyProvider(categoryId),
        (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.categoryDetails.name;
        descController.text = next.categoryDetails.description;
        selectedAttributes.value =
            selectedAttributes.value.addAll(next.categoryDetails.attributes);
        active.value = next.categoryDetails.featured;
        Logger.i(selectedAttributes.value);
      }
    });

    ref.listen<CategoryState>(categoryProvider(category.categorySubGroupId),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          CherryToast.info(
            title: const Text('Category updated'),
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
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('Edit Category'),
      content: SingleChildScrollView(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KTextField(controller: nameController, lebelText: 'Name'),
                  SizedBox(height: 10.h),
                  KTextField(
                      controller: descController, lebelText: 'Description'),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 10.h,
                    width: 300.w,
                  ),
                  if (attributes.isNotEmpty)
                    attributeLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MultipleKeyValueSelector(
                            title: "Select Attribute",
                            allData: attributes,
                            initialData: category.attributes,
                            onSelect: (list) {
                              Logger.i(list.length);
                              selectedAttributes.value = list;
                            }),
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
            buttonPressed.value = true;
            final updatecategoryModel = UpdateCategoryModel(
              slug: nameController.text.isEmpty
                  ? category.name.toLowerCase().replaceAll(RegExp(r' '), '-')
                  : nameController.text
                      .toLowerCase()
                      .replaceAll(RegExp(r' '), '-'),
              id: category.id,
              categorySubGroupId: category.categorySubGroupId,
              name: nameController.text.isEmpty
                  ? category.name
                  : nameController.text,
              description: descController.text.isNotEmpty
                  ? descController.text
                  : category.description,
              attributes: selectedAttributes.value.isEmpty
                  ? category.attributes
                  : selectedAttributes.value,
              active: active.value == true ? 1 : 0,
            );

            ref
                .read(categoryProvider(category.categorySubGroupId).notifier)
                .updateCategory(updatecategoryModel);
          },
          child: categoryLoading
              ? const CircularProgressIndicator()
              : const Text('Save'),
        ),
      ],
    );
  }
}
