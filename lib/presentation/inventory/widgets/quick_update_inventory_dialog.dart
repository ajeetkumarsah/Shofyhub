import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/quick_update_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class QuickUpdateInventoryDialog extends HookConsumerWidget {
  final InventoriesModel inventoryInfo;
  const QuickUpdateInventoryDialog({Key? key, required this.inventoryInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final titleController = useTextEditingController(text: inventoryInfo.title);
    final priceController = useTextEditingController(text: inventoryInfo.price);
    final amount = inventoryInfo.stockQuantity;
    final active = useState(inventoryInfo.active);
    final buttonPressed = useState(false);
    ref.listen<InventoriesState>(stockeInventoryProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'item_updated'.tr());
          Navigator.of(context).pop();
          // CherryToast.info(
          //   title: const Text('Inventory Updated'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
         NotificationHelper.error(message: next.failure.error);

          // CherryToast.error(
          //   title: Text(
          //     next.failure.error,
          //   ),
          //   toastPosition: Position.bottom,
          // ).show(context);
        }
      }
    });
    final quantity = useState(amount);

    final loading =
        ref.watch(stockeInventoryProvider.select((value) => value.loading));

    return AlertDialog(
      title: const Text('Inventory Update'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            KTextField(controller: titleController, lebelText: 'Title'),
            SizedBox(height: 15.h),
            KTextField(controller: priceController, lebelText: 'Price'),
            SizedBox(height: 15.h),
            const Text('Quantity'),
            SizedBox(height: 10.h),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    quantity.value = quantity.value + 1;
                  },
                  icon: const Icon(Icons.add),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Text(
                        quantity.value.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  width: 10.w,
                ),
                IconButton(
                  onPressed: () {
                    if (quantity.value > 1) {
                      quantity.value--;
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                active.value
                    ? InkWell(
                        onTap: () {
                          active.value = !active.value;
                        },
                        child: const Icon(Icons.check_box))
                    : InkWell(
                        onTap: () {
                          active.value = !active.value;
                        },
                        child: const Icon(Icons.check_box_outline_blank)),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  'Active',
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
          onPressed: () {
            final double priceValue =
                double.parse(priceController.text.replaceAll('\$', ''));
            buttonPressed.value = true;
            final quickUpdateModel = QuickUpdateModel(
                title: titleController.text,
                quantity: quantity.value,
                salePrice: priceValue,
                active: active.value ? 1 : 0,
                expiryDate: '');
            ref
                .read(stockeInventoryProvider.notifier)
                .quickUpdate(quickUpdateModel, inventoryInfo.id);
          },
          child: loading
              ? const CircularProgressIndicator()
              : const Text('Update'),
        ),
      ],
    );
  }
}
