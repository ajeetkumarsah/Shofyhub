import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/delete_attribute_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/restore_attribute_dialog.dart';

class TrashAttributeTile extends StatelessWidget {
  final AtributesModel attribute;

  const TrashAttributeTile({Key? key, required this.attribute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.trashColor,
      child: ListTile(
        title: Text(
          attribute.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          'Type : ${attribute.attributeType}',
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
                      builder: (context) =>
                          RestoreAttributeDialog(id: attribute.id)));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      DeleteAttributeDialog(id: attribute.id));
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
