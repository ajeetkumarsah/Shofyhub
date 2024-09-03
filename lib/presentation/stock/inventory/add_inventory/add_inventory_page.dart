import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:alpesportif_seller/application/app/settings/shop_settings_provider.dart';
import 'package:alpesportif_seller/application/auth/auth_provider.dart';
import 'package:alpesportif_seller/models/product/search_product_model.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/validator_logic.dart';
import 'package:alpesportif_seller/providers/stocks/form_data_provider.dart';
import 'package:alpesportif_seller/providers/stocks/inventories_provider.dart';

class AddInventoryPage extends ConsumerStatefulWidget {
  final SearchProductModel product;
  const AddInventoryPage({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddInventoryPageState();
}

class _AddInventoryPageState extends ConsumerState<AddInventoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  // Condition Dropdown
  String? _condition;
  // Active
  bool _isActive = true;

  final TextEditingController _conditionNoteController =
      TextEditingController();

  // Key Features
  final List<TextEditingController> _keyFeaturesController = [];

  // Description (HTML)
  final TextEditingController _descriptionController = TextEditingController();

  // Stock Quantity
  final TextEditingController _stockQuantityController =
      TextEditingController();
  // Min order quantity
  final TextEditingController _minOrderQuantityController =
      TextEditingController();
  // Price
  final TextEditingController _priceController = TextEditingController();
  // Sale Price
  final TextEditingController _salePriceController = TextEditingController();
  // Sale Price Start Date
  final TextEditingController _salePriceStartDateController =
      TextEditingController();
  // Sale Price End Date
  final TextEditingController _salePriceEndDateController =
      TextEditingController();

  // LinkedItems
  final List<int> _linkedItems = [];

  // Available From
  final TextEditingController _availableFromController =
      TextEditingController();

  // Expiry Date
  final TextEditingController _expiryDateController = TextEditingController();

  bool _isFreeShipping = false;
  // Warehouse (Dropdown)
  int? _warehouse;

  // Shipping weight
  final TextEditingController _shippingWeightController =
      TextEditingController();

  // Packagings (Dropdown)
  // int? _packaging;
  final List<int> _packagings = [];

  // Attributes (Dropdown)
  final Map<String, String> _attributes = {};

  // Purchase price
  final TextEditingController _purchasePriceController =
      TextEditingController();

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

  // Images
  final List<File> images = [];

  bool _isLoading = false;

  @override
  void initState() {
    _keyFeaturesController.add(TextEditingController());
    _minOrderQuantityController.text = '1';
    _condition = 'New';
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

      String? offerPrice = _salePriceController.text.isNotEmpty
          ? _salePriceController.text
          : null;

      String? offerStartDate = _salePriceStartDateController.text.isNotEmpty
          ? _salePriceStartDateController.text
          : null;

      String? offerEndDate = _salePriceEndDateController.text.isNotEmpty
          ? _salePriceEndDateController.text
          : null;

      String? availableFrom = _availableFromController.text.isNotEmpty
          ? _availableFromController.text
          : null;

      String? expiryDate = _expiryDateController.text.isNotEmpty
          ? _expiryDateController.text
          : null;

      String? shippingWeight = _shippingWeightController.text.isNotEmpty
          ? _shippingWeightController.text
          : null;

      String? purchasePrice = _purchasePriceController.text.isNotEmpty
          ? _purchasePriceController.text
          : null;

      String? metaTitle = _metaTitleController.text.isNotEmpty
          ? _metaTitleController.text
          : null;

      String? metaDescription = _metaDescriptionController.text.isNotEmpty
          ? _metaDescriptionController.text
          : null;

      // print("Available from: $availableFrom");

      final map = {
        "product_id": widget.product.id,
        "title": _titleController.text,
        "slug": _slugController.text,
        "sku": _skuController.text,
        "condition": _condition,
        "active": _isActive ? 1 : 0,
        if (condtionNote != null)
          "condition_note": _conditionNoteController.text,
        if (description != null) "description": _descriptionController.text,
        "stock_quantity": int.parse(_stockQuantityController.text),
        "min_order_quantity": int.parse(_minOrderQuantityController.text),
        "sale_price": double.parse(_priceController.text),
        if (offerPrice != null) "offer_price": double.parse(offerPrice),
        if (offerStartDate != null) "offer_start": offerStartDate,
        if (offerEndDate != null) "offer_end": offerEndDate,
        if (availableFrom != null) "available_from": availableFrom,
        if (expiryDate != null) "expiry_date": expiryDate,
        "free_shipping": _isFreeShipping ? 1 : 0,
        if (_warehouse != null) "warehouse_id": _warehouse,
        if (_packagings.isNotEmpty)
          for (int i = 0; i < _packagings.length; i++)
            "packaging_list[$i]": _packagings[i],
        if (shippingWeight != null) "shipping_weight": shippingWeight,
        if (purchasePrice != null) "purchase_price": purchasePrice,
        if (_supplier != null) "supplier_id": _supplier,
        if (metaTitle != null) "meta_title": metaTitle,
        if (metaDescription != null) "meta_description": metaDescription,
        if (_linkedItems.isNotEmpty)
          for (int i = 0; i < _linkedItems.length; i++)
            "linked_items[$i]": _linkedItems[i],
        if (_keyFeaturesController.isNotEmpty)
          for (int i = 0; i < _keyFeaturesController.length; i++)
            "key_features[$i]": _keyFeaturesController[i].text,
        if (_attributes.isNotEmpty)
          for (String key in _attributes.keys)
            "variants[$key]": _attributes[key],
        if (_tags.isNotEmpty)
          for (int i = 0; i < _tags.length; i++) "tags[$i]": _tags[i],
      };

      FormData formdata = FormData.fromMap(map);

      if (images.isNotEmpty) {
        for (var image in images) {
          formdata.files.addAll([
            MapEntry(
              'images[]',
              await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
                contentType: MediaType("image", "png"),
              ),
            ),
          ]);
        }
      }

      final authRef = ref.read(authProvider);
      Fluttertoast.showToast(msg: 'Adding new inventory...');
      setState(() {
        _isLoading = true;
      });
      await InventoryProvider.addInventory(
              apiKey: authRef.user.api_token, data: formdata)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: 'Inventory added successfully');
        ref.invalidate(inventoriesFutureProvider('active'));
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
    final conditionsRef = ref.watch(itemConditionsFormDataProvider);
    final wareHousesRef = ref.watch(warehousesFormDataProvider);
    final attributesByProductRef =
        ref.watch(attributesByProductsFormDataProvider(widget.product.id!));
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
          appBar: AppBar(title: const Text('Add Inventory')),
          body: SingleChildScrollView(
            child: Column(
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

                        // Slug
                        KTextField(
                          controller: _slugController,
                          lebelText: 'Slug *',
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
                          inputAction: TextInputAction.next,
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
                              fieldName: 'Slug'),
                        ),

                        const SizedBox(height: 16),
                        // SKU
                        KTextField(
                          controller: _skuController,
                          lebelText: '${'SKU'} *',
                          inputAction: TextInputAction.done,
                          validator: (text) {
                            return ValidatorLogic.requiredField(text,
                                fieldName: 'SKU');
                          },
                        ),
                        const SizedBox(height: 16),
                        // Condition

                        conditionsRef.when(
                          data: (data) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.w),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  labelText: 'Condition *',
                                ),
                                style: TextStyle(color: Colors.grey.shade800),
                                isExpanded: true,
                                value: _condition,
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
                                    _condition = value.toString();
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
                        // Active
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

                        // Description (HTML)
                        KMultiLineTextField(
                          controller: _descriptionController,
                          lebelText: 'Description',
                        ),
                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Inventory Info",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: KTextField(
                                controller: _stockQuantityController,
                                lebelText: 'Stock Quantity *',
                                keyboardType: TextInputType.number,
                                inputAction: TextInputAction.next,
                                numberFormatters: true,
                                validator: (text) =>
                                    ValidatorLogic.requiredNumber(text,
                                        fieldName: 'Stock Quantity'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: KTextField(
                                controller: _minOrderQuantityController,
                                keyboardType: TextInputType.number,
                                inputAction: TextInputAction.next,
                                numberFormatters: true,
                                lebelText: 'Min Order Quantity *',
                                validator: (text) =>
                                    ValidatorLogic.requiredNumber(text,
                                        fieldName: 'Min Order Quantity'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: KTextField(
                                controller: _priceController,
                                lebelText: 'Price *',
                                inputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                validator: (text) =>
                                    ValidatorLogic.requiredField(text,
                                        fieldName: 'Price'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: KTextField(
                                controller: _salePriceController,
                                keyboardType: TextInputType.number,
                                inputAction: TextInputAction.next,
                                lebelText: 'Offer Price',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: KTextField(
                                controller: _salePriceStartDateController,
                                lebelText: 'Offer Start Date',
                                inputAction: TextInputAction.next,
                                readOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _salePriceStartDateController.clear();
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                                validator: (p0) {
                                  final bool hasOfferPrice =
                                      _salePriceController.text.isNotEmpty;
                                  if (hasOfferPrice) {
                                    return ValidatorLogic.requiredField(p0,
                                        fieldName: 'Offer Start Date');
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
                                      _salePriceStartDateController.text =
                                          formatDate(value);
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: KTextField(
                                controller: _salePriceEndDateController,
                                keyboardType: TextInputType.number,
                                inputAction: TextInputAction.next,
                                readOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _salePriceEndDateController.clear();
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                                validator: (p0) {
                                  final bool hasOfferPrice =
                                      _salePriceController.text.isNotEmpty;
                                  if (hasOfferPrice) {
                                    return ValidatorLogic.requiredField(p0,
                                        fieldName: 'Offer End Date');
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
                                      _salePriceEndDateController.text =
                                          formatDate(value);
                                    }
                                  });
                                },
                                lebelText: 'Offer End Date',
                              ),
                            ),
                          ],
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
                            "Shipping",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Available From
                        KTextField(
                          controller: _availableFromController,
                          lebelText: 'Available From *',
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
                          // validator: (p0) {
                          //   if (p0?.isEmpty ?? true) {
                          //     return ValidatorLogic.requiredField(p0,
                          //         fieldName: 'Expiry Date');
                          //   } else {
                          //     return null;
                          //   }
                          // },
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

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Attributes",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Attributes (Dropdown)
                        // Text(
                        //   'Attributes',
                        //   style: TextStyle(
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        attributesByProductRef.when(
                          data: (data) {
                            return Column(
                              children: data.keys.map((key) {
                                final attribute = data[key]!.attribute;
                                final values = data[key]!.values;

                                return Column(
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1.w),
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          labelText: attribute,
                                        ),
                                        // hint: Text(attribute ?? ''),
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
                                          ...values!.keys.map((valueKey) {
                                            return DropdownMenuItem(
                                              value: valueKey,
                                              child:
                                                  Text(values[valueKey] ?? ''),
                                            );
                                          }).toList()
                                        ],
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              _attributes[key] =
                                                  value.toString();
                                            });
                                          } else {
                                            setState(() {
                                              _attributes.remove(key);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () => const SizedBox(),
                        ),

                        const SizedBox(height: 16),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Purchase Info",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Purchase price
                        KTextField(
                          controller: _purchasePriceController,
                          lebelText: 'Purchase price',
                          keyboardType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          numberFormatters: true,
                        ),
                        const SizedBox(height: 16),

                        // Supplier (Dropdown)

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

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Meta Info",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
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
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                "Images",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            TextButton(
                              onPressed: images.length < 10
                                  ? () async {
                                      final picker = ImagePicker();
                                      try {
                                        final pickedImages =
                                            await picker.pickMultiImage(
                                          maxWidth: 2000,
                                          maxHeight: 2000,
                                        );

                                        for (XFile image in pickedImages) {
                                          var imagesTemporary =
                                              File(image.path);
                                          setState(() {
                                            images.add(imagesTemporary);
                                          });
                                        }
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: "failed_to_pick_image".tr());
                                      }
                                    }
                                  : () {
                                      Fluttertoast.showToast(
                                          msg: "You can add maximum 10 images");
                                    },
                              child: const Text('Upload Images'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (images.isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: images.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              final image = images[index];
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      image: DecorationImage(
                                        image: FileImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(4.r),
                                        padding: EdgeInsets.all(4.r),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                        ),
                                        child: const Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.all(32),
                            child: Center(child: Text("No images added")),
                          ),

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
