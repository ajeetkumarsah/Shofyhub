import 'dart:io';

import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_details_provider.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_details_state.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_provider.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_state.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/core/image_converter.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/application/core/single_image_picker_provider.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/loading_widget.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/core/widgets/singel_image_upload.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class EditManufactuererPage extends HookConsumerWidget {
  final int manufacturerId;
  const EditManufactuererPage({Key? key, required this.manufacturerId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(manufacturerDetailsProvider(manufacturerId).notifier)
            .getManufacturerDetails();
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

    ref.listen<ManufacturerDetailsState>(
        manufacturerDetailsProvider(manufacturerId), (previous, next) async {
      if (previous != next && !next.loading) {
        nameController.text = next.manufacturerDetails.name;
        descController.text = next.manufacturerDetails.description;
        emailController.text = next.manufacturerDetails.email;
        phoneController.text = next.manufacturerDetails.phone;
        urlController.text = next.manufacturerDetails.url;
        if (next.manufacturerDetails.coverImage != null ||
            next.manufacturerDetails.coverImage.isNotEmpty ||
            next.manufacturerDetails.image.isNotEmpty) {
          //Convert Network Image to File Image
          ref.watch(singleImagePickerProvider).setLoading(true);
          File coverImageFile = await ImageConverter.getImage(
              url: next.manufacturerDetails.coverImage);
          File featuredImageFile = await ImageConverter.getImage(
              url: next.manufacturerDetails.image);
          ref
              .read(singleImagePickerProvider)
              .setManufacturerCoverImage(coverImageFile);
          ref
              .read(singleImagePickerProvider)
              .setManufacturerFeaturedImage(featuredImageFile);
          ref.watch(singleImagePickerProvider).setLoading(false);
        }
        selectedCountry.value = countryList
            .where((e) => e.value == next.manufacturerDetails.origin)
            .toList()[0];
      }
    });
    final loadingDetails = ref.watch(manufacturerDetailsProvider(manufacturerId)
        .select((value) => value.loading));
    final manufactuererDetails = ref.watch(
        manufacturerDetailsProvider(manufacturerId)
            .select((value) => value.manufacturerDetails));

    final buttonPressed = useState(false);
    ref.listen<ManufacturerState>(manufacturerProvider, (previous, next) {
      if (previous != next && !next.loading && buttonPressed.value) {
        Navigator.of(context).pop();
        buttonPressed.value = false;
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'manufacturer_updated'.tr());
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
        title: Text('edit_manufactuerer'.tr()),
        elevation: 0,
      ),
      body: loadingDetails
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
                              fieldName: 'Name'),
                        ),
                        SizedBox(height: 10.h),
                        KMultiLineTextField(
                          controller: descController,
                          maxLines: 3,
                          lebelText: 'Description',
                        ),
                        SizedBox(height: 10.h),
                        KTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          lebelText: 'Email',
                        ),
                        SizedBox(height: 10.h),
                        KTextField(
                          controller: phoneController,
                          lebelText: 'Phone',
                          inputAction: TextInputAction.next,
                          keyboardType: const TextInputType.numberWithOptions(),
                          numberFormatters: true,
                        ),
                        SizedBox(height: 10.h),
                        KTextField(
                            controller: urlController,
                            inputAction: TextInputAction.next,
                            lebelText: 'Official Website'),
                        SizedBox(
                          height: 10.h,
                        ),
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
                              hint: const Text('Select Country'),
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: countryList
                                  .map<DropdownMenuItem<KeyValueData?>>(
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
                        SizedBox(height: 10.h),
                        ref.watch(singleImagePickerProvider).isLoading
                            ? const LoadingWidget()
                            : Column(
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
                                  : () {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        buttonPressed.value = true;
                                        ref
                                            .read(manufacturerProvider.notifier)
                                            .updateManufacturer(
                                                manufacturerId: manufacturerId,
                                                name: nameController
                                                        .text.isEmpty
                                                    ? manufactuererDetails.name
                                                    : nameController.text,
                                                slug: manufactuererDetails.slug,
                                                url: urlController.text.isEmpty
                                                    ? manufactuererDetails.url
                                                    : urlController.text,
                                                active: false,
                                                countryId: selectedCountry
                                                            .value !=
                                                        null
                                                    ? selectedCountry.value!.key
                                                    : '',
                                                email: emailController
                                                        .text.isEmpty
                                                    ? manufactuererDetails.email
                                                    : emailController.text,
                                                phone: phoneController
                                                        .text.isEmpty
                                                    ? manufactuererDetails.phone
                                                    : phoneController.text,
                                                description: descController
                                                        .text.isEmpty
                                                    ? manufactuererDetails
                                                        .description
                                                    : descController.text);
                                      }
                                    },
                              child: loading
                                  ? const CircularProgressIndicator()
                                  : Text('update'.tr()),
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
