import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/domain/app/stocks/warehouse/warehouse_model.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/stock/warehouse/warehouse_details_page.dart';
import 'package:alpesportif_seller/presentation/stock/warehouse/widgets/delete_warehouse_dialog.dart';
import 'package:alpesportif_seller/presentation/stock/warehouse/widgets/restore_warehouse_dialog.dart';

class TrashWarehouseListTile extends StatelessWidget {
  final WarehouseModel warehouseItem;
  const TrashWarehouseListTile({Key? key, required this.warehouseItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.trashColor,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  WarehouseDetailsPage(warehouseId: warehouseItem.id),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          height: 80.h,
          width: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white70,
          ),
          child: Image.network(warehouseItem.image),
        ),
        title: Text(
          warehouseItem.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          'Email : ${warehouseItem.email}',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
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
                  builder: (context) => RestoreWarehouseDialog(
                        warehouseId: warehouseItem.id,
                      ));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      DeleteWarehouseDialog(warehouseItem.id));
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
