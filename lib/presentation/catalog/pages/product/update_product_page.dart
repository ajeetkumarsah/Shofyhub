import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/product/detail_product/detail_product_provider.dart';
import 'package:zcart_seller/application/app/product/detail_product/detail_product_state.dart';
import 'package:zcart_seller/application/app/product/product_provider.dart';
import 'package:zcart_seller/application/app/form/category_list_provider.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/app/product/create_product/gtin_types_model.dart';
import 'package:zcart_seller/domain/app/product/create_product/manufacturer_id.dart';
import 'package:zcart_seller/domain/app/product/create_product/update_product_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class UpdateProductPage extends HookConsumerWidget {
  final int productId;
  const UpdateProductPage({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final gtinList =
        ref.watch(productProvider.select((value) => value.gtinTypes));

    final manufacturerIdList =
        ref.watch(productProvider.select((value) => value.manufacturerId));
    final countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

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
    final ValueNotifier<KeyValueData> selectedCountry =
        useState(countryList[0]);
    final active = useState(true);
    final shipping = useState(true);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(categoryListProvider.notifier).loadData();
        ref.read(detailProcuctProvider(productId).notifier).getDetailProduct();
      });
      return null;
    }, []);

    ref.listen<DetailProductState>(detailProcuctProvider(productId),
        (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.detailProduct.name;
        brandController.text = next.detailProduct.brand;
        modelNumer.text = next.detailProduct.modelNumber;
        mpn.text = next.detailProduct.mpn;
        gtin.text = next.detailProduct.gtin;
        description.text = next.detailProduct.description;
        selectedCountry.value = countryList
            .where((element) => element.value == next.detailProduct.origin)
            .toList()[0];
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
        title: const Text('Update Product'),
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
              KTextField(controller: brandController, lebelText: 'Brand'),
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
              // SearchChoices<TagListModel>.multiple(
              //   items: List<DropdownMenuItem<TagListModel>>.from(
              //       tagList.map<DropdownMenuItem<TagListModel>>(
              //           (e) => DropdownMenuItem<TagListModel>(
              //                 value: e,
              //                 child: Text(
              //                   e.value,
              //                   textDirection: TextDirection.rtl,
              //                 ),
              //               ))),
              //   selectedItems: selectedTags.value.unlock,
              //   hint: const Padding(
              //     padding: EdgeInsets.all(12.0),
              //     child: Text("Select Tags"),
              //   ),
              //   searchHint: "Select Tags",
              //   onChanged: (List<int> value) {
              //     selectedTags.value = value.lock;
              //     Logger.i(selectedTags.value);

              //     //  selectedCategories.value = value;
              //   },
              //   closeButton: (selectedItems) {
              //     return (selectedItems.isNotEmpty
              //         ? "Save ${selectedItems.length == 1 ? '"${tagList[selectedItems.first].value}"' : '(${selectedItems.length})'}"
              //         : "Save without selection");
              //   },
              //   isExpanded: true,
              // ),

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
                      final product = UpdateProductModel(
                        id: productId,
                        slug: nameController.text
                            .toLowerCase()
                            .replaceAll(RegExp(r' '), '-'),
                        manufacturerId: int.parse(selectedMenufectur.value.id),
                        brand: brandController.text,
                        name: nameController.text,
                        modeNumber: modelNumer.text,
                        mpn: mpn.text,
                        gtin: gtin.text,
                        gtinType: selectedGtin.value.value,
                        description: description.text,
                        originCountry: originCountry.text,
                        active: active.value ? 1 : 0,
                        requireShipping: shipping.value,
                      );
                      ref.read(productProvider.notifier).updateProduct(product);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Update'),
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
