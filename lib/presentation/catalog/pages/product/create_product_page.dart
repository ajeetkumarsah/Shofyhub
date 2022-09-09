import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
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

    final ValueNotifier<GtinTypes> selectedGtin = useState(gtinList[0]);
    final ValueNotifier<KeyValueData> selectedCountry =
        useState(countryList[0]);
    final ValueNotifier<ManufacturerId> selectedMenufectur =
        useState(manufacturerIdList[0]);
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
            title: const Text('Product added'),
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
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  '* Required fields.',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                SizedBox(height: 10.h),
                KTextField(
                  controller: nameController,
                  lebelText: 'Name *',
                  validator: (text) => ValidatorLogic.requiredField(text),
                ),
                SizedBox(height: 10.h),
                KTextField(controller: brand, lebelText: 'Brand'),
                SizedBox(height: 10.h),
                KTextField(
                  controller: modelNumer,
                  lebelText: 'Model Number',
                ),
                SizedBox(
                  height: 10.h,
                ),
                KTextField(
                  controller: mpn,
                  lebelText: 'mpn',
                  numberFormatters: true,
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
                  lebelText: 'gtin',
                  numberFormatters: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  "Manufacturer:",
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
                  lebelText: 'Description *',
                  validator: (text) => ValidatorLogic.requiredField(text),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  "Origin country:",
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
                                  textDirection: TextDirection.rtl,
                                ),
                              ))),
                  selectedItems: selectedTags.value.unlock,
                  hint: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Select Tags"),
                  ),
                  searchHint: "Select Tags",
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
                    title: "Select Categories *",
                    allData: allCategories,
                    onSelect: (list) {
                      selectedCategories.value = list;
                    }),
                SizedBox(height: 10.h),
                SwitchListTile(
                  value: active.value,
                  onChanged: (value) => active.value = value,
                  title: const Text('Active '),
                ),
                SizedBox(height: 10.h),
                SwitchListTile(
                  value: shipping.value,
                  onChanged: (value) => shipping.value = value,
                  title: const Text('Require Shipping'),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Logger.i(selectedCategories.value);
                        if (formKey.currentState?.validate() ?? false) {
                          if (selectedCategories.value.isNotEmpty) {
                            final product = CreateProductModel(
                              manufacturerId:
                                  int.parse(selectedMenufectur.value.id),
                              brand: brand.text,
                              name: nameController.text,
                              modeNumber: modelNumer.text,
                              mpn: mpn.text,
                              gtin: gtin.text,
                              gtinType: selectedGtin.value.value,
                              description: description.text,
                              originCountry: selectedCountry.value.key,
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
                              title: const Text(
                                'Category group is required',
                              ),
                              toastPosition: Position.bottom,
                            ).show(context);
                          }
                        }
                      },
                      child: const Text('Create'),
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
