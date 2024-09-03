import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/domain/app/order%20management/cancellation/cancellation_model.dart';
import 'package:alpesportif_seller/presentation/support/cancellation/approve_cancellation_dialog.dart';
import 'package:alpesportif_seller/presentation/support/cancellation/decline_cancellation_dialog.dart';

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
          "Customer Id: ${cancellation.customerId}",
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
              'Description: ${cancellation.description}',
            ),
            SizedBox(height: 5.h),
            cancellation.status == 3
                ? const Text(
                    'Approved',
                    style: TextStyle(color: Colors.green),
                  )
                : const Text(
                    'Declined',
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
        trailing: PopupMenuButton(
          tooltip: '',
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
          icon: const Icon(Icons.more_horiz),
          onSelected: (index2) {
            if (cancellation.status == 4) {
              showDialog(
                  context: context,
                  builder: (context) => ApproveCancellationDialog(
                        id: cancellation.orderId,
                      ));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => DeclineCancellationDialog(
                        id: cancellation.orderId,
                      ));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: cancellation.status == 4
                  ? Text("approve".tr())
                  : Text(
                      "decline".tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
