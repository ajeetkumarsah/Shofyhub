import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:zcart_seller/application/app/category/categories/categories_provider.dart';
import 'package:zcart_seller/application/app/category/categories/categories_state.dart';
import 'package:zcart_seller/application/app/category/categories/category_family_provider.dart';
import 'package:zcart_seller/application/app/category/categories/category_family_state.dart';
import 'package:zcart_seller/application/app/form/attribute_list_provider.dart';
import 'package:zcart_seller/application/core/image_converter.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/application/core/single_image_picker_provider.dart';
import 'package:zcart_seller/domain/app/category/categories/update_category_model.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/presentation/core/widgets/loading_widget.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/core/widgets/singel_image_upload.dart';
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
    final metaController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final orderDescController = useTextEditingController();

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
        (previous, next) async {
      if (previous != next && !next.loading) {
        nameController.text = next.categoryDetails.name;
        metaController.text = next.categoryDetails.metaTitle;
        metaDescController.text = next.categoryDetails.metaDescription;
        descController.text = next.categoryDetails.description;
        selectedAttributes.value =
            selectedAttributes.value.addAll(next.categoryDetails.attributes);
        active.value = next.categoryDetails.active;
        if (next.categoryDetails.coverImage != null ||
            next.categoryDetails.coverImage.isNotEmpty) {
          //Convert Network Image to File Image
          ref.watch(singleImagePickerProvider).setLoading(true);
          File file = await ImageConverter.getImage(
              url: next.categoryDetails.coverImage);
          ref.read(singleImagePickerProvider).setCategoryImage(file);
          ref.watch(singleImagePickerProvider).setLoading(false);
        }
        Logger.i(selectedAttributes.value);
      }
    });

    ref.listen<CategoryState>(categoryProvider(category.categorySubGroupId),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'category_updated'.tr());

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Text('edit_category'.tr()),
      content: SingleChildScrollView(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
                  KTextField(
                      controller: nameController, lebelText: 'name'.tr()),
                  SizedBox(height: 10.h),
                  KTextField(
                      controller: descController,
                      lebelText: 'description'.tr()),
                  SizedBox(height: 10.h),
                  KTextField(
                      controller: metaController, lebelText: 'meta_title'.tr()),
                  SizedBox(
                    height: 10.h,
                    width: 300.w,
                  ),
                  KTextField(
                      controller: metaDescController,
                      lebelText: 'meta_description'.tr()),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: orderDescController,
                    lebelText: 'order'.tr(),
                    keyboardType: TextInputType.number,
                    numberFormatters: true,
                  ),
                  SizedBox(height: 10.h),
                  if (attributes.isNotEmpty)
                    attributeLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MultipleKeyValueSelector(
                            title: "select_attribute".tr(),
                            allData: attributes,
                            initialData: selectedAttributes.value,
                            onSelect: (list) {
                              Logger.i(list.length);
                              selectedAttributes.value = list;
                            }),
                  SizedBox(height: 10.h),
                  ref.read(singleImagePickerProvider).isLoading
                      ? const LoadingWidget()
                      : SingleImageUpload(
                          title: 'upload_image'.tr(),
                          image: ref
                              .watch(singleImagePickerProvider)
                              .categoryImage,
                          picFunction: ref
                              .watch(singleImagePickerProvider)
                              .pickCategoryImage,
                          clearFunction: ref
                              .watch(singleImagePickerProvider)
                              .clearCategoryImage,
                        ),
                  SizedBox(height: 10.h),
                  CheckboxListTile(
                    title: Text('active'.tr()),
                    value: active.value,
                    onChanged: (value) {
                      active.value = value!;
                    },
                  ),
                  SizedBox(height: 10.h),
                  const RequiredFieldText(),
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
          onPressed: categoryLoading
              ? null
              : () async {
                  buttonPressed.value = true;
                  FormData formData = FormData.fromMap({
                    'id': category.id,
                    'category_sub_group_id': category.categorySubGroupId,
                    'name': nameController.text,
                    'slug': nameController.text
                        .toLowerCase()
                        .replaceAll(RegExp(r' '), '-'),
                    'description': descController.text,
                    'meta_title': metaDescController.text,
                    'meta_description': metaDescController.text,
                    'attribute': selectedAttributes.value,
                    'active': active.value ? 1 : 0,
                    'order': orderDescController.text.isNotEmpty
                        ? orderDescController.text
                        : 0.toString(),
                    'images': await MultipartFile.fromFile(
                      ref.read(singleImagePickerProvider).categoryImage!.path,
                      filename: ref
                          .read(singleImagePickerProvider)
                          .categoryImage!
                          .path
                          .split('/')
                          .last,
                      contentType: MediaType("image", "png"),
                    ),
                  });
                  // final updatecategoryModel = UpdateCategoryModel(
                  //   slug: nameController.text.isEmpty
                  //       ? category.name
                  //           .toLowerCase()
                  //           .replaceAll(RegExp(r' '), '-')
                  //       : nameController.text
                  //           .toLowerCase()
                  //           .replaceAll(RegExp(r' '), '-'),
                  //   id: category.id,
                  //   categorySubGroupId: category.categorySubGroupId,
                  //   name: nameController.text.isEmpty
                  //       ? category.name
                  //       : nameController.text,
                  //   description: descController.text.isNotEmpty
                  //       ? descController.text
                  //       : category.description,
                  //   attributes: selectedAttributes.value.isEmpty
                  //       ? category.attributes
                  //       : selectedAttributes.value,
                  //   metaTitle: metaDescController.text,
                  //   metaDescription: metaDescController.text,
                  //   order: orderDescController.text.isNotEmpty
                  //       ? orderDescController.text
                  //       : 0.toString(),
                  //   active: active.value == true ? 1 : 0,
                  // );

                  ref
                      .read(categoryProvider(category.categorySubGroupId)
                          .notifier)
                      .updateCategory(formData: formData, id: category.id);
                },
          child: categoryLoading
              ? const CircularProgressIndicator()
              : Text('save'.tr()),
        ),
      ],
    );
  }
}
