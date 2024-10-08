import 'dart:io';
import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:alpesportif_seller/application/app/settings/shop_settings_provider.dart';
import 'package:alpesportif_seller/application/app/settings/shop_settings_state.dart';
import 'package:alpesportif_seller/application/app/shop/user/shop_user_provider.dart';
import 'package:alpesportif_seller/application/auth/auth_provider.dart';
import 'package:alpesportif_seller/application/core/image_converter.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';
import 'package:alpesportif_seller/application/core/single_image_picker_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/core/widgets/loading_widget.dart';
import 'package:alpesportif_seller/presentation/core/widgets/singel_image_upload.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/validator_logic.dart';

class ShopSettingsPage extends HookConsumerWidget {
  const ShopSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final shopId =
        ref.watch(authProvider.select((value) => value.user.shop_id));

    final loading =
        ref.watch(shopSettingsProvider.select((value) => value.loading));

    final updateLoading =
        ref.watch(shopSettingsProvider.select((value) => value.loadingUpdate));

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(singleImagePickerProvider).clearShopLogo();
        ref.read(shopSettingsProvider.notifier).getShopSettings();
        ref.read(shopUserProvider.notifier).getShopUser();
      });
      return null;
    }, []);

    final nameController = useTextEditingController();
    final legalNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    final buttonPressed = useState(false);

    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) async {
      if (previous != next && !next.loading) {
        nameController.text = next.shopSettings.name;
        legalNameController.text = next.shopSettings.legalName;
        emailController.text = next.shopSettings.email;
        descriptionController.text = next.shopSettings.description;
        if (next.shopSettings.logo.isNotEmpty) {
          ref.watch(singleImagePickerProvider).setLoading(true);
          File file =
              await ImageConverter.getImage(url: next.shopSettings.logo);
          ref.read(singleImagePickerProvider).setShopLogo(file);
          ref.watch(singleImagePickerProvider).setLoading(false);
        }
      }
    });

    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          buttonPressed.value = false;
          NotificationHelper.success(
              message: 'basic_shop_settings_updated'.tr());
          Navigator.of(context).pop();
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        elevation: 0,
        title: Text('basic_shop_settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: nameController,
                        lebelText: '${'name'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'title'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: legalNameController,
                        lebelText: '${'legal_name'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'legal_name'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      KMultiLineTextField(
                        controller: descriptionController,
                        maxLines: 3,
                        lebelText: '${'description'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'description'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: emailController,
                        lebelText: '${'email'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'email'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      ref.read(singleImagePickerProvider).isLoading
                          ? const LoadingWidget()
                          : SingleImageUpload(
                              title: 'upload_logo'.tr(),
                              image:
                                  ref.watch(singleImagePickerProvider).shopLogo,
                              picFunction: ref
                                  .watch(singleImagePickerProvider)
                                  .pickShopLogo,
                              clearFunction: ref
                                  .watch(singleImagePickerProvider)
                                  .clearShopLogo,
                            ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: updateLoading
                                ? null
                                : () async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      final map = {
                                        'shop_id': shopId,
                                        'name': nameController.text,
                                        'slug': nameController.text
                                            .toLowerCase()
                                            .replaceAll(RegExp(r' '), '-'),
                                        'legal_name': legalNameController.text,
                                        'email': emailController.text,
                                        'description':
                                            descriptionController.text,
                                      };

                                      // print('map: $map');

                                      FormData formData = FormData.fromMap(map);

                                      if (ref
                                              .watch(singleImagePickerProvider)
                                              .shopLogo !=
                                          null) {
                                        formData.files.add(MapEntry(
                                            'logo',
                                            await MultipartFile.fromFile(
                                              ref
                                                  .watch(
                                                      singleImagePickerProvider)
                                                  .shopLogo!
                                                  .path,
                                              filename: ref
                                                  .watch(
                                                      singleImagePickerProvider)
                                                  .shopLogo!
                                                  .path
                                                  .split('/')
                                                  .last,
                                              contentType:
                                                  MediaType("image", "png"),
                                            )));
                                      }

                                      final authRef = ref.read(authProvider);
                                      await ref
                                          .read(shopSettingsProvider.notifier)
                                          .updateShopSettings(
                                            formData: formData,
                                            shopId: shopId,
                                            apiKey: authRef.user.api_token,
                                          );

                                      buttonPressed.value = true;
                                    }
                                  },
                            child: updateLoading
                                ? const CircularProgressIndicator()
                                : Text('update'.tr()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
