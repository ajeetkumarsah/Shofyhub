// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:alpesportif_seller/models/product/search_product_model.dart';
import 'package:alpesportif_seller/presentation/stock/inventory/add_inventory/add_inventory_with_variants_page.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_button.dart';
import 'package:alpesportif_seller/providers/stocks/form_data_provider.dart';

class _AttributeForVariantModel {
  String attributeId;
  String attributeName;
  Map<String, String> selectedValues;
  _AttributeForVariantModel({
    required this.attributeId,
    required this.attributeName,
    required this.selectedValues,
  });
}

class SingleAttributeModel {
  String attributeId;
  String attributeName;
  String valueId;
  String valueName;
  SingleAttributeModel({
    required this.attributeId,
    required this.attributeName,
    required this.valueId,
    required this.valueName,
  });
}

class VariantCombinationModel {
  List<SingleAttributeModel> attributes;
  VariantCombinationModel({required this.attributes});

  @override
  String toString() {
    String result = '';
    for (var element in attributes) {
      result += '${element.attributeName}: ${element.valueName}, ';
    }

    // Remove last comma
    result = result.substring(0, result.length - 2);

    return result;
  }
}

class CreateVariantsPage extends ConsumerStatefulWidget {
  final SearchProductModel product;
  const CreateVariantsPage({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateVariantsPageState();
}

class _CreateVariantsPageState extends ConsumerState<CreateVariantsPage> {
  final List<_AttributeForVariantModel> _attributesForVariant = [];

  @override
  Widget build(BuildContext context) {
    final attributesByProducts =
        ref.watch(attributesByProductsFormDataProvider(widget.product.id!));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Set Variants')),
        body: attributesByProducts.when(
          data: (data) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.keys.map((key) {
                  final attribute = data[key]!.attribute;
                  final values = data[key]!.values;

                  final _AttributeForVariantModel? attributeForVariant =
                      _attributesForVariant
                              .any((element) => element.attributeId == key)
                          ? _attributesForVariant.firstWhere(
                              (element) => element.attributeId == key)
                          : null;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.w),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            labelText: attribute,
                          ),
                          // hint: Text(attribute ?? ''),
                          style: TextStyle(color: Colors.grey.shade800),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: Text('Select'),
                            ),
                            ...values!.keys.map((valueKey) {
                              return DropdownMenuItem(
                                value: valueKey,
                                child: Text(values[valueKey] ?? ''),
                              );
                            }).toList()
                          ],
                          onChanged: (value) {
                            Map<String, String> selectedValues = {};
                            if (value != null) {
                              selectedValues[value] = values[value] ?? '';
                            }
                            String attributeId = key;
                            String attributeName = attribute ?? '';

                            if (_attributesForVariant.any((element) =>
                                element.attributeId == attributeId)) {
                              _attributesForVariant
                                  .firstWhere((element) =>
                                      element.attributeId == attributeId)
                                  .selectedValues
                                  .addAll(selectedValues);
                            } else {
                              _attributesForVariant.add(
                                _AttributeForVariantModel(
                                  attributeId: attributeId,
                                  attributeName: attributeName,
                                  selectedValues: selectedValues,
                                ),
                              );
                            }

                            setState(() {});
                          },
                        ),
                      ),
                      if (attributeForVariant != null)
                        const SizedBox(height: 8),
                      if (attributeForVariant != null)
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: attributeForVariant.selectedValues.keys
                              .map((valueKey) {
                            return Container(
                              margin: EdgeInsets.only(right: 4.w, bottom: 4.h),
                              padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 2.w,
                                  top: 4.h,
                                  bottom: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(attributeForVariant
                                          .selectedValues[valueKey] ??
                                      ''),
                                  IconButton(
                                    onPressed: () {
                                      _attributesForVariant
                                          .firstWhere((element) =>
                                              element.attributeId ==
                                              attributeForVariant.attributeId)
                                          .selectedValues
                                          .remove(valueKey);

                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            );
          },
          error: (error, stackTrace) {
            return const Center(child: Text('Error'));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.w),
          child: KButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (_attributesForVariant.isNotEmpty) {
                // Create combinations using attributes

                final List<VariantCombinationModel> variantCombinations = [];

                for (var element in _attributesForVariant) {
                  final List<SingleAttributeModel> singleAttributes = [];
                  element.selectedValues.forEach((key, value) {
                    singleAttributes.add(
                      SingleAttributeModel(
                        attributeId: element.attributeId,
                        attributeName: element.attributeName,
                        valueId: key,
                        valueName: value,
                      ),
                    );
                  });

                  if (variantCombinations.isEmpty) {
                    variantCombinations.addAll(
                        singleAttributes.map((e) => VariantCombinationModel(
                              attributes: [e],
                            )));
                  } else {
                    final List<VariantCombinationModel> temp = [];
                    for (var variantCombination in variantCombinations) {
                      for (var singleAttribute in singleAttributes) {
                        temp.add(
                          VariantCombinationModel(
                            attributes: [
                              ...variantCombination.attributes,
                              singleAttribute
                            ],
                          ),
                        );
                      }
                    }

                    variantCombinations.clear();
                    variantCombinations.addAll(temp);
                  }
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddInventoryWithVariantsPage(
                      product: widget.product,
                      variantCombinations: variantCombinations,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select at least one attribute'),
                  ),
                );
              }
            },
            child: const Text('Set Variants'),
          ),
        ),
      ),
    );
  }
}
