import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/application/core/single_image_picker_provider.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/core/widgets/singel_image_upload.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

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
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'item_added'.tr());

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    final loading = ref.watch(categorySubGroupProvider(categoryGroupId)
        .select((value) => value.loading));
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return AlertDialog(
      title: Text('add_category_sub_group'.tr()),
      insetPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              KTextField(
                controller: nameController,
                lebelText: 'Name *  ',
                inputAction: TextInputAction.next,
                validator: (text) =>
                    ValidatorLogic.requiredField(text, fieldName: 'Name'),
              ),
              SizedBox(
                height: 10.h,
                width: 300.w,
              ),
              KMultiLineTextField(
                controller: descController,
                lebelText: 'Description *  ',
                maxLines: 3,
                validator: (text) =>
                    ValidatorLogic.requiredField(text, fieldName: 'Name'),
              ),
              // SizedBox(height: 10.h),
              // KTextField(
              //     controller: metaTitleController, lebelText: 'Meta title'),
              // SizedBox(height: 10.h),
              // KTextField(
              //     controller: metaDescController,
              //     lebelText: 'Meta description'),
              // SizedBox(height: 10.h),
              // KTextField(
              //   controller: orderController,
              //   lebelText: 'Order',
              //   numberFormatters: true,
              // ),
              SizedBox(height: 10.h),
              SingleImageUpload(
                title: 'cover_image'.tr(),
                image:
                    ref.watch(singleImagePickerProvider).categorySubGroupImage,
                clearFunction: ref
                    .watch(singleImagePickerProvider)
                    .clearCategorySubGroupImage,
                picFunction: ref
                    .watch(singleImagePickerProvider)
                    .pickCategorySubGroupImage,
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
          onPressed: loading
              ? null
              : () async {
                  if (formKey.currentState?.validate() ?? false) {
                    FormData formData = FormData.fromMap({
                      'category_group_id': categoryGroupId,
                      'name': nameController.text,
                      'slug': nameController.text
                          .toLowerCase()
                          .replaceAll(RegExp(r' '), '-'),
                      'description': descController.text,
                      'meta_title': metaTitleController.text,
                      'meta_description': metaDescController.text,
                      'active': active.value ? 1 : 0,
                      'order': orderController.text.isNotEmpty
                          ? int.parse(orderController.text)
                          : 0,
                      'images[cover]': ref
                                  .read(singleImagePickerProvider)
                                  .categorySubGroupImage !=
                              null
                          ? await MultipartFile.fromFile(
                              ref
                                  .read(singleImagePickerProvider)
                                  .categorySubGroupImage!
                                  .path,
                              filename: ref
                                  .read(singleImagePickerProvider)
                                  .categorySubGroupImage!
                                  .path
                                  .split('/')
                                  .last,
                              contentType: MediaType("image", "png"),
                            )
                          : null,
                    });
                    // final createCategorySubGroupModel =
                    //     CreateCategorySubGroupModel(
                    //   categoryGroupId: categoryGroupId,
                    //   name: nameController.text,
                    //   slug: nameController.text
                    //       .toLowerCase()
                    //       .replaceAll(RegExp(r' '), '-'),
                    //   description: descController.text,
                    //   metaTitle: metaTitleController.text,
                    //   metaDescription: metaDescController.text,
                    //   active: active.value ? 1 : 0,
                    //   order: orderController.text.isNotEmpty
                    //       ? int.parse(orderController.text)
                    //       : 0,
                    // );

                    buttonPressed.value = true;
                    ref
                        .read(
                            categorySubGroupProvider(categoryGroupId).notifier)
                        .createCategorySubGroup(formData);
                  }
                },
          child: loading ? const CircularProgressIndicator() : Text('add'.tr()),
        ),
      ],
    );
  }
}
