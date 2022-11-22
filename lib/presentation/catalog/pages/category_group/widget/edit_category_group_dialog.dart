import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_family_provider.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_family_state.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_state.dart';
import 'package:zcart_seller/application/core/single_image_picker_provider.dart';
import 'package:zcart_seller/application/core/image_converter.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/loading_widget.dart';
import 'package:zcart_seller/presentation/core/widgets/singel_image_upload.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
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
    final categoryGroup = ref.watch(categoryGroupFamilyProvider(categoryGroupId)
        .select((value) => value.categoryGroupDetails));

    ref.listen<CategoryGroupFamilyState>(
        categoryGroupFamilyProvider(categoryGroupId), (previous, next) async {
      if (previous != next && !next.loading) {
        nameController.text = next.categoryGroupDetails.name;
        descController.text = next.categoryGroupDetails.description;

        if (next.categoryGroupDetails.coverImage != null ||
            next.categoryGroupDetails.coverImage.isNotEmpty) {
          //Convert Network Image to File Image
          ref.watch(singleImagePickerProvider).setLoading(true);
          File file = await ImageConverter.getImage(
              url: next.categoryGroupDetails.coverImage);
          ref.read(singleImagePickerProvider).setCategoryGroupImage(file);
        }
        ref.watch(singleImagePickerProvider).setLoading(false);
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
                  KTextField(controller: nameController, lebelText: 'Name'),
                  SizedBox(height: 10.h),
                  KMultiLineTextField(
                      controller: descController, lebelText: 'Description'),
                  SizedBox(
                    height: 10.h,
                    width: 300.w,
                  ),
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
                  KTextField(
                      controller: metaTitleController, lebelText: 'Meta title'),
                  SizedBox(height: 10.h),
                  KTextField(
                      controller: metaDescController,
                      lebelText: 'Meta description'),
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
                  SizedBox(height: 10.h),
                  Text('* Required fields.',
                      style: TextStyle(color: Theme.of(context).hintColor)),
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
          onPressed: () {
            buttonPressed.value = true;
            ref.read(categoryGroupProvider.notifier).updateCategoryGroup(
                  categoryGroupId: categoryGroupId,
                  name: nameController.text.isEmpty
                      ? categoryGroup.name
                      : nameController.text,
                  slug: nameController.text.isEmpty
                      ? categoryGroup.name
                      : nameController.text,
                  description: descController.text.isEmpty
                      ? categoryGroup.description
                      : descController.text,
                  metaTitle: metaTitleController.text.isEmpty
                      ? categoryGroup.metaTitle
                      : metaTitleController.text,
                  metaDescription: metaDescController.text.isEmpty
                      ? categoryGroup.metaDescription
                      : metaDescController.text,
                  order: int.parse(orderController.text),
                  icon: iconController.text.isEmpty
                      ? categoryGroup.icon
                      : iconController.text,
                  active: active.value == true ? 1 : 0,
                );
          },
          child: loading
              ? const CircularProgressIndicator()
              : const Text('save').tr(),
        ),
      ],
    );
  }
}
