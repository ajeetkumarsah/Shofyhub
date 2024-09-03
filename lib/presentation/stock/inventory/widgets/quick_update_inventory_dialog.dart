import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:alpesportif_seller/application/auth/auth_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/models/inventory/inventory_model.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:alpesportif_seller/providers/stocks/inventories_provider.dart';

class QuickUpdateInventoryDialog extends ConsumerStatefulWidget {
  final Inventory inventory;

  const QuickUpdateInventoryDialog({
    Key? key,
    required this.inventory,
  }) : super(key: key);

  @override
  ConsumerState<QuickUpdateInventoryDialog> createState() =>
      _QuickUpdateInventoryDialogState();
}

class _QuickUpdateInventoryDialogState
    extends ConsumerState<QuickUpdateInventoryDialog> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  int _quantity = 0;
  bool _active = false;

  @override
  void initState() {
    _titleController.text = widget.inventory.title ?? "";
    // _priceController.text = widget.inventory.price ?? "";
    // Remove currency symbol from price
    String price = widget.inventory.price ?? "";
    price = price.replaceAll(RegExp(r'\p{Sc}', unicode: true), '');
    _priceController.text = price;

    _quantity = widget.inventory.stockQuantity ?? 0;
    _active = widget.inventory.active ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Inventory Update'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            KTextField(
              controller: _titleController,
              lebelText: 'Title',
            ),
            SizedBox(height: 15.h),
            KTextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              lebelText: 'Price',
            ),
            SizedBox(height: 15.h),
            const Text('Quantity'),
            SizedBox(height: 10.h),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() {
                        _quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Text(
                        _quantity.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(width: 10.w),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity = _quantity + 1;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.kLightCardBgColor),
                  onPressed: () {
                    setState(() {
                      _quantity += 5;
                    });
                  },
                  child: const Text(
                    '+5',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.kLightCardBgColor),
                  onPressed: () {
                    setState(() {
                      _quantity += 10;
                    });
                  },
                  child: const Text(
                    '+10',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.kLightCardBgColor),
                  onPressed: () {
                    setState(() {
                      _quantity += 100;
                    });
                  },
                  child: const Text(
                    '+100',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.kLightCardBgColor),
                  onPressed: () {
                    setState(() {
                      _quantity = 0;
                    });
                  },
                  child: const Text(
                    '0',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                _active
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            _active = !_active;
                          });
                        },
                        child: const Icon(Icons.check_box))
                    : InkWell(
                        onTap: () {
                          setState(() {
                            _active = !_active;
                          });
                        },
                        child: const Icon(Icons.check_box_outline_blank)),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  'active'.tr(),
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
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
          onPressed: () async {
            final authRef = ref.read(authProvider);

            toast('Quick Updating...');
            await InventoryProvider.inventoryQuickUpdate(
              id: widget.inventory.id!,
              apiKey: authRef.user.api_token,
              active: _active ? 1 : 0,
              title: _titleController.text.trim(),
              salePrice: _priceController.text.trim(),
              stockQuantity: _quantity,
            ).then((value) {
              toast('Updated Successfully');
              ref.invalidate(inventoriesFutureProvider("active"));
              Navigator.of(context).pop();
            }).onError((error, stackTrace) {
              toast(error.toString());
            });
          },
          child: Text('update'.tr()),
        ),
      ],
    );
  }
}
