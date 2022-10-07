import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/inventory_provider.dart';
import 'package:zcart_seller/application/app/product/product_provider.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_state.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventory_details_provider.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventory_details_state.dart';
import 'package:zcart_seller/domain/app/category/categories/update_category_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/update_inventory_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

import '../../../../application/app/product/product_state.dart';

class UpdateInventoryPage extends HookConsumerWidget {
  final int inventoryId;
  const UpdateInventoryPage({Key? key, required this.inventoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(
        inventoryDetailsProvider(inventoryId).select((value) => value.loading));

    final updateLoading =
        ref.watch(stockeInventoryProvider.select((value) => value.loading));

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(inventoryDetailsProvider(inventoryId).notifier)
            .inventoryDetails();
      });
      return null;
    }, []);

    final titleController = useTextEditingController();
    final brandController = useTextEditingController();
    final conditionNoteController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final availableFromController = useTextEditingController();
    final expirayDateController = useTextEditingController();
    final conditionController = useTextEditingController();
    final keyFeaturesController = useTextEditingController();
    final offerStartsController = useTextEditingController();
    final offerEndsController = useTextEditingController();
    final minOrderQuantiryController = useTextEditingController();
    final offerPriceController = useTextEditingController();
    final skuController = useTextEditingController();
    final stockQuantityController = useTextEditingController();
    final salePriceController = useTextEditingController();
    final shippingWeightController = useTextEditingController();
    final supplierIdController = useTextEditingController();
    final warehouseIdController = useTextEditingController();
    final active = useState(true);
    final freeShipping = useState(true);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen<InventoryDetailsState>(inventoryDetailsProvider(inventoryId),
        (previous, next) {
      if (previous != next && !next.loading) {
        titleController.text = next.inventoryDetails.title;
        brandController.text = next.inventoryDetails.brand;
        descriptionController.text = next.inventoryDetails.description;
        conditionController.text = next.inventoryDetails.condition;
        conditionNoteController.text = next.inventoryDetails.conditionNote;
        keyFeaturesController.text = next.inventoryDetails.keyFeatures;
        // expirayDateController.text = next.inventoryDetails.;
        // availableFromController.text = next.inventoryDetails.;
        offerStartsController.text = next.inventoryDetails.offerStart;
        offerEndsController.text = next.inventoryDetails.offerEnd;
        minOrderQuantiryController.text =
            next.inventoryDetails.minOrderQuantity.toString();
        offerPriceController.text = next.inventoryDetails.offerPrice.toString();
        skuController.text = next.inventoryDetails.sku;
        stockQuantityController.text =
            next.inventoryDetails.stockQuantity.toString();
        salePriceController.text = next.inventoryDetails.salePrice.toString();
        shippingWeightController.text =
            next.inventoryDetails.shippingWeight.toString();
        supplierIdController.text = next.inventoryDetails.supplierId.toString();
        warehouseIdController.text =
            next.inventoryDetails.warehouseId.toString();

        active.value = next.inventoryDetails.active;
        freeShipping.value = next.inventoryDetails.freeShipping;
      }
    });
    ref.listen<InventoriesState>(stockeInventoryProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: Text('inventory_updated'.tr()),
            animationType: AnimationType.fromTop,
          ).show(context);
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
        title: Text('update_inventory'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: titleController,
                        lebelText: '${'title'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'title'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                          controller: brandController, lebelText: 'brand'.tr()),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: descriptionController,
                        lebelText: '${'description'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'description'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: conditionController,
                        lebelText: '${'condition'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'condition'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: conditionNoteController,
                        lebelText: 'condition_note'.tr(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: skuController,
                        lebelText: '${'sku'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'sku'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: minOrderQuantiryController,
                        lebelText: '${'min_order_quantity'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'min_order_quantity'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: stockQuantityController,
                        lebelText: '${'stock_quantity'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'stock_quantity'.tr()),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // KTextField(
                      //   controller: expirayDateController,
                      //   lebelText: 'expiray_date'.tr(),
                      //   readOnly: true,
                      //   onTap: () async {
                      //     DateTime? pickedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(2021),
                      //       lastDate: DateTime(2101),
                      //     );
                      //     if (pickedDate != null) {
                      //       expirayDateController.text = pickedDate.toString();
                      //     }
                      //   },
                      //   suffixIcon: const Icon(Icons.date_range),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: keyFeaturesController,
                        lebelText: 'key_features'.tr(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: salePriceController,
                        lebelText: '${'sale_price'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'sale_price'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: offerPriceController,
                        lebelText: 'offer_price'.tr(),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // KTextField(
                      //   controller: shippingWeightController,
                      //   lebelText: '${'shipping_weight'.tr()} *',
                      //   validator: (text) => ValidatorLogic.requiredField(text,
                      //       fieldName: 'shipping_weight'.tr()),
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // KTextField(
                      //   controller: offerStartsController,
                      //   lebelText: 'offer_start'.tr(),
                      //   readOnly: true,
                      //   onTap: () async {
                      //     DateTime? pickedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(2021),
                      //       lastDate: DateTime(2101),
                      //     );
                      //     if (pickedDate != null) {
                      //       offerStartsController.text =
                      //           DateFormat("dd-MM-yyyy").format(pickedDate);
                      //     }
                      //   },
                      //   suffixIcon: const Icon(Icons.date_range),
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // KTextField(
                      //   controller: offerEndsController,
                      //   lebelText: 'offer_end'.tr(),
                      //   readOnly: true,
                      //   onTap: () async {
                      //     DateTime? pickedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(2021),
                      //       lastDate: DateTime(2101),
                      //     );
                      //     if (pickedDate != null) {
                      //       offerEndsController.text =
                      //           DateFormat("dd-MM-yyyy").format(pickedDate);
                      //     }
                      //   },
                      //   suffixIcon: const Icon(Icons.date_range),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: supplierIdController,
                        lebelText: 'supplier_id'.tr(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: warehouseIdController,
                        lebelText: 'warehouse_id'.tr(),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: active.value,
                        onChanged: (value) => active.value = value,
                        title: Text('active'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: freeShipping.value,
                        onChanged: (value) => freeShipping.value = value,
                        title: Text('free_shipping'.tr()),
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
                              if (formKey.currentState?.validate() ?? false) {
                                final inventory = UpdateInventoryModel(
                                  id: inventoryId,
                                  slug: titleController.text
                                      .toLowerCase()
                                      .replaceAll(RegExp(r' '), '-'),
                                  title: titleController.text,
                                  brand: brandController.text,
                                  condition: conditionController.text,
                                  conditionNote: conditionController.text,
                                  description: descriptionController.text,
                                  // expiryDate: DateTime.tryParse(
                                  //     expirayDateController.text)!,
                                  keyFeatures: keyFeaturesController.text,
                                  minOrderQuantity: int.tryParse(
                                      minOrderQuantiryController.text)!,
                                  // offerPrice: double.tryParse(
                                  //     offerPriceController.text) ?? 0,
                                  // offerStart: offerStartsController.text,
                                  // offerEnd: offerEndsController.text,
                                  sku: skuController.text,
                                  quantity: int.tryParse(
                                      stockQuantityController.text)!,
                                  supplierId:
                                      int.tryParse(supplierIdController.text)!,
                                  salePrice: double.tryParse(
                                      salePriceController.text)!,
                                  shippingWeight: double.tryParse(
                                      shippingWeightController.text)!,
                                  active: active.value ? 1 : 0,
                                  freeShipping: freeShipping.value ? 1 : 0,
                                );
                                ref
                                    .read(stockeInventoryProvider.notifier)
                                    .updateInventory(inventory);
                                // Navigator.of(context).pop();
                              }
                            },
                            child: updateLoading
                                ? const CircularProgressIndicator()
                                : Text('update'.tr()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
