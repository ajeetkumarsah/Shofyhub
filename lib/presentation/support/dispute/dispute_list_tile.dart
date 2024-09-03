import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/domain/app/order%20management/dispute/dispute_mode.dart';
import 'package:alpesportif_seller/presentation/support/dispute/dispute_details_page.dart';
import 'package:alpesportif_seller/presentation/support/dispute/dispute_response_dialog.dart';

class DisputeListTile extends StatelessWidget {
  const DisputeListTile({Key? key, required this.dispute}) : super(key: key);

  final DisputeModel dispute;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DisputeDetailsPage(disputeId: dispute.id)));
        },
        contentPadding: const EdgeInsets.all(10),
        tileColor: Colors.white,
        title: Text(
          "Customer: ${dispute.customer.name}",
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reason: ${dispute.reason}',
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount: ${dispute.refundAmount}',
                ),
                Text(
                  'Response: ${dispute.replies.length}',
                ),
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
          onSelected: (index2) {
            if (index2 == 1) {
              showDialog(
                  context: context,
                  builder: (context) => DisputeResponseDialog(
                        disputeId: dispute.id,
                      ));
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text("Response"),
            ),
          ],
        ),
      ),
    );
  }
}
