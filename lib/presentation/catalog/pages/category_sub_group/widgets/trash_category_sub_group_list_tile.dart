import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/category_sub_group_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/category_list_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/category/category_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_group/widget/restore_category_group_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/widgets/delete_category_sub_group_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/widgets/restore_category_sub_group_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/widgets/trash_category_sub_group_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/widgets/edit_category_sub_group_dialog.dart';

class TrashCategorySubgroupListTile extends StatelessWidget {
  final CategorySubGroupModel categorySubGroup;
  final int categoryGroupId;
  const TrashCategorySubgroupListTile({
    Key? key,
    required this.categoryGroupId,
    required this.categorySubGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryPage(
                  categorySubGroupId: categorySubGroup.id,
                  subGroupName: categorySubGroup.name)));
        },
        title: Text(
          categorySubGroup.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
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
                  builder: (context) => RestoreCategorySubGroupDialog(
                        id: categoryGroupId,
                      ));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) => DeleteCategorySubGroupDialog(
                        id: categoryGroupId,
                      ));
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
        subtitle: Row(
          children: [
            Text(
                'Total Category: ${categorySubGroup.categoriesCount.toString()}'),
            const SizedBox(
              width: 10,
            ),
            !categorySubGroup.active
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
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
