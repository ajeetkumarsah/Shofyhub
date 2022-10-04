import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_choices/search_choices.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/product/product_provider.dart';
import 'package:zcart_seller/application/app/form/category_list_provider.dart';
import 'package:zcart_seller/application/app/product/product_state.dart';
import 'package:zcart_seller/domain/app/product/create_product/create_product_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/gtin_types_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/manufacturer_id.dart';
import 'package:zcart_seller/domain/app/product/create_product/tag_list.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class AddProductPage extends HookConsumerWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ValueNotifier<IList<int>> selectedTags =
        useState(const IListConst([]));

    final loading =
        ref.watch(productProvider.select((value) => value.loading));

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
    final ValueNotifier<KeyValueData?> selectedCountry = useState(null);
    final ValueNotifier<ManufacturerId?> selectedMenufectur = useState(null);
    final allCategories =
        ref.watch(categoryListProvider.select((value) => value.dataList));
    final ValueNotifier<IList<KeyValueData>> selectedCategories =
        useState(const IListConst([]));
    final active = useState(true);
    final shipping = useState(true);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(categoryListProvider.notifier).loadData();
      });
      return null;
    }, []);
    final buttonPressed = useState(false);

    ref.listen<ProductState>(productProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          CherryToast.info(
            title: Text('product_added'.tr()),
            animationType: AnimationType.fromTop,
          ).show(context);

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.error(
            title: Text(
              next.failure.error,
            ),
            toastPosition: Position.bottom,
          ).show(context);
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
                Text(
                  'required_fields'.tr(),
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
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
                // const Text(
                //   "GTIn Types:",
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
                SizedBox(
                  height: 50.h,
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
                          borderRadius: BorderRadius.circular(10.r),
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
                SizedBox(
                  height: 10.h,
                ),

                SizedBox(
                  height: 50.h,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.w),
                          borderRadius: BorderRadius.circular(10.r),
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
                SearchChoices<TagListModel>.multiple(
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
                    padding: const EdgeInsets.all(12.0),
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
                SizedBox(height: 10.h),
                MultipleKeyValueSelector(
                    title: "${'select_Categories'.tr()} *",
                    allData: allCategories,
                    onSelect: (list) {
                      selectedCategories.value = list;
                    }),
                SizedBox(height: 10.h),
                SwitchListTile(
                  value: active.value,
                  onChanged: (value) => active.value = value,
                  title: Text('active'.tr()),
                ),
                SizedBox(height: 10.h),
                SwitchListTile(
                  value: shipping.value,
                  onChanged: (value) => shipping.value = value,
                  title: Text('require_shipping'.tr()),
                ),
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
                      onPressed: () {
                        Logger.i(selectedCategories.value);
                        if (formKey.currentState?.validate() ?? false) {
                          if (selectedCategories.value.isNotEmpty) {
                            final product = CreateProductModel(
                              manufacturerId: selectedMenufectur.value != null
                                  ? int.parse(selectedMenufectur.value!.id)
                                  : 0,
                              brand: brand.text,
                              name: nameController.text,
                              modeNumber: modelNumer.text,
                              mpn: mpn.text,
                              gtin: gtin.text,
                              gtinType: selectedGtin.value != null
                                  ? selectedGtin.value!.value
                                  : '',
                              description: description.text,
                              originCountry: selectedCountry.value != null
                                  ? selectedCountry.value!.key
                                  : '',
                              slug: nameController.text
                                  .toLowerCase()
                                  .replaceAll(RegExp(r' '), '-'),
                              categoryList: selectedCategories.value
                                  .map((element) =>
                                      int.tryParse(element.key) ?? 0)
                                  .toList(),
                              tagList: selectedTags.value.unlock,
                              active: active.value,
                              requireShipping: shipping.value,
                            );
                            ref
                                .read(productProvider.notifier)
                                .createProduct(product);
                            buttonPressed.value = true;
                          } else {
                            CherryToast.error(
                              title: Text(
                                'category_group_is_required'.tr(),
                              ),
                              toastPosition: Position.bottom,
                            ).show(context);
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
