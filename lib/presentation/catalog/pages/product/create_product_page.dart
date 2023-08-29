import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:search_choices/search_choices.dart';
import 'package:zcart_seller/application/app/Product/product_image_provider.dart';
import 'package:zcart_seller/application/app/form/category_list_provider.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/product/product_provider.dart';
import 'package:zcart_seller/application/app/product/product_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/app/product/create_product/gtin_types_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/manufacturer_id.dart';
import 'package:zcart_seller/domain/app/product/create_product/tag_list.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/create_product_image_list.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class AddProductPage extends HookConsumerWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final productImagePicker = ref.watch(productImagePickerProvider);

    final ValueNotifier<IList<int>> selectedTags =
        useState(const IListConst([]));

    final loading = ref.watch(productProvider.select((value) => value.loading));

    final gtinList =
        ref.watch(productProvider.select((value) => value.gtinTypes));
    final tagList = ref.watch(productProvider.select((value) => value.tagList));

    final manufacturerIdList =
        ref.watch(productProvider.select((value) => value.manufacturerId));
    final countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final nameController = useTextEditingController();
    final brand = useTextEditingController();
    final modelNumer = useTextEditingController();
    final mpn = useTextEditingController();
    final gtin = useTextEditingController();
    final description = useTextEditingController();

    // final originCountry = useTextEditingController();

    final ValueNotifier<GtinTypes?> selectedGtin = useState(null);
    final ValueNotifier<KeyValueData> selectedCountry =
        useState(countryList[0]);
    final ValueNotifier<ManufacturerId?> selectedMenufectur = useState(null);
    final allCategories =
        ref.watch(categoryListProvider.select((value) => value.dataList));
    final ValueNotifier<IList<KeyValueData>> selectedCategories =
        useState(const IListConst([]));
    final active = useState(true);
    final shipping = useState(true);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        productImagePicker.clearDeletedImageIds();
        productImagePicker.clearAllImages();
        ref.read(categoryListProvider.notifier).loadData();
      });
      return null;
    }, []);
    final buttonPressed = useState(false);

    ref.listen<ProductState>(productProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'product_added'.tr());

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
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
        elevation: 0,
        title: Text('create_product'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                KTextField(
                  controller: nameController,
                  lebelText: '${'name'.tr()} *',
                  validator: (text) => ValidatorLogic.requiredField(text),
                ),
                SizedBox(height: 10.h),
                KTextField(controller: brand, lebelText: 'brand'.tr()),
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
                  numberFormatters: true,
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
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      style: TextStyle(color: Colors.grey.shade800),
                      isExpanded: true,
                      value: selectedGtin.value,
                      hint: Text('select_gtin_type'.tr()),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: gtinList
                          .map<DropdownMenuItem<GtinTypes>>((GtinTypes value) {
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
                  lebelText: 'gtin'.tr(),
                  numberFormatters: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                // const Text(
                //   "Manufacturer:",
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
                SizedBox(
                  // height: 50.h,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      hint: Text('select_manufacturer'.tr()),
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
                  lebelText: '${'description'.tr()} *',
                  validator: (text) => ValidatorLogic.requiredField(text),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Text(
                    '${'select_origin_country'.tr()} *',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                SizedBox(
                  // height: 50.h,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      hint: Text('select_origin_country'.tr()),
                      style: TextStyle(color: Colors.grey.shade800),
                      isExpanded: true,
                      value: selectedCountry.value,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: countryList.map<DropdownMenuItem<KeyValueData>>(
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
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  child: SearchChoices<TagListModel>.multiple(
                    items: List<DropdownMenuItem<TagListModel>>.from(
                        tagList.map<DropdownMenuItem<TagListModel>>(
                            (e) => DropdownMenuItem<TagListModel>(
                                  value: e,
                                  child: Text(
                                    e.value,
                                    // textDirection: TextDirection.RTL,
                                  ),
                                ))),
                    selectedItems: selectedTags.value.unlock,
                    hint: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text("select_tags".tr()),
                    ),
                    searchHint: "select_tags".tr(),
                    onChanged: (List<int> value) {
                      selectedTags.value = value.lock;
                      Logger.i(selectedTags.value);

                      //  selectedCategories.value = value;
                    },
                    closeButton: (selectedItems) {
                      return (selectedItems.isNotEmpty
                          ? "Save ${selectedItems.length == 1 ? '"${tagList[selectedItems.first].value}"' : '(${selectedItems.length})'}"
                          : "Save without selection");
                    },
                    isExpanded: true,
                  ),
                ),
                SizedBox(height: 10.h),
                MultipleKeyValueSelector(
                    title: "${'select_categories'.tr()} *",
                    allData: allCategories,
                    onSelect: (list) {
                      selectedCategories.value = list;
                    }),
                SizedBox(height: 20.h),
                Text(
                  "upload_images".tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 10.h),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    productImagePicker.pickProductImages();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: productImagePicker.allProductImages.isNotEmpty
                        ? Center(
                            child: ProductImageList(
                                productImages:
                                    productImagePicker.allProductImages),
                          )
                        : Center(
                            child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
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
                // Text(
                //   "upload_featured_image".tr(),
                //   style: Theme.of(context).textTheme.headline6,
                // ),
                // SizedBox(height: 10.h),
                // InkWell(
                //   borderRadius: BorderRadius.circular(10),
                //   onTap: () {
                //     productImagePicker.pickFeaturedImage();
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(10)),
                //     child: productImagePicker.featuredImage != null
                //         ? Stack(
                //             children: [
                //               Container(
                //                 width: MediaQuery.of(context).size.width,
                //                 height:
                //                     MediaQuery.of(context).size.height * 0.2,
                //                 decoration: BoxDecoration(
                //                   border: Border.all(color: Colors.grey),
                //                 ),
                //                 child: Image.file(
                //                   productImagePicker.featuredImage!,
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //               Positioned(
                //                 right: -10,
                //                 top: -10,
                //                 child: IconButton(
                //                   onPressed: () {
                //                     productImagePicker.removeFeaturedImage();
                //                   },
                //                   icon: const Icon(
                //                     Icons.remove_circle,
                //                     color: Colors.redAccent,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           )
                //         : Center(
                //             child: Container(
                //             padding: const EdgeInsets.symmetric(vertical: 40),
                //             child: Column(
                //               children: [
                //                 const Icon(
                //                   Icons.image,
                //                   size: 42,
                //                   color: Colors.grey,
                //                 ),
                //                 SizedBox(height: 5.h),
                //                 Text('upload_featured_image'.tr()),
                //               ],
                //             ),
                //           )),
                //   ),
                // ),
                // SizedBox(height: 10.h),
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
                      onPressed: () async {
                        Logger.i(selectedCategories.value);
                        if (formKey.currentState?.validate() ?? false) {
                          if (selectedCategories.value.isNotEmpty) {
                            FormData formData = FormData.fromMap({
                              'manufacturer_id':
                                  selectedMenufectur.value != null
                                      ? int.parse(selectedMenufectur.value!.id)
                                      : 0,
                              'brand': brand.text,
                              'name': nameController.text,
                              'model_number': modelNumer.text,
                              'mpn': mpn.text,
                              'gtin': gtin.text,
                              'gtin_type': selectedGtin.value != null
                                  ? selectedGtin.value!.value
                                  : '',
                              'description': description.text,
                              'origin_country': selectedCountry.value.key,
                              'slug': nameController.text
                                  .toLowerCase()
                                  .replaceAll(RegExp(r' '), '-'),
                              'category_list[]': selectedCategories.value
                                  .map((element) =>
                                      int.tryParse(element.key) ?? 0)
                                  .toList(),
                              'tag_list[]': selectedTags.value
                                  .map((element) => element)
                                  .toList(),
                              'active': active.value ? 1 : 0,
                              'require_shipping': shipping.value,
                            });

                            for (CustomImageModel file
                                in productImagePicker.allProductImages) {
                              formData.files.addAll([
                                MapEntry(
                                  'images[]',
                                  await MultipartFile.fromFile(
                                    file.image.path,
                                    filename: file.image.path.split('/').last,
                                    contentType: MediaType("image", "png"),
                                  ),
                                ),
                              ]);
                            }

                            // final product = CreateProductModel(
                            //   manufacturerId: selectedMenufectur.value != null
                            //       ? int.parse(selectedMenufectur.value!.id)
                            //       : 0,
                            //   brand: brand.text,
                            //   name: nameController.text,
                            //   modeNumber: modelNumer.text,
                            //   mpn: mpn.text,
                            //   gtin: gtin.text,
                            //   gtinType: selectedGtin.value != null
                            //       ? selectedGtin.value!.value
                            //       : '',
                            //   description: description.text,
                            //   originCountry: selectedCountry.value != null
                            //       ? selectedCountry.value!.key
                            //       : '',
                            //   slug: nameController.text
                            //       .toLowerCase()
                            //       .replaceAll(RegExp(r' '), '-'),
                            //   categoryList: selectedCategories.value
                            //       .map((element) =>
                            //           int.tryParse(element.key) ?? 0)
                            //       .toList(),
                            //   tagList: selectedTags.value.unlock,
                            //   active: active.value,
                            //   requireShipping: shipping.value,
                            //   images: productImagePicker.productImages,
                            // );
                            ref
                                .read(productProvider.notifier)
                                .createProduct(formData);
                            buttonPressed.value = true;
                          } else {
                            NotificationHelper.error(
                                message:
                                    'please_select_atleast_one_category'.tr());
                          }
                        }
                      },
                      child: loading
                          ? const CircularProgressIndicator()
                          : Text('create'.tr()),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
