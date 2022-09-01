import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_choices/search_choices.dart';
import 'package:zcart_seller/application/app/Product/product_provider.dart';
import 'package:zcart_seller/domain/app/Product/create_product/create_product_model.dart';
import 'package:zcart_seller/domain/app/Product/create_product/gtin_types_model.dart';
import 'package:zcart_seller/domain/app/Product/create_product/tag_list.dart';

import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

import '../../../../application/app/catalog/atributes/get_atributes_provider.dart';
import '../../../../domain/app/catalog/atributes/categories_model.dart';

class AddProductPage extends HookConsumerWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ValueNotifier<IList<int>> selectedCategories =
        useState(const IListConst([]));
    final ValueNotifier<IList<int>> selectedTags =
        useState(const IListConst([]));
    final ValueNotifier<int> manufacturerId = useState(0);

    final gtinList =
        ref.watch(productProvider.select((value) => value.gtinTypes));
    final tagList = ref.watch(productProvider.select((value) => value.tagList));
    final categoryList =
        ref.watch(getAttributesProvider.select((value) => value.categories));
    final manufacturerIdList =
        ref.watch(productProvider.select((value) => value.manufacturerId));

    final nameController = useTextEditingController();
    final brand = useTextEditingController();
    final modelNumer = useTextEditingController();
    final mpn = useTextEditingController();
    final gtin = useTextEditingController();
    final description = useTextEditingController();
    final minPrice = useTextEditingController();
    final maxPrice = useTextEditingController();
    final originCountry = useTextEditingController();
    final hasVarient = useTextEditingController();
    final downloadable = useTextEditingController();
    final slug = useTextEditingController();
    final saleCount = useTextEditingController();

    final ValueNotifier<GtinTypes> selectedGtin = useState(gtinList[0]);

    final active = useState(false);
    final shipping = useState(false);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {});
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              // SearchChoices<CategoriesModel>.multiple(
              //   items: List<DropdownMenuItem<CategoriesModel>>.from(
              //       categoryList.map<DropdownMenuItem<CategoriesModel>>(
              //           (e) => DropdownMenuItem<CategoriesModel>(
              //                 value: e,
              //                 child: Text(
              //                   e.name,
              //                   textDirection: TextDirection.rtl,
              //                 ),
              //               ))),
              //   selectedItems: selectedCategories.value.unlock,
              //   hint: const Padding(
              //     padding: EdgeInsets.all(12.0),
              //     child: Text("Select ManufacturerId"),
              //   ),
              //   searchHint: "Select ManufacturerId",
              //   onChanged: (List<int> value) {
              //     selectedCategories.value = value.lock;
              //     Logger.i(selectedCategories.value);

              //     //  selectedCategories.value = value;
              //   },
              //   closeButton: (selectedItems) {
              //     return (selectedItems.isNotEmpty
              //         ? "Save ${selectedItems.length == 1 ? '"${categoryList[selectedItems.first].name}"' : '(${selectedItems.length})'}"
              //         : "Save without selection");
              //   },
              //   isExpanded: true,
              // ),
              SizedBox(height: 10.h),
              SwitchListTile(
                value: active.value,
                onChanged: (value) => active.value = value,
                title: const Text('Active status'),
              ),
              KTextField(controller: brand, lebelText: 'Brand'),
              SizedBox(
                height: 20.h,
              ),
              KTextField(controller: nameController, lebelText: 'Name'),
              SizedBox(
                height: 10.h,
              ),
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
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "GTIn Types",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
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
              ),
              SizedBox(
                height: 10.h,
              ),
              SearchChoices<CategoriesModel>.multiple(
                items: List<DropdownMenuItem<CategoriesModel>>.from(
                    categoryList.map<DropdownMenuItem<CategoriesModel>>(
                        (e) => DropdownMenuItem<CategoriesModel>(
                              value: e,
                              child: Text(
                                e.name,
                                textDirection: TextDirection.rtl,
                              ),
                            ))),
                selectedItems: selectedCategories.value.unlock,
                hint: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Select Categories"),
                ),
                searchHint: "Select Categories",
                onChanged: (List<int> value) {
                  selectedCategories.value = value.lock;
                  Logger.i(selectedCategories.value);

                  //  selectedCategories.value = value;
                },
                closeButton: (selectedItems) {
                  return (selectedItems.isNotEmpty
                      ? "Save ${selectedItems.length == 1 ? '"${categoryList[selectedItems.first].name}"' : '(${selectedItems.length})'}"
                      : "Save without selection");
                },
                isExpanded: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: description,
                lebelText: 'Description',
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: minPrice,
                lebelText: 'minPrice',
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: maxPrice,
                lebelText: 'mixPrice',
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: originCountry,
                lebelText: 'originCountry',
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: hasVarient,
                lebelText: 'hasVariant',
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: downloadable,
                lebelText: 'downloadable',
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: slug,
                lebelText: 'slug',
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: saleCount,
                lebelText: 'saleCount',
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
              SwitchListTile(
                value: shipping.value,
                onChanged: (value) => shipping.value = value,
                title: const Text('RequireShipping'),
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
                      final product = CreateProductModel(
                        manufacturerId: manufacturerId.value,
                        brand: brand.text,
                        name: nameController.text,
                        modeNumber: modelNumer.text,
                        mpn: mpn.text,
                        gtin: gtin.text,
                        gtinType: selectedGtin.value.value,
                        description: description.text,
                        minPrice: minPrice.text,
                        maxPrice: maxPrice.text,
                        originCountry: originCountry.text,
                        hasVariant: hasVarient.text,
                        downloadable: downloadable.text,
                        slug: slug.text,
                        saleCount: saleCount.text,
                        categoryList: selectedCategories.value.unlock,
                        tagList: selectedTags.value.unlock,
                        active: active.value,
                        requireShipping: shipping.value,
                      );
                      ref.read(productProvider.notifier).createProduct(product);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create'),
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
