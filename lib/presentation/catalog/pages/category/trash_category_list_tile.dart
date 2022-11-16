import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/widget/delete_category_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/widget/restore_category_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/widget/trash_category_dialog.dart';

import 'widget/edit_category_dialog.dart';

class TrashCategoryListTile extends StatelessWidget {
  final CategoryModel category;
  const TrashCategoryListTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.all(10),
          height: 80.h,
          width: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white70,
          ),
          child: Image.network(category.coverImage),
        ),
        title: Text(
          category.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        subtitle: !category.active
            ? Text(
                'Inactive',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red.shade800,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            : null,
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
                  builder: (context) => RestoreCategoryDialog(
                        id: category.id,
                      ));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) => DeleteCategoryDialog(id: category.id));
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
