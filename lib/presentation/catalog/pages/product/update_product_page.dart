import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_choices/search_choices.dart';
import 'package:zcart_seller/application/app/Product/product_provider.dart';
import 'package:zcart_seller/application/app/form/category_list_provider.dart';
import 'package:zcart_seller/domain/app/Product/create_product/create_product_model.dart';
import 'package:zcart_seller/domain/app/Product/create_product/gtin_types_model.dart';
import 'package:zcart_seller/domain/app/Product/create_product/manufacturer_id.dart';
import 'package:zcart_seller/domain/app/Product/create_product/tag_list.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';

class UpdateProductPage extends HookConsumerWidget {
  final int productId;
  const UpdateProductPage({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ValueNotifier<IList<int>> selectedTags =
        useState(const IListConst([]));

    final gtinList =
        ref.watch(productProvider.select((value) => value.gtinTypes));
    final tagList = ref.watch(productProvider.select((value) => value.tagList));

    final manufacturerIdList =
        ref.watch(productProvider.select((value) => value.manufacturerId));

    final nameController = useTextEditingController();
    final brand = useTextEditingController();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              KTextField(controller: nameController, lebelText: 'Name'),
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
                lebelText: 'Description',
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
                  title: "Select Categories",
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
                      Logger.i(nameController.text
                          .toLowerCase()
                          .replaceAll(RegExp(r' '), '-'));
                      final product = CreateProductModel(
                        manufacturerId: int.parse(selectedMenufectur.value.id),
                        brand: brand.text,
                        name: nameController.text,
                        modeNumber: modelNumer.text,
                        mpn: mpn.text,
                        gtin: gtin.text,
                        gtinType: selectedGtin.value.value,
                        description: description.text,
                        originCountry: originCountry.text,
                        slug: nameController.text
                            .toLowerCase()
                            .replaceAll(RegExp(r' '), '-'),
                        categoryList: selectedCategories.value
                            .map((element) => int.tryParse(element.key) ?? 0)
                            .toList(),
                        tagList: selectedTags.value.unlock,
                        active: active.value,
                        requireShipping: shipping.value,
                      );
                      ref
                          .read(productProvider.notifier)
                          .updateProduct(product, productId);
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
