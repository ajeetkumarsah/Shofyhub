import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:alpesportif_seller/application/app/category/caegory%20group/category_group_family_provider.dart';
import 'package:alpesportif_seller/application/app/category/caegory%20group/category_group_family_state.dart';
import 'package:alpesportif_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:alpesportif_seller/application/app/category/caegory%20group/category_group_state.dart';
import 'package:alpesportif_seller/application/core/image_converter.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';
import 'package:alpesportif_seller/application/core/single_image_picker_provider.dart';
import 'package:alpesportif_seller/presentation/core/widgets/loading_widget.dart';
import 'package:alpesportif_seller/presentation/core/widgets/required_field_text.dart';
import 'package:alpesportif_seller/presentation/core/widgets/singel_image_upload.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_text_field.dart';

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
      ref.read(singleImagePickerProvider).clearCategoryGroupImage();

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

    final loading =
        ref.watch(categoryGroupProvider.select((value) => value.loading));
    final dataLoading = ref.watch(categoryGroupFamilyProvider(categoryGroupId)
        .select((value) => value.loading));

    ref.listen<CategoryGroupFamilyState>(
        categoryGroupFamilyProvider(categoryGroupId), (previous, next) async {
      if (previous != next && !next.loading) {
        nameController.text = next.categoryGroupDetails.name;
        descController.text = next.categoryGroupDetails.description;

        if (next.categoryGroupDetails.coverImage.isNotEmpty) {
          //Convert Network Image to File Image
          ref.watch(singleImagePickerProvider).setLoading(true);
          File file = await ImageConverter.getImage(
              url: next.categoryGroupDetails.coverImage);
          ref.read(singleImagePickerProvider).setCategoryGroupImage(file);
          ref.watch(singleImagePickerProvider).setLoading(false);
        }
      }

      metaTitleController.text = next.categoryGroupDetails.metaTitle;
      metaDescController.text = next.categoryGroupDetails.metaDescription;
      iconController.text = next.categoryGroupDetails.icon;
      orderController.text = next.categoryGroupDetails.order.toString();
      active.value = next.categoryGroupDetails.active;
    });

    ref.listen<CategoryGroupState>(categoryGroupProvider, (previous, next) {
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
      title: Text('edit_category_group'.tr()),
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
                    controller: nameController,
                    inputAction: TextInputAction.next,
                    lebelText: 'Name',
                  ),
                  SizedBox(height: 10.h),
                  KMultiLineTextField(
                    controller: descController,
                    maxLines: 3,
                    lebelText: 'Description',
                  ),
                  SizedBox(
                    height: 10.h,
                    width: 300.w,
                  ),

                  KTextField(
                    controller: metaTitleController,
                    inputAction: TextInputAction.next,
                    lebelText: 'Meta title',
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: metaDescController,
                    inputAction: TextInputAction.next,
                    lebelText: 'Meta description',
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: iconController,
                    inputAction: TextInputAction.next,
                    lebelText: 'Icon',
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: orderController,
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    lebelText: 'Order',
                  ),
                  SizedBox(height: 10.h),
                  // Image upload
                  ref.read(singleImagePickerProvider).isLoading
                      ? const LoadingWidget()
                      : SingleImageUpload(
                          title: 'upload_image'.tr(),
                          image: ref
                              .watch(singleImagePickerProvider)
                              .categoryGroupImage,
                          picFunction: ref
                              .watch(singleImagePickerProvider)
                              .pickCategoryGroupImage,
                          clearFunction: ref
                              .watch(singleImagePickerProvider)
                              .clearCategoryGroupImage,
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
          child: const Text(
            'cancel',
            style: TextStyle(color: Colors.red),
          ).tr(),
        ),
        TextButton(
          onPressed: loading
              ? null
              : () async {
                  buttonPressed.value = true;
                  FormData formData = FormData.fromMap({
                    'category_group_id': categoryGroupId,
                    'name': nameController.text,
                    'slug': nameController.text
                        .toLowerCase()
                        .replaceAll(RegExp(r' '), '-'),
                    'description': descController.text,
                    'meta_title': metaDescController.text,
                    'meta_description': metaDescController.text,
                    'icon': iconController.text,
                    'active': active.value ? 1 : 0,
                    'order': orderController.text == ''
                        ? 0
                        : int.parse(orderController.text),
                    // 'images[cover]': ref
                    //             .read(singleImagePickerProvider)
                    //             .categoryGroupImage !=
                    //         null
                    //     ? await MultipartFile.fromFile(
                    //         ref
                    //             .read(singleImagePickerProvider)
                    //             .categoryGroupImage!
                    //             .path,
                    //         filename: ref
                    //             .read(singleImagePickerProvider)
                    //             .categoryGroupImage!
                    //             .path
                    //             .split('/')
                    //             .last,
                    //         contentType: MediaType("image", "png"),
                    //       )
                    //     : null,
                  });

                  if (ref.read(singleImagePickerProvider).categoryGroupImage !=
                      null) {
                    formData.files.add(MapEntry(
                        'images[cover]',
                        await MultipartFile.fromFile(
                          ref
                              .read(singleImagePickerProvider)
                              .categoryGroupImage!
                              .path,
                          filename: ref
                              .read(singleImagePickerProvider)
                              .categoryGroupImage!
                              .path
                              .split('/')
                              .last,
                          contentType: MediaType("image", "png"),
                        )));
                  }

                  ref.read(categoryGroupProvider.notifier).updateCategoryGroup(
                      formData: formData, id: categoryGroupId);
                },
          child: loading
              ? const CircularProgressIndicator()
              : const Text('save').tr(),
        ),
      ],
    );
  }
}
