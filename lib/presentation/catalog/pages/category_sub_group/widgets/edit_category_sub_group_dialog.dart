import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_details_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_details_state.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_provider.dart';
import 'package:zcart_seller/application/app/category/category%20sub%20group/category_sub_group_state.dart';
import 'package:zcart_seller/application/core/image_converter.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/application/core/single_image_picker_provider.dart';
import 'package:zcart_seller/presentation/core/widgets/loading_widget.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/core/widgets/singel_image_upload.dart';
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
        categorySubGroupDetalsProvider(categorySubGroupId),
        (previous, next) async {
      if (previous != next && !next.loading) {
        nameController.text = next.categorySubGroupDetails.name;
        descController.text = next.categorySubGroupDetails.description;
        active.value = next.categorySubGroupDetails.active;
        if (next.categorySubGroupDetails.coverImage.isNotEmpty) {
          //Convert Network Image to File Image
          ref.watch(singleImagePickerProvider).setLoading(true);
          File file = await ImageConverter.getImage(
              url: next.categorySubGroupDetails.coverImage);
          ref.read(singleImagePickerProvider).setCategorySubGroupImage(file);
          ref.watch(singleImagePickerProvider).setLoading(false);
        }
      }
    });

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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
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
                  // KTextField(
                  //     controller: metaController, lebelText: 'meta_title'.tr()),
                  // SizedBox(height: 10.h),
                  // KTextField(
                  //     controller: metaDescController,
                  //     lebelText: 'meta_description'.tr()),
                  // SizedBox(height: 10.h),
                  // KTextField(
                  //   controller: orderDescController,
                  //   lebelText: 'order'.tr(),
                  //   keyboardType: TextInputType.number,
                  //   numberFormatters: true,
                  // ),
                  // SizedBox(height: 10.h),
                  ref.watch(singleImagePickerProvider).isLoading
                      ? const LoadingWidget()
                      : SingleImageUpload(
                          title: 'cover_image'.tr(),
                          image: ref
                              .watch(singleImagePickerProvider)
                              .categorySubGroupImage,
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
                  SizedBox(height: 10.h),
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
          onPressed: loading
              ? null
              : () async {
                  if (nameController.text.isNotEmpty &&
                      descController.text.isNotEmpty) {
                    buttonPressed.value = true;
                    FormData formData = FormData.fromMap({
                      'category_subGroup_id': categorySubGroupId,
                      'category_group_id': categoryGroupId,
                      'name': nameController.text,
                      'slug': nameController.text
                          .toLowerCase()
                          .replaceAll(RegExp(r' '), '-'),
                      'description': descController.text,
                      // 'meta_title': metaTitleController.text,
                      // 'meta_description': metaDescController.text,
                      // 'active': active.value ? 1 : 0,
                      // 'order': orderController.text.isNotEmpty
                      //     ? int.parse(orderController.text)
                      //     : 0,
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
                    ref
                        .read(
                            categorySubGroupProvider(categoryGroupId).notifier)
                        .updateCategorySubGroup(
                            categorySubGroupId: categorySubGroupId,
                            formData: formData);
                  } else {
                    NotificationHelper.info(
                        message: 'please_fill_all_fields'.tr());
                  }
                },
          child:
              loading ? const CircularProgressIndicator() : Text('save'.tr()),
        ),
      ],
    );
  }
}
