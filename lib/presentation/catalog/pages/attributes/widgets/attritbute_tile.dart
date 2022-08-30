import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/delete_attribute_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/edit_attributes_dialog.dart';

class AttributeTile extends StatelessWidget {
  final AtributesModel attribute;

  const AttributeTile({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
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
      subtitle: Text(
        'Attribute Type : ${attribute.attributeType}',
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
                        EditAttributesDialog(attribute: attribute)));
          }
          if (index == 2) {
            showDialog(
                context: context,
                builder: (context) =>
                    DeleteAttributeDialog(attributeId: attribute.id));
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
