import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/trash_attribute_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/edit_attributes_dialog.dart';

class AttributeTile extends StatelessWidget {
  final AtributesModel attribute;

  const AttributeTile({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        // tileColor: Colors.white,
        // leading: Container(
        //   padding: const EdgeInsets.all(10),
        //   height: 80.h,
        //   width: 70.w,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.r),
        //     color: Colors.white70,
        //   ),
        //   child: Image.network(image),
        // ),
        title: Text(
          attribute.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        // trailing: IconButton(
        //   onPressed: onPressed,
        //   icon: const Icon(Icons.create),
        // ),
        subtitle: Row(
          children: [
            Row(
              children: [
                Text('total_entities'.tr()),
                SizedBox(width: 10.h),
                Text(attribute.entitiesCount.toString()),
              ],
            ),
          ],
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
                          EditAttributesDialog(attribute: attribute)));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      TrashAttributeDialog(attributeId: attribute.id));
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text("Edit"),
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
