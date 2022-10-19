import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_model.dart';
import 'package:zcart_seller/presentation/stock/suppliers/edit_supplier_page.dart';
import 'package:zcart_seller/presentation/stock/suppliers/supplier_details_page.dart';
import 'package:zcart_seller/presentation/stock/suppliers/widgets/trash_supplier_dialog.dart';

class SupplierListTile extends StatelessWidget {
  final SupplierModel supplierItem;
  const SupplierListTile({Key? key, required this.supplierItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SupplierDetailsPage(supplierId: supplierItem.id!),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      EditSupplierPage(supplierId: supplierItem.id!),
                ),
              );
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) => TrashSupplierDialog(supplierItem.id!));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("edit".tr()),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "trash".tr(),
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
