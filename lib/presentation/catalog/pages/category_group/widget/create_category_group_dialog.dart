import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/application/core/single_image_picker_provider.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/core/widgets/singel_image_upload.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class CreateCategoryGroupDialog extends HookConsumerWidget {
  const CreateCategoryGroupDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(singleImagePickerProvider).clearCategoryGroupImage();
      });
      return null;
    }, []);

    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final metaTitleController = useTextEditingController();
    final metaDescController = useTextEditingController();
    // final iconController = useTextEditingController();
    final orderController = useTextEditingController();
    final buttonPressed = useState(false);
    final active = useState(true);

    ref.listen<CategoryGroupState>(categoryGroupProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'category_group_added'.tr());

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    final loading =
        ref.watch(categoryGroupProvider.select((value) => value.loading));
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('add_category_group').tr(),
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
                lebelText: 'Name *',
                inputAction: TextInputAction.next,
                validator: (text) =>
                    ValidatorLogic.requiredField(text, fieldName: 'Name'),
              ),
              SizedBox(
                height: 10.h,
                width: 300.w,
              ),
              KTextField(
                controller: descController,
                inputAction: TextInputAction.next,
                lebelText: 'Description',
              ),
              SizedBox(height: 10.h),
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
              // SizedBox(height: 10.h),
              // KTextField(
              //   controller: iconController,
              //   inputAction: TextInputAction.next,
              //   lebelText: 'Icon',
              // ),
              SizedBox(height: 10.h),
              KTextField(
                controller: orderController,
                inputAction: TextInputAction.next,
                lebelText: 'Order',
                keyboardType: TextInputType.number,
                numberFormatters: true,
              ),
              SizedBox(height: 10.h),
              SingleImageUpload(
                title: 'upload_image'.tr(),
                image: ref.watch(singleImagePickerProvider).categoryGroupImage,
                picFunction:
                    ref.watch(singleImagePickerProvider).pickCategoryGroupImage,
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
                  if (formKey.currentState?.validate() ?? false) {
                    FormData formData = FormData.fromMap({
                      'name': nameController.text,
                      'slug': nameController.text
                          .toLowerCase()
                          .replaceAll(RegExp(r' '), '-'),
                      'description': descController.text,
                      'meta_title': metaDescController.text,
                      'meta_description': metaDescController.text,
                      // 'icon': iconController.text,
                      'active': active.value ? 1 : 0,
                      'order': orderController.text == ''
                          ? 0
                          : int.parse(orderController.text),
                    });

                    if (ref
                            .read(singleImagePickerProvider)
                            .categoryGroupImage !=
                        null) {
                      formData.files.addAll([
                        MapEntry(
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
                          ),
                        ),
                      ]);
                    }

                    buttonPressed.value = true;
                    ref
                        .read(categoryGroupProvider.notifier)
                        .createCategoryGroup(formData);
                  }
                },
          child: loading
              ? const CircularProgressIndicator()
              : const Text('add').tr(),
        ),
      ],
    );
  }
}
