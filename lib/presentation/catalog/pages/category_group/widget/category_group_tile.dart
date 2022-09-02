// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:zcart_seller/domain/app/category/category%20group/category_group_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_group/widget/delete_category_group_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_group/widget/edit_category_group_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/category_sub_group_page.dart';

class CategoryGroupTile extends StatelessWidget {
  final CategoryGroupModel categoryGroup;

  const CategoryGroupTile({
    Key? key,
    required this.categoryGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategorySubgroupPage(
                groupName: categoryGroup.name, id: categoryGroup.id)));
      },
      tileColor: Colors.white,
      leading: categoryGroup.coverImage.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(10),
              height: 120.h,
              width: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white70,
              ),
              child: Image.network(categoryGroup.coverImage),
            ),
      title: Text(
        categoryGroup.name,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
      ),
      // trailing: IconButton(
      //   onPressed: onPressed,
      //   icon: const Icon(Icons.create),
      // ),
      subtitle: Text(
        'Slug: ${categoryGroup.slug}',
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
                builder: (context) =>
                    EditCategoryGroupDialog(categoryGroupId: categoryGroup.id));
          }
          if (index == 2) {
            showDialog(
                context: context,
                builder: (context) => DeleteCategoryGroupDialog(
                    categoryGroupId: categoryGroup.id));
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
