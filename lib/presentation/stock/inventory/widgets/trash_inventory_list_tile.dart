import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/models/inventory/inventory_model.dart';
import 'package:alpesportif_seller/presentation/stock/inventory/widgets/delete_inventory_dialog.dart';
import 'package:alpesportif_seller/presentation/stock/inventory/widgets/restore_inventory.dart';

class TrashInventoryItemTile extends StatelessWidget {
  final Inventory inventory;
  const TrashInventoryItemTile({
    Key? key,
    required this.inventory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.trashColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(inventory.image ?? ""),
        ),
        title: Text(
          inventory.title ?? "",
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.green.shade300),
                    child: Center(
                      child: Text(
                        inventory.condition ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          wordSpacing: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity: ${inventory.stockQuantity}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    inventory.price ?? "",
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                ],
              )
            ],
          ),
        ),
        trailing: PopupMenuButton(
          tooltip: '',
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
          icon: const Icon(Icons.more_horiz),
          onSelected: (index) {
            if (index == 1) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      RestoreInventory(inventoryId: inventory.id!));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      DeleteInventory(inventoryId: inventory.id!));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("restore".tr()),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "delete".tr(),
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
