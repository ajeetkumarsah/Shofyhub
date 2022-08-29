import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_vendor/domain/app/catalog/attribute%20values/attribute_values_model.dart';

import 'add_update_attribute_values_dialog.dart';
import 'delete_attribute_value_dialog.dart';

class AttributeValuesTile extends StatelessWidget {
  final AttributeValuesModel atrributeValue;
  final int attributeId;
  const AttributeValuesTile({
    Key? key,
    required this.attributeId,
    required this.atrributeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        atrributeValue.value,
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
                builder: (context) => AddUpdateAttributeValuesDialog(
                      attributeId: attributeId,
                      attributeValues: atrributeValue,
                    ));
          }
          if (index == 2) {
            showDialog(
                context: context,
                builder: (context) => DeleteAttributeValuesDialog(
                      attributeId: attributeId,
                      attributeValueId: atrributeValue.id,
                    ));
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
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              'Color : ${atrributeValue.color}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Expanded(
            child: Text(
              'Order : ${atrributeValue.order}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
