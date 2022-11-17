import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/shop/taxes/tax_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/texes/widgets/delete_tax_dialog.dart';
import 'package:zcart_seller/presentation/shop/pages/texes/widgets/restore_tax_dialog.dart';

class TrashTaxListTile extends StatelessWidget {
  final TaxModel taxItem;
  const TrashTaxListTile({Key? key, required this.taxItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.trashColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          taxItem.name,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Region : ${taxItem.country.name}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              'Tax Rate : ${taxItem.taxrate}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
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
              showDialog(
                  context: context,
                  builder: (context) => RestoreTaxDialog(
                        id: taxItem.id,
                      ));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) => DeleteTaxDialog(id: taxItem.id));
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
