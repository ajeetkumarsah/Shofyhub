import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/domain/app/stocks/supplier/supplier_model.dart';
import 'package:alpesportif_seller/presentation/stock/suppliers/widgets/delete_supplier_dialog.dart';
import 'package:alpesportif_seller/presentation/stock/suppliers/widgets/restore_supplier_dialog.dart';

class TrashSupplierListTile extends StatelessWidget {
  final SupplierModel supplierItem;
  const TrashSupplierListTile({Key? key, required this.supplierItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          height: 80.h,
          width: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white70,
          ),
          child: Image.network(supplierItem.image.toString()),
        ),
        title: Text(
          supplierItem.name ?? '',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          'Email : ${supplierItem.email}',
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
                  builder: (context) => RestoreSupplierDialog(
                        supplierId: supplierItem.id!,
                      ));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) => DeleteSupplierDialog(supplierItem.id!));
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
