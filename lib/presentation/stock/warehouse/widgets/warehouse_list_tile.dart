import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';

class WarehouseListTile extends StatelessWidget {
  final WarehouseModel warehouseItem;
  const WarehouseListTile({Key? key, required this.warehouseItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
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
            // showDialog(
            //     context: context,
            //     builder: (context) => EditCategoryDialog(
            //           categoryId: category.id,
            //         ));
          }
          if (index == 2) {
            // showDialog(
            //     context: context,
            //     builder: (context) => DeleteCategoryDialog(category.id));
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text("Edit"),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
