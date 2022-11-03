import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/delete_manufacturer_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/restore_manufacturer_dialog.dart';

class TrashManufacturerListTile extends StatelessWidget {
  const TrashManufacturerListTile({Key? key, required this.manufacturer})
      : super(key: key);

  final ManufacturerModel manufacturer;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(manufacturer.image),
        ),
        isThreeLine: true,
        title: Text(
          manufacturer.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        subtitle: Text('available: ${manufacturer.availableFrom}'),
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
                  builder: (context) => RestoreManufacturerDialog(
                        manufactuerId: manufacturer.id,
                      ));
            }
            if (index2 == 2) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      DeleteManufacturerDialog(manufacturer.id));
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
