import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/order%20management/cancellation/cancellation_model.dart';
import 'package:zcart_seller/presentation/support/cancellation/approve_cancellation_dialog.dart';
import 'package:zcart_seller/presentation/support/cancellation/decline_cancellation_dialog.dart';

class CancellationListTile extends StatelessWidget {
  const CancellationListTile({Key? key, required this.cancellation})
      : super(key: key);

  final CancellationModel cancellation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        tileColor: Colors.white,
        title: Text(
          "Id: ${cancellation.id}",
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          'Name: ${cancellation.name}',
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
                  builder: (context) => ApproveCancellationDialog(
                        id: cancellation.id,
                      ));
            }
            if (index2 == 2) {
              showDialog(
                  context: context,
                  builder: (context) => DeclineCancellationDialog(
                        id: cancellation.id,
                      ));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("approve".tr()),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "decline".tr(),
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
