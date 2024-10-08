import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:alpesportif_seller/application/app/catalog/manufacturer/manufacturer_provider.dart';
import 'package:alpesportif_seller/application/app/catalog/manufacturer/manufacturer_state.dart';
import 'package:alpesportif_seller/application/app/form/country_provider.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';
import 'package:alpesportif_seller/application/core/single_image_picker_provider.dart';
import 'package:alpesportif_seller/domain/app/form/key_value_data.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/core/widgets/required_field_text.dart';
import 'package:alpesportif_seller/presentation/core/widgets/singel_image_upload.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/validator_logic.dart';

class CreateManufactuererPage extends HookConsumerWidget {
  const CreateManufactuererPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(singleImagePickerProvider).clearManufacturerFeaturedImage();
        ref.read(singleImagePickerProvider).clearManufacturerCoverImage();
      });
      return null;
    }, []);

    final IList<KeyValueData> countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final ValueNotifier<KeyValueData?> selectedCountry = useState(null);

    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final urlController = useTextEditingController();

    final active = useState(true);
    final buttonPressed = useState(false);
    ref.listen<ManufacturerState>(manufacturerProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          buttonPressed.value = false;
          NotificationHelper.success(message: 'manufacturer_added'.tr());
          Navigator.of(context).pop();
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    final loading =
        ref.watch(manufacturerProvider.select((value) => value.loading));
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text('add_manufactuerer'.tr()),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: nameController,
                    lebelText: 'Name *',
                    inputAction: TextInputAction.next,
                    validator: (text) =>
                        ValidatorLogic.requiredField(text, fieldName: 'Name'),
                  ),
                  SizedBox(height: 10.h),
                  KMultiLineTextField(
                    controller: descController,
                    lebelText: 'Description',
                    maxLines: 3,
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: emailController,
                    lebelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: phoneController,
                    lebelText: 'Phone',
                    numberFormatters: true,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: urlController,
                    lebelText: 'Official Website',
                    inputAction: TextInputAction.next,
                  ),
                  // SizedBox(height: 10.h),
                  // SingleImageUpload(
                  //   title: 'brand_logo'.tr(),
                  //   image:
                  //       ref.watch(singleImagePickerProvider).manufacturerLogo,
                  //   picFunction: ref
                  //       .watch(singleImagePickerProvider)
                  //       .pickManufacturerLogo,
                  //   clearFunction: ref
                  //       .watch(singleImagePickerProvider)
                  //       .clearManufacturerLogo,
                  // ),
                  // SizedBox(height: 10.h),
                  // SingleImageUpload(
                  //   title: 'cover_image'.tr(),
                  //   image: ref
                  //       .watch(singleImagePickerProvider)
                  //       .manufacturerCoverImage,
                  //   picFunction: ref
                  //       .watch(singleImagePickerProvider)
                  //       .pickManufacturerCoverImage,
                  //   clearFunction: ref
                  //       .watch(singleImagePickerProvider)
                  //       .clearManufacturerCoverImage,
                  // ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      // SingleImageUpload(
                      //   title: 'brand_logo'.tr(),
                      //   image: ref
                      //       .watch(singleImagePickerProvider)
                      //       .manufacturerLogo,
                      //   picFunction: ref
                      //       .watch(singleImagePickerProvider)
                      //       .pickManufacturerLogo,
                      //   clearFunction: ref
                      //       .watch(singleImagePickerProvider)
                      //       .clearManufacturerLogo,
                      // ),
                      // SizedBox(height: 10.h),
                      SingleImageUpload(
                        title: 'cover_image'.tr(),
                        image: ref
                            .watch(singleImagePickerProvider)
                            .manufacturerCoverImage,
                        picFunction: ref
                            .watch(singleImagePickerProvider)
                            .pickManufacturerCoverImage,
                        clearFunction: ref
                            .watch(singleImagePickerProvider)
                            .clearManufacturerCoverImage,
                      ),
                      SizedBox(height: 10.h),
                      SingleImageUpload(
                        title: 'featured_image'.tr(),
                        image: ref
                            .watch(singleImagePickerProvider)
                            .manufacturerFeaturedImage,
                        picFunction: ref
                            .watch(singleImagePickerProvider)
                            .pickManufacturerFeaturedImage,
                        clearFunction: ref
                            .watch(singleImagePickerProvider)
                            .clearManufacturerFeaturedImage,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    // height: 50.h,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<KeyValueData?>(
                        // onTap: () {
                        //   countryDropdownList.value = countryList;
                        // },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        style: TextStyle(color: Colors.grey.shade800),
                        isExpanded: true,
                        value: selectedCountry.value,
                        hint: Text('select_country'.tr()),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        items: countryList.map<DropdownMenuItem<KeyValueData?>>(
                            (KeyValueData? value) {
                          return DropdownMenuItem<KeyValueData?>(
                            value: value,
                            child: Text(
                              value!.value,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        onChanged: (KeyValueData? newValue) {
                          selectedCountry.value = newValue;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CheckboxListTile(
                      title: Text('active'.tr()),
                      value: active.value,
                      onChanged: (value) {
                        active.value = value!;
                      }),
                  SizedBox(height: 10.h),
                  const RequiredFieldText(),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                                  buttonPressed.value = true;
                                  FormData formData = FormData.fromMap({
                                    'name': nameController.text,
                                    'slug': nameController.text
                                        .toLowerCase()
                                        .replaceAll(RegExp(r' '), '-'),
                                    'url': urlController.text,
                                    'active': active.value,
                                    'country_id': selectedCountry.value != null
                                        ? selectedCountry.value!.key
                                        : '',
                                    'email': emailController.text,
                                    'phone': phoneController.text,
                                    'description': descController.text,
                                    'images[cover]': ref
                                                .read(singleImagePickerProvider)
                                                .manufacturerCoverImage !=
                                            null
                                        ? await MultipartFile.fromFile(
                                            ref
                                                .read(singleImagePickerProvider)
                                                .manufacturerCoverImage!
                                                .path,
                                            filename: ref
                                                .read(singleImagePickerProvider)
                                                .manufacturerCoverImage!
                                                .path
                                                .split('/')
                                                .last,
                                            contentType:
                                                MediaType("image", "png"),
                                          )
                                        : null,
                                    'images[logo]': ref
                                                .read(singleImagePickerProvider)
                                                .manufacturerFeaturedImage !=
                                            null
                                        ? await MultipartFile.fromFile(
                                            ref
                                                .read(singleImagePickerProvider)
                                                .manufacturerFeaturedImage!
                                                .path,
                                            filename: ref
                                                .read(singleImagePickerProvider)
                                                .manufacturerFeaturedImage!
                                                .path
                                                .split('/')
                                                .last,
                                            contentType:
                                                MediaType("image", "png"),
                                          )
                                        : null,
                                  });
                                  ref
                                      .read(manufacturerProvider.notifier)
                                      .createManufacturer(formData);
                                }
                              },
                        child: loading
                            ? const CircularProgressIndicator()
                            : Text('add'.tr()),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
