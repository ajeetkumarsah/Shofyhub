// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_provider.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/models/product/search_product_model.dart';
import 'package:zcart_seller/presentation/stock/inventory/add_inventory/create_variants_page.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';
import 'package:zcart_seller/providers/stocks/form_data_provider.dart';
import 'package:zcart_seller/providers/stocks/inventories_provider.dart';

class VariantInventoryItemModel {
  final VariantCombinationModel combination;
  final TextEditingController skuController;
  String? condition;
  final TextEditingController stockQuantityController;
  final TextEditingController purchasePriceController;
  final TextEditingController priceController;
  final TextEditingController salePriceController;
  File? image;
  VariantInventoryItemModel({
    required this.combination,
    required this.skuController,
    this.condition,
    required this.stockQuantityController,
    required this.purchasePriceController,
    required this.priceController,
    required this.salePriceController,
    this.image,
  });
}

class AddInventoryWithVariantsPage extends ConsumerStatefulWidget {
  final SearchProductModel product;
  final List<VariantCombinationModel> variantCombinations;
  const AddInventoryWithVariantsPage({
    super.key,
    required this.product,
    required this.variantCombinations,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddInventoryWithVariantsPageState();
}

class _AddInventoryWithVariantsPageState
    extends ConsumerState<AddInventoryWithVariantsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  bool _isActive = true;

  final TextEditingController _conditionNoteController =
      TextEditingController();

  final List<TextEditingController> _keyFeaturesController = [];

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _minOrderQuantityController =
      TextEditingController();

  // LinkedItems
  final List<int> _linkedItems = [];

  // Available From
  final TextEditingController _availableFromController =
      TextEditingController();

  // Expiry Date
  final TextEditingController _expiryDateController = TextEditingController();

  // Sale Price Start Date
  final TextEditingController _salePriceStartDateController =
      TextEditingController();
  // Sale Price End Date
  final TextEditingController _salePriceEndDateController =
      TextEditingController();

  bool _isFreeShipping = false;
  // Warehouse (Dropdown)
  int? _warehouse;

  // Shipping weight
  final TextEditingController _shippingWeightController =
      TextEditingController();

  // Packagings (Dropdown)
  final List<int> _packagings = [];

  // Supplier (Dropdown)
  int? _supplier;

  // Slug
  final TextEditingController _slugController = TextEditingController();

  // Tags (Dropdown)
  final List<int> _tags = [];

  // Meta Title
  final TextEditingController _metaTitleController = TextEditingController();

  // Meta Description
  final TextEditingController _metaDescriptionController =
      TextEditingController();

  bool _isLoading = false;

  final List<VariantInventoryItemModel> _variantInventoryItems = [];
  bool _isRemovingVariant = false;

  @override
  void initState() {
    _keyFeaturesController.add(TextEditingController());
    _minOrderQuantityController.text = '1';

    if (widget.variantCombinations.isNotEmpty) {
      _variantInventoryItems.addAll(
        widget.variantCombinations.map(
          (variant) {
            return VariantInventoryItemModel(
              combination: variant,
              condition: "New",
              skuController: TextEditingController(),
              stockQuantityController: TextEditingController(),
              purchasePriceController: TextEditingController(),
              priceController: TextEditingController(),
              salePriceController: TextEditingController(),
            );
          },
        ),
      );
    }
    super.initState();
  }

  void onTapSave() async {
    if (_formKey.currentState!.validate()) {
      String? condtionNote = _conditionNoteController.text.isNotEmpty
          ? _conditionNoteController.text
          : null;

      String? description = _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : null;

      String? availableFrom = _availableFromController.text.isNotEmpty
          ? _availableFromController.text
          : null;

      String? expiryDate = _expiryDateController.text.isNotEmpty
          ? _expiryDateController.text
          : null;

      String? salePriceStartDate = _salePriceStartDateController.text.isNotEmpty
          ? _salePriceStartDateController.text
          : null;

      String? salePriceEndDate = _salePriceEndDateController.text.isNotEmpty
          ? _salePriceEndDateController.text
          : null;

      String? shippingWeight = _shippingWeightController.text.isNotEmpty
          ? _shippingWeightController.text
          : null;

      String? metaTitle = _metaTitleController.text.isNotEmpty
          ? _metaTitleController.text
          : null;

      String? metaDescription = _metaDescriptionController.text.isNotEmpty
          ? _metaDescriptionController.text
          : null;

      List<String> conditions = [];
      List<String> skus = [];
      List<String> stockQuantities = [];
      List<String?> purchasePrices = [];
      List<String> prices = [];
      List<String?> salePrices = [];
      for (VariantInventoryItemModel variant in _variantInventoryItems) {
        conditions.add(variant.condition ?? '');
        skus.add(variant.skuController.text);
        stockQuantities.add(variant.stockQuantityController.text);
        purchasePrices.add(variant.purchasePriceController.text.isNotEmpty
            ? variant.purchasePriceController.text
            : null);
        prices.add(variant.priceController.text);
        salePrices.add(variant.salePriceController.text.isNotEmpty
            ? variant.salePriceController.text
            : null);
      }

      final map = {
        "product": jsonEncode(widget.product.toJson()),
        "title": _titleController.text,
        "slug": _slugController.text,
        "active": _isActive ? 1 : 0,
        if (condtionNote != null)
          "condition_note": _conditionNoteController.text,
        if (description != null) "description": _descriptionController.text,
        "min_order_quantity": int.parse(_minOrderQuantityController.text),
        if (availableFrom != null) "available_from": availableFrom,
        if (expiryDate != null) "expiry_date": expiryDate,
        if (salePriceStartDate != null) "offer_start": salePriceStartDate,
        if (salePriceEndDate != null) "offer_end": salePriceEndDate,
        "free_shipping": _isFreeShipping ? 1 : 0,
        if (_warehouse != null) "warehouse_id": _warehouse,
        if (_packagings.isNotEmpty)
          for (int i = 0; i < _packagings.length; i++)
            "packaging_list[$i]": _packagings[i],
        if (shippingWeight != null) "shipping_weight": shippingWeight,
        if (_supplier != null) "supplier_id": _supplier,
        if (metaTitle != null) "meta_title": metaTitle,
        if (metaDescription != null) "meta_description": metaDescription,
        if (_linkedItems.isNotEmpty)
          for (int i = 0; i < _linkedItems.length; i++)
            "linked_items[$i]": _linkedItems[i],
        if (_keyFeaturesController.isNotEmpty)
          for (int i = 0; i < _keyFeaturesController.length; i++)
            "key_features[$i]": _keyFeaturesController[i].text,
        if (_tags.isNotEmpty)
          for (int i = 0; i < _tags.length; i++) "tags[$i]": _tags[i],
        // for (String condition in conditions) "condition[]": condition,
        for (int i = 0; i < conditions.length; i++)
          "condition[$i]": conditions[i],
        // for (String sku in skus) "sku[]": sku,
        for (int i = 0; i < skus.length; i++) "sku[$i]": skus[i],
        // for (String stockQuantity in stockQuantities)
        //   "stock_quantity[]": stockQuantity,
        for (int i = 0; i < stockQuantities.length; i++)
          "stock_quantity[$i]": stockQuantities[i],

        for (int i = 0; i < purchasePrices.length; i++)
          "purchase_price[$i]": purchasePrices[i],

        for (int i = 0; i < prices.length; i++) "sale_price[$i]": prices[i],
        // for (String? salePrice in salePrices) "offer_price[]": salePrice,
        for (int i = 0; i < salePrices.length; i++)
          "offer_price[$i]": salePrices[i],
        for (int i = 0; i < _variantInventoryItems.length; i++)
          for (SingleAttributeModel attribute
              in _variantInventoryItems[i].combination.attributes)
            "variants[$i][${attribute.attributeId}]": attribute.valueId,
      };

      FormData formdata = FormData.fromMap(map);

      List<File?> images = [];
      for (VariantInventoryItemModel variant in _variantInventoryItems) {
        images.add(variant.image);
      }

      if (images.isNotEmpty) {
        for (var image in images) {
          if (image != null) {
            formdata.files.addAll([
              MapEntry(
                'image[]',
                await MultipartFile.fromFile(
                  image.path,
                  filename: image.path.split('/').last,
                  contentType: MediaType("image", "png"),
                ),
              ),
            ]);
          }
        }
      }

      final authRef = ref.read(authProvider);
      Fluttertoast.showToast(msg: 'Adding new inventory...');
      setState(() {
        _isLoading = true;
      });
      await InventoryProvider.addInventoryWithVariants(
              apiKey: authRef.user.api_token, data: formdata)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: 'Inventory added successfully');
        ref.invalidate(inventoriesFutureProvider('active'));
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // for (var element in _variantInventoryItems) {
    //   print("Variant combination: ${element.combination.toString()}");
    // }
    // print("Variant combinations length: ${_variantInventoryItems.length}");

    final conditionsRef = ref.watch(itemConditionsFormDataProvider);
    final wareHousesRef = ref.watch(warehousesFormDataProvider);
    final tagListRef = ref.watch(tagListFormDataProvider);
    final suppliersRef = ref.watch(suppliersFormDataProvider);
    final linkedItesRef = ref.watch(linkedItemsFormDataProvider);
    final packagingsRef = ref.watch(packagingsFormDataProvider);

    final shopData =
        ref.watch(shopSettingsProvider.select((value) => value.shopSettings));

    // 2022-07-30 07:57 pm
    String formatDate(DateTime date) {
      final String formattedDate =
          DateFormat('yyyy-MM-dd hh:mm a').format(date);
      return formattedDate;
    }

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to discard this inventory?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Inventory with Variants'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(widget.product.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${widget.product.gtinType ?? ''} : ${widget.product.gtin ?? ''}",
                        ),
                        // Model
                        Text(
                          "Model: ${widget.product.modelNumber ?? ''}",
                        ),
                        // Brand
                        Text(
                          "Brand: ${widget.product.brand ?? ''}",
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.product.image ?? '',
                      ),
                    ),
                    trailing: const Icon(Icons.check_box_outlined),
                  ),
                ),

                // Form
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "General",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
                        KTextField(
                          controller: _titleController,
                          inputAction: TextInputAction.next,
                          lebelText: '${'title'.tr()} *',
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
                              fieldName: 'title'.tr()),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CheckboxListTile(
                            value: _isActive,
                            onChanged: (value) {
                              setState(() {
                                _isActive = value ?? false;
                              });
                            },
                            title: const Text('Active'),
                          ),
                        ),

                        const SizedBox(height: 16),

                        ///

                        KTextField(
                          controller: _availableFromController,
                          lebelText: 'Available From',
                          readOnly: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _availableFromController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          validator: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return ValidatorLogic.requiredField(p0,
                                  fieldName: 'Available From');
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365 * 20),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365 * 20),
                              ),
                            ).then((value) {
                              if (value != null) {
                                _availableFromController.text =
                                    formatDate(value);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Expiry Date
                        KTextField(
                          controller: _expiryDateController,
                          lebelText: 'Expiry Date',
                          readOnly: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _expiryDateController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365 * 20),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365 * 20),
                              ),
                            ).then((value) {
                              if (value != null) {
                                _expiryDateController.text = formatDate(value);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Is Free Shipping
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CheckboxListTile(
                            value: _isFreeShipping,
                            onChanged: (value) {
                              setState(() {
                                _isFreeShipping = value ?? false;
                              });
                            },
                            title: const Text('Free Shipping'),
                          ),
                        ),
                        const SizedBox(height: 16),

                        KTextField(
                          controller: _minOrderQuantityController,
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          numberFormatters: true,
                          lebelText: 'Min Order Quantity *',
                          validator: (text) => ValidatorLogic.requiredNumber(
                              text,
                              fieldName: 'Min Order Quantity'),
                        ),
                        const SizedBox(height: 16),

                        // Warehouse (Dropdown)
                        wareHousesRef.when(
                          data: (data) {
                            return Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1.w),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        labelText: 'Warehouse',
                                      ),
                                      style: TextStyle(
                                          color: Colors.grey.shade800),
                                      isExpanded: true,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded),
                                      items: [
                                        const DropdownMenuItem(
                                          value: null,
                                          child: Text('Select'),
                                        ),
                                        ...data.keys.map((key) {
                                          return DropdownMenuItem(
                                            value: key,
                                            child: Text(data[key] ?? ''),
                                          );
                                        }).toList()
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          if (value != null) {
                                            _warehouse =
                                                int.parse(value.toString());
                                          } else {
                                            _warehouse = null;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () => const SizedBox(),
                        ),
                        const SizedBox(height: 16),
                        suppliersRef.when(
                          data: (data) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.w),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  labelText: 'Supplier',
                                ),
                                style: TextStyle(color: Colors.grey.shade800),
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Select'),
                                  ),
                                  ...data.keys.map((key) {
                                    return DropdownMenuItem(
                                      value: key,
                                      child: Text(data[key] ?? ''),
                                    );
                                  }).toList()
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      _supplier = int.parse(value.toString());
                                    } else {
                                      _supplier = null;
                                    }
                                  });
                                },
                              ),
                            );
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () => const SizedBox(),
                        ),

                        const SizedBox(height: 16),

                        // Shipping weight
                        KTextField(
                          controller: _shippingWeightController,
                          lebelText: 'Shipping weight (g)',
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          decimalFormatters: true,
                        ),
                        const SizedBox(height: 16),

                        // Packagings (Dropdown)

                        packagingsRef.when(
                          data: (data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.w),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      labelText: 'Packagings',
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                    isExpanded: true,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    items: [
                                      const DropdownMenuItem(
                                        value: null,
                                        child: Text('Select'),
                                      ),
                                      ...data.keys.map((key) {
                                        return DropdownMenuItem(
                                          value: key,
                                          child: Text(data[key] ?? ''),
                                        );
                                      }).toList()
                                    ],
                                    onChanged: (value) {
                                      if (value != null) {
                                        _packagings
                                            .add(int.parse(value.toString()));

                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                if (_packagings.isNotEmpty)
                                  Wrap(
                                    spacing: 8,
                                    children: _packagings.map((packagingId) {
                                      return InputChip(
                                        label: Text(
                                            data[packagingId.toString()] ?? ''),
                                        deleteIcon:
                                            const Icon(Icons.clear, size: 16),
                                        onDeleted: () {
                                          setState(() {
                                            _packagings.remove(packagingId);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  )
                                else
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 24),
                                    child: Text("Select packagings"),
                                  ),
                              ],
                            );
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () => const SizedBox(),
                        ),

                        const SizedBox(height: 24),

                        //
                        //
                        //

                        // Variants

                        //
                        //
                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Variants",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_isRemovingVariant)
                          const SizedBox(
                            height: 300,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        if (!_isRemovingVariant)
                          ..._variantInventoryItems.map((variant) {
                            int index = _variantInventoryItems.indexOf(variant);

                            final skuController = variant.skuController;
                            final stockQuantityController =
                                variant.stockQuantityController;
                            final purchasePriceController =
                                variant.purchasePriceController;
                            final priceController = variant.priceController;
                            final salePriceController =
                                variant.salePriceController;

                            // print(
                            //     "Index: $index - Condition: ${variant.condition}");
                            // print("SKU: ${skuController.text}");
                            // print(
                            //     "Stock Quantity: ${stockQuantityController.text}");

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      leading: Text(
                                        "${index + 1}.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      minLeadingWidth: 0,
                                      title:
                                          Text(variant.combination.toString()),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isRemovingVariant = true;
                                          });
                                          await Future.delayed(const Duration(
                                              milliseconds: 300));
                                          setState(() {
                                            _variantInventoryItems
                                                .removeAt(index);
                                          });
                                          setState(() {
                                            _isRemovingVariant = false;
                                          });
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Image
                                          GestureDetector(
                                            onTap: () async {
                                              final picker = ImagePicker();
                                              try {
                                                final pickedImages =
                                                    await picker.pickImage(
                                                  source: ImageSource.gallery,
                                                  maxWidth: 2000,
                                                  maxHeight: 2000,
                                                );

                                                if (pickedImages != null) {
                                                  var imagesTemporary =
                                                      File(pickedImages.path);
                                                  setState(() {
                                                    variant.image =
                                                        imagesTemporary;
                                                  });
                                                }
                                              } catch (e) {
                                                Fluttertoast.showToast(
                                                    msg: "failed_to_pick_image"
                                                        .tr());
                                              }
                                            },
                                            child: Container(
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                                image: variant.image != null
                                                    ? DecorationImage(
                                                        image: FileImage(
                                                            variant.image!),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null,
                                              ),
                                              child: variant.image == null
                                                  ? const Center(
                                                      child: Icon(
                                                        Icons.image,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          ),

                                          const SizedBox(height: 16),
                                          conditionsRef.when(
                                            data: (data) {
                                              return DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1.w),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                    ),
                                                    labelText: 'Condition *',
                                                  ),
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800),
                                                  isExpanded: true,
                                                  value: variant.condition,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down_rounded),
                                                  items: data.keys.map((key) {
                                                    return DropdownMenuItem(
                                                      value: key,
                                                      child:
                                                          Text(data[key] ?? ''),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      variant.condition =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              );
                                            },
                                            error: (error, stackTrace) {
                                              return const SizedBox();
                                            },
                                            loading: () => const SizedBox(),
                                          ),
                                          const SizedBox(height: 8),

                                          // Sku Form Field
                                          KTextField(
                                            controller: skuController,
                                            lebelText: 'SKU',
                                            inputAction: TextInputAction.next,
                                            validator: (text) =>
                                                ValidatorLogic.requiredField(
                                                    text,
                                                    fieldName: 'SKU'),
                                          ),
                                          const SizedBox(height: 8),
                                          // Stock Quantity Form Field
                                          KTextField(
                                            controller: stockQuantityController,
                                            lebelText: 'Stock Quantity',
                                            keyboardType: TextInputType.number,
                                            inputAction: TextInputAction.next,
                                            numberFormatters: true,
                                            validator: (text) =>
                                                ValidatorLogic.requiredNumber(
                                                    text,
                                                    fieldName:
                                                        'Stock Quantity'),
                                          ),
                                          const SizedBox(height: 8),
                                          // Purchase Price Form Field
                                          KTextField(
                                            controller: purchasePriceController,
                                            lebelText: 'Purchase Price',
                                            keyboardType: TextInputType.number,
                                            inputAction: TextInputAction.next,
                                          ),
                                          const SizedBox(height: 8),
                                          // Price Form Field
                                          KTextField(
                                            controller: priceController,
                                            lebelText: 'Price',
                                            keyboardType: TextInputType.number,
                                            inputAction: TextInputAction.next,
                                            validator: (text) =>
                                                ValidatorLogic.requiredNumber(
                                                    text,
                                                    fieldName: 'Price'),
                                          ),
                                          const SizedBox(height: 8),
                                          // Sale Price Form Field
                                          KTextField(
                                            controller: salePriceController,
                                            lebelText: 'Sale Price',
                                            keyboardType: TextInputType.number,
                                            inputAction: TextInputAction.next,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Offer Info",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Sale Price Form Field
                        KTextField(
                          controller: _salePriceStartDateController,
                          lebelText: 'Offer Price Start Date',
                          readOnly: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _salePriceStartDateController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365 * 20),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365 * 20),
                              ),
                            ).then((value) {
                              if (value != null) {
                                _salePriceStartDateController.text =
                                    formatDate(value);
                              }
                            });
                          },
                          validator: (value) {
                            final List<String> offerPrices = [];
                            for (VariantInventoryItemModel variant
                                in _variantInventoryItems) {
                              String salePrice =
                                  variant.salePriceController.text;
                              if (salePrice.isNotEmpty) {
                                offerPrices.add(salePrice);
                              }
                            }
                            if (offerPrices.isNotEmpty &&
                                (value == null || value.isEmpty)) {
                              return 'Enter offer Start Date';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        // Sale Price Form Field
                        KTextField(
                          controller: _salePriceEndDateController,
                          lebelText: 'Offer Price End Date',
                          readOnly: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _salePriceEndDateController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365 * 20),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365 * 20),
                              ),
                            ).then((value) {
                              if (value != null) {
                                _salePriceEndDateController.text =
                                    formatDate(value);
                              }
                            });
                          },
                          validator: (value) {
                            final List<String> offerPrices = [];
                            for (VariantInventoryItemModel variant
                                in _variantInventoryItems) {
                              String salePrice =
                                  variant.salePriceController.text;
                              if (salePrice.isNotEmpty) {
                                offerPrices.add(salePrice);
                              }
                            }
                            if (offerPrices.isNotEmpty &&
                                (value == null || value.isEmpty)) {
                              return 'Enter offer End Date';
                            } else {
                              return null;
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Other Info",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Condition Note
                        KMultiLineTextField(
                          controller: _conditionNoteController,
                          lebelText: 'Condition Note',
                        ),

                        // Key Features
                        ListTile(
                          title: const Text('Key Features'),
                          trailing: IconButton(
                            onPressed: _keyFeaturesController.length < 7
                                ? () {
                                    // _keyFeaturesController.add(TextEditingController());
                                    // setState(() {});
                                    if (_keyFeaturesController.length < 7) {
                                      _keyFeaturesController
                                          .add(TextEditingController());
                                      setState(() {});
                                    }
                                  }
                                : null,
                            icon: const Icon(Icons.add),
                          ),
                        ),
                        ..._keyFeaturesController.map((controller) {
                          int index =
                              _keyFeaturesController.indexOf(controller);
                          return Column(
                            children: [
                              KTextField(
                                controller: controller,
                                lebelText: 'Key Feature ${index + 1}',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _keyFeaturesController.remove(controller);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }).toList(),

                        const SizedBox(height: 16),
                        // Description (HTML)
                        KMultiLineTextField(
                          controller: _descriptionController,
                          lebelText: 'Description',
                        ),

                        const SizedBox(height: 16),
                        linkedItesRef.when(
                          data: (data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.w),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      labelText: 'Linked Items',
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                    isExpanded: true,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    items: data.keys.map((key) {
                                      return DropdownMenuItem(
                                        value: key,
                                        child: Text(data[key] ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _linkedItems
                                            .add(int.parse(value.toString()));
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (_linkedItems.isNotEmpty)
                                  Wrap(
                                    spacing: 8,
                                    children: _linkedItems.map((itemId) {
                                      return InputChip(
                                        label:
                                            Text(data[itemId.toString()] ?? ''),
                                        deleteIcon:
                                            const Icon(Icons.clear, size: 16),
                                        onDeleted: () {
                                          setState(() {
                                            _linkedItems.remove(itemId);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  )
                                else
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 24),
                                    child: Text("Select linked items"),
                                  )
                              ],
                            );
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () => const SizedBox(),
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Meta Info",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Slug
                        KTextField(
                          controller: _slugController,
                          lebelText: 'Slug',
                          inputAction: TextInputAction.next,
                          onTap: () {
                            final shopName = shopData.name
                                .toLowerCase()
                                .replaceAll(' ', '-')
                                .replaceAll('.', '');
                            final slug = _titleController.text
                                .toLowerCase()
                                .replaceAll(' ', '-');
                            _slugController.text = '$shopName-$slug';
                          },
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
                              fieldName: 'Slug'),
                        ),
                        const SizedBox(height: 16),

                        // Tags (Dropdown)

                        tagListRef.when(
                          data: (data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.w),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      labelText: 'Tags',
                                    ),
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                    isExpanded: true,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    items: data.keys.map((key) {
                                      return DropdownMenuItem(
                                        value: key,
                                        child: Text(data[key] ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _tags.add(int.parse(value.toString()));
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (_tags.isNotEmpty)
                                  Wrap(
                                    spacing: 8,
                                    children: _tags.map((tagId) {
                                      return InputChip(
                                        label:
                                            Text(data[tagId.toString()] ?? ''),
                                        deleteIcon:
                                            const Icon(Icons.clear, size: 16),
                                        onDeleted: () {
                                          setState(() {
                                            _tags.remove(tagId);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  )
                                else
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 24),
                                    child: Text("Select tags"),
                                  )
                              ],
                            );
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () => const SizedBox(),
                        ),

                        const SizedBox(height: 16),

                        // Meta Title
                        KTextField(
                          controller: _metaTitleController,
                          lebelText: 'Meta Title',
                        ),
                        const SizedBox(height: 16),

                        // Meta Description
                        KMultiLineTextField(
                          controller: _metaDescriptionController,
                          lebelText: 'Meta Description',
                        ),
                        // const SizedBox(height: 16),

                        const SizedBox(height: 32),

                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Are you sure?'),
                                            content: const Text(
                                                'Do you want to discard this inventory?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: onTapSave,
                                    child: const Text("Save"),
                                  )
                                ],
                              ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
