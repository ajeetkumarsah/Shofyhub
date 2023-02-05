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
import 'package:zcart_seller/application/app/Product/product_image_provider.dart';
import 'package:zcart_seller/application/app/form/category_list_provider.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/product/detail_product/detail_product_provider.dart';
import 'package:zcart_seller/application/app/product/detail_product/detail_product_state.dart';
import 'package:zcart_seller/application/app/product/product_provider.dart';
import 'package:zcart_seller/application/core/image_converter.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/app/product/create_product/gtin_types_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/manufacturer_id.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/update_product_image_list.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';

import '../../../../application/app/product/product_state.dart';

class UpdateProductPage extends HookConsumerWidget {
  final int productId;
  const UpdateProductPage({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(
        detailProcuctProvider(productId).select((value) => value.loading));

    final loadingUpdate =
        ref.watch(productProvider.select((value) => value.loading));

    final gtinList =
        ref.watch(productProvider.select((value) => value.gtinTypes));

    final manufacturerIdList =
        ref.watch(productProvider.select((value) => value.manufacturerId));

    final productImagePicker = ref.watch(productImagePickerProvider);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        productImagePicker.clearAllImages();
        productImagePicker.clearDeletedImageIds();
        ref.read(categoryListProvider.notifier).loadData();
        ref.read(detailProcuctProvider(productId).notifier).getDetailProduct();
      });
      return null;
    }, []);

    final countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final ValueNotifier<KeyValueData> selectedCountry =
        useState(countryList[0]);

    final nameController = useTextEditingController();
    final brandController = useTextEditingController();
    final modelNumer = useTextEditingController();

    final mpn = useTextEditingController();
    final gtin = useTextEditingController();
    final description = useTextEditingController();

    final originCountry = useTextEditingController();

    final ValueNotifier<GtinTypes> selectedGtin = useState(gtinList[0]);
    final ValueNotifier<ManufacturerId> selectedMenufectur =
        useState(manufacturerIdList[0]);
    final allCategories =
        ref.watch(categoryListProvider.select((value) => value.dataList));

    ValueNotifier<IList<KeyValueData>> selectedCategories =
        useState(const IListConst([]));

    final active = useState(true);
    final shipping = useState(true);

    final buttonPressed = useState(false);

    ref.listen<DetailProductState>(detailProcuctProvider(productId),
        (previous, next) async {
      if (previous != next && !next.loading) {
        nameController.text = next.detailProduct.name;
        brandController.text = next.detailProduct.brand;
        modelNumer.text = next.detailProduct.modelNumber;
        mpn.text = next.detailProduct.mpn;
        gtin.text = next.detailProduct.gtin;
        description.text = next.detailProduct.description;
        selectedCategories.value =
            next.detailProduct.categories.map((e) => e.toKeyValue()).toIList();

        active.value = next.detailProduct.status;
        shipping.value = next.detailProduct.requirementShipping;
        selectedCountry.value = next.detailProduct.origin.isNotEmpty
            ? countryList
                .where((element) => element.value == next.detailProduct.origin)
                .toList()[0]
            : countryList[0];

        productImagePicker.setLoading(true);
        for (var i = 0; i < next.detailProduct.images.length; i++) {
          File file = await ImageConverter.getImage(
              url: next.detailProduct.images[i].path);
          productImagePicker.addOldImage(CustomImageModel(
              imageId: next.detailProduct.images[i].id.toString(),
              image: file));
        }
        productImagePicker.setLoading(false);
      }
    });

    ref.listen<ProductState>(productProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'product_updated'.tr());
          buttonPressed.value = false;
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
        title: Text('update_product'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    KTextField(
                        controller: nameController, lebelText: 'name'.tr()),
                    SizedBox(height: 10.h),
                    KTextField(
                        controller: brandController, lebelText: 'brand'.tr()),
                    SizedBox(height: 10.h),
                    KTextField(
                      controller: modelNumer,
                      lebelText: 'model_number'.tr(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    KTextField(
                      controller: mpn,
                      lebelText: 'mpn'.tr(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Text(
                      "GTIn Types:",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      // height: 50.h,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.w),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          style: TextStyle(color: Colors.grey.shade800),
                          isExpanded: true,
                          value: selectedGtin.value,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: gtinList.map<DropdownMenuItem<GtinTypes>>(
                              (GtinTypes value) {
                            return DropdownMenuItem<GtinTypes>(
                              value: value,
                              child: Text(
                                value.name,
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          onChanged: (GtinTypes? newValue) {
                            selectedGtin.value = newValue!;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    KTextField(
                      controller: gtin,
                      lebelText: 'gtin',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "manufacturer".tr(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      // height: 50.h,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.w),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          style: TextStyle(color: Colors.grey.shade800),
                          isExpanded: true,
                          value: selectedMenufectur.value,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: manufacturerIdList
                              .map<DropdownMenuItem<ManufacturerId>>(
                                  (ManufacturerId value) {
                            return DropdownMenuItem<ManufacturerId>(
                              value: value,
                              child: Text(
                                value.value,
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          onChanged: (ManufacturerId? newValue) {
                            selectedMenufectur.value = newValue!;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    KTextField(
                      controller: description,
                      lebelText: 'description'.tr(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "origin_country".tr(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      // height: 50.h,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.w),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          style: TextStyle(color: Colors.grey.shade800),
                          isExpanded: true,
                          value: selectedCountry.value,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: countryList
                              .map<DropdownMenuItem<KeyValueData>>(
                                  (KeyValueData value) {
                            return DropdownMenuItem<KeyValueData>(
                              value: value,
                              child: Text(
                                value.value,
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          onChanged: (KeyValueData? newValue) {
                            selectedCountry.value = newValue!;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MultipleKeyValueSelector(
                        title: "select_categories".tr(),
                        initialData: selectedCategories.value,
                        allData: allCategories,
                        onSelect: (list) {
                          selectedCategories.value = list;
                        }),
                    SizedBox(height: 10.h),
                    Text(
                      "upload_images".tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 10.h),
                    productImagePicker.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              productImagePicker.pickProductImages();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  productImagePicker.allProductImages.isNotEmpty
                                      ? Center(
                                          child: UpdateProductImageList(
                                              productImages: productImagePicker
                                                  .allProductImages),
                                        )
                                      : Center(
                                          child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                size: 42,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 5.h),
                                              Text('upload_images'.tr()),
                                            ],
                                          ),
                                        )),
                            ),
                          ),
                    SizedBox(height: 10.h),
                    CheckboxListTile(
                      title: Text('active'.tr()),
                      value: active.value,
                      onChanged: (value) {
                        active.value = value!;
                      },
                    ),
                    CheckboxListTile(
                      title: Text('require_shipping'.tr()),
                      value: shipping.value,
                      onChanged: (value) {
                        shipping.value = value!;
                      },
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
                          onPressed: loadingUpdate
                              ? null
                              : () async {
                                  buttonPressed.value = true;

                                  if (selectedCategories.value.isNotEmpty) {
                                    Logger.i(nameController.text
                                        .toLowerCase()
                                        .replaceAll(RegExp(r' '), '-'));

                                    // final String deleteImagesEndPoint = ref
                                    //     .watch(productImagePickerProvider)
                                    //     .deletedImageIds
                                    //     .map((element) => "delete_images[]=$element")
                                    //     .join('&');

                                    FormData formData = FormData.fromMap({
                                      'id': productId,
                                      'slug': nameController.text
                                          .toLowerCase()
                                          .replaceAll(RegExp(r' '), '-'),
                                      'manufacturer_id': int.parse(
                                          selectedMenufectur.value.id),
                                      'brand': brandController.text,
                                      'name': nameController.text,
                                      'mode_number': modelNumer.text,
                                      'mpn': mpn.text,
                                      'gtin': gtin.text,
                                      'gtin_type': selectedGtin.value.value,
                                      'description': description.text,
                                      'origin_country': originCountry.text,
                                      'active': active.value ? 1 : 0,
                                      'require_shipping':
                                          shipping.value ? 1 : 0,
                                      'category_list': selectedCategories.value
                                          .map((element) =>
                                              int.tryParse(element.key) ?? 0)
                                          .toList(),
                                    });

                                    for (CustomImageModel file
                                        in productImagePicker
                                            .newProductImages) {
                                      formData.files.addAll([
                                        MapEntry(
                                          'images[]',
                                          await MultipartFile.fromFile(
                                            file.image.path,
                                            filename:
                                                file.image.path.split('/').last,
                                            contentType:
                                                MediaType("image", "png"),
                                          ),
                                        ),
                                      ]);
                                    }

                                    for (String id in ref
                                        .watch(productImagePickerProvider)
                                        .deletedImageIds) {
                                      formData.fields.addAll([
                                        MapEntry('delete_images[]', id),
                                      ]);
                                    }

                                    ref
                                        .read(productProvider.notifier)
                                        .updateProduct(productId, formData);

                                    // log('New Images ${ref.watch(productImagePickerProvider).allProductImages}');
                                  } else {
                                    NotificationHelper.info(
                                        message:
                                            'please_select_atleast_one_category'
                                                .tr());
                                  }
                                },
                          child: loadingUpdate
                              ? const CircularProgressIndicator()
                              : Text('update'.tr()),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
