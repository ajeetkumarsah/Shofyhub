import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/models/inventory/inventory_details_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';
import 'package:zcart_seller/providers/stocks/form_data_provider.dart';
import 'package:zcart_seller/providers/stocks/inventories_provider.dart';

class UpdateInventoryPage extends ConsumerWidget {
  final int inventoryId;
  final bool needsDouleBack;
  const UpdateInventoryPage({
    super.key,
    required this.inventoryId,
    this.needsDouleBack = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryRef = ref.watch(inventoryDetailsFutureProvider(inventoryId));
    return Scaffold(
      appBar: AppBar(title: const Text("Update Inventory")),
      body: inventoryRef.when(
        data: (inventory) {
          return UpdateInventoryBody(
              inventory: inventory, needsDouleBack: needsDouleBack);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
      ),
    );
  }
}

class UpdateInventoryBody extends ConsumerStatefulWidget {
  final InventoryDetailsModel inventory;
  final bool needsDouleBack;
  const UpdateInventoryBody({
    super.key,
    required this.inventory,
    required this.needsDouleBack,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateInventoryBodyState();
}

class _UpdateInventoryBodyState extends ConsumerState<UpdateInventoryBody> {
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

  bool _isFreeShipping = false;
  // Warehouse (Dropdown)
  int? _warehouse;

  // Shipping weight
  final TextEditingController _shippingWeightController =
      TextEditingController();

  // Purchase price
  final TextEditingController _purchasePriceController =
      TextEditingController();

  // Supplier (Dropdown)
  int? _supplier;

  // Slug
  final TextEditingController _slugController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    final inventoryData = widget.inventory.data;
    // Title
    _titleController.text = inventoryData?.title ?? "";
    // SKU
    _skuController.text = inventoryData?.sku ?? "";
    // Condition
    _condition = inventoryData?.condition ?? "New";
    // Active
    _isActive = inventoryData?.active ?? false;
    // Condition Note
    _conditionNoteController.text = inventoryData?.conditionNote ?? "";
    // Key Features
    for (var keyFeature in inventoryData?.keyFeatures ?? []) {
      _keyFeaturesController.add(TextEditingController(text: keyFeature));
    }
    // Description (HTML)
    _descriptionController.text = inventoryData?.description ?? "";
    // Stock Quantity
    _stockQuantityController.text = inventoryData?.stockQuantity == null
        ? ""
        : inventoryData?.stockQuantity.toString() ?? "";
    // Min order quantity
    _minOrderQuantityController.text = inventoryData?.minOrderQuantity == null
        ? ""
        : inventoryData?.minOrderQuantity.toString() ?? "";
    // Price
    _priceController.text = inventoryData?.salePrice == null
        ? ""
        : inventoryData?.salePrice.toString() ?? "";
    _salePriceController.text = inventoryData?.offerPrice == null
        ? ""
        : inventoryData?.offerPrice.toString() ?? "";
    // Sale Price Start Date
    _salePriceStartDateController.text = inventoryData?.offerStart == null
        ? ""
        : formatDate(DateTime.parse(inventoryData?.offerStart ?? ""));
    // Sale Price End Date
    _salePriceEndDateController.text = inventoryData?.offerEnd == null
        ? ""
        : formatDate(DateTime.parse(inventoryData?.offerEnd ?? ""));
    // LinkedItems
    _linkedItems.addAll(inventoryData?.linkedItems ?? []);
    // Is Free Shipping
    _isFreeShipping = inventoryData?.freeShipping ?? false;
    // Warehouse (Dropdown)
    _warehouse = inventoryData?.warehouseId;
    // Shipping weight
    _shippingWeightController.text = inventoryData?.shippingWeight == null
        ? ""
        : inventoryData?.shippingWeight.toString() ?? "";
    // Purchase price
    _purchasePriceController.text = inventoryData?.purchasePrice == null
        ? ""
        : inventoryData?.purchasePrice.toString() ?? "";
    // Supplier (Dropdown)
    _supplier = inventoryData?.supplierId;
    // Slug
    _slugController.text = inventoryData?.slug ?? "";

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

      String? shippingWeight = _shippingWeightController.text.isNotEmpty
          ? _shippingWeightController.text
          : null;

      String? purchasePrice = _purchasePriceController.text.isNotEmpty
          ? _purchasePriceController.text
          : null;

      final map = {
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
        "offer_price": offerPrice != null ? double.parse(offerPrice) : null,
        "offer_start": offerStartDate,
        "offer_end": offerEndDate,
        "free_shipping": _isFreeShipping ? 1 : 0,
        if (_warehouse != null) "warehouse_id": _warehouse,
        if (shippingWeight != null) "shipping_weight": shippingWeight,
        if (purchasePrice != null) "purchase_price": purchasePrice,
        if (_supplier != null) "supplier_id": _supplier,
        if (_linkedItems.isNotEmpty)
          for (int i = 0; i < _linkedItems.length; i++)
            "linked_items[$i]": _linkedItems[i],
        if (_keyFeaturesController.isNotEmpty)
          for (int i = 0; i < _keyFeaturesController.length; i++)
            "key_features[$i]": _keyFeaturesController[i].text,
      };

      final authRef = ref.read(authProvider);
      Fluttertoast.showToast(msg: 'Updating inventory...');
      setState(() {
        _isLoading = true;
      });
      await InventoryProvider.updateInventory(
        id: widget.inventory.data!.id!,
        apiKey: authRef.user.api_token,
        data: map,
      ).then((value) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: 'Inventory updated successfully');
        ref.invalidate(inventoriesFutureProvider('active'));
        Navigator.of(context).pop();
        if (widget.needsDouleBack) {
          ref.invalidate(
              inventoryDetailsFutureProvider(widget.inventory.data!.id!));
        }
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  }

  String formatDate(DateTime date) {
    final String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final conditionsRef = ref.watch(itemConditionsFormDataProvider);
    final wareHousesRef = ref.watch(warehousesFormDataProvider);
    final suppliersRef = ref.watch(suppliersFormDataProvider);
    final linkedItesRef = ref.watch(linkedItemsFormDataProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                  title: Text(widget.inventory.data?.product?.name ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${widget.inventory.data?.product?.gtinType ?? ''} : ${widget.inventory.data?.product?.gtin ?? ''}",
                      ),
                      // Model
                      Text(
                        "Model: ${widget.inventory.data?.product?.modelNumber ?? ''}",
                      ),
                      // Brand
                      Text(
                        "Brand: ${widget.inventory.data?.product?.brand ?? ''}",
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.inventory.data?.product?.image ?? '',
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
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'title'.tr()),
                      ),

                      const SizedBox(height: 16),

                      // Slug
                      KTextField(
                        controller: _slugController,
                        lebelText: 'Slug *',
                        inputAction: TextInputAction.next,
                        validator: (text) => ValidatorLogic.requiredField(text,
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
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
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
                        int index = _keyFeaturesController.indexOf(controller);
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
                              validator: (text) => ValidatorLogic.requiredField(
                                  text,
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
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
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
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
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
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    labelText: 'Linked Items',
                                  ),
                                  style: TextStyle(color: Colors.grey.shade800),
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
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                    isExpanded: true,
                                    value: _warehouse?.toString(),
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    items: [
                                      const DropdownMenuItem(
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
                        numberFormatters: true,
                      ),

                      const SizedBox(height: 24),

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
                              value: _supplier?.toString(),
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: [
                                const DropdownMenuItem(
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
    );
  }
}
