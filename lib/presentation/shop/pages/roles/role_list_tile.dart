import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/shop/roles/role_model.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/trash_role_dialog.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/update_role_page.dart';

class RoleListTile extends StatelessWidget {
  const RoleListTile({Key? key, required this.role}) : super(key: key);

  final RoleModel role;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        tileColor: Colors.white,
        title: Text(
          role.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        // subtitle: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       role.description,
        //     ),
        //     SizedBox(height: 5.h),
        //     Text(
        //       role.level.toString(),
        //     ),
        //   ],
        // ),
        trailing: PopupMenuButton(
          tooltip: '',
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
          icon: const Icon(Icons.more_horiz),
          onSelected: (index2) {
            if (index2 == 1) {
              showDialog(
                  context: context,
                  builder: (context) => UpdateRolePage(
                        roleId: role.id,
                      ));
            }
            if (index2 == 2) {
              showDialog(
                  context: context,
                  builder: (context) => TrashRoleDialog(
                        roleId: role.id,
                      ));
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
            ),
          ],
        ),
      ),
    );
  }
}
