import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/edit_manufactuer_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/trash_manufacturer_dialog.dart';

class ManufacturerListTile extends StatelessWidget {
  const ManufacturerListTile({Key? key, required this.manufacturer})
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditManufactuererPage(
                          manufacturerId: manufacturer.id)));
            }
            if (index2 == 2) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      TrashManufactuerDialog(manufactuerId: manufacturer.id));
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
            )
          ],
        ),
      ),
    );
  }
}
