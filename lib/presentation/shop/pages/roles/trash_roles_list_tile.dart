import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/domain/app/shop/roles/role_model.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/shop/pages/roles/delete_role_dialog.dart';
import 'package:alpesportif_seller/presentation/shop/pages/roles/restore_role_dialog.dart';

class TrashRoleListTile extends StatelessWidget {
  const TrashRoleListTile({Key? key, required this.role}) : super(key: key);

  final RoleModel role;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.trashColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          role.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
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
                  builder: (context) => RestoreRoleDialog(
                        id: role.id,
                      ));
            }
            if (index2 == 2) {
              showDialog(
                  context: context,
                  builder: (context) => DeleteRoleDialog(
                        id: role.id,
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
            ),
          ],
        ),
      ),
    );
  }
}
