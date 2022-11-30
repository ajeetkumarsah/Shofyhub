import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/refunds/refund_provider.dart';
import 'package:zcart_seller/presentation/core/widgets/loading_widget.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/support/refund/approve_refund_dialog.dart';
import 'package:zcart_seller/presentation/support/refund/decline_refund_dailog.dart';

class CloseRefundPage extends HookConsumerWidget {
  const CloseRefundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(refundProvider.notifier).getClosedRefunds();
      });
      return null;
    }, []);

    final refundList =
        ref.watch(refundProvider.select((value) => value.closedRefunds));

    final loading = ref.watch(refundProvider.select((value) => value.loading));

    return Scaffold(
      body: loading
          ? const LoadingWidget()
          : refundList.isEmpty
              ? const NoItemFound()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemCount: refundList.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text(
                              "Order Id: ${refundList[index].orderId}",
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
                                  'Amount: ${refundList[index].amount}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(
                                  'Status: ${refundList[index].status == 1 ? 'Open' : 'Closed'}',
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp)),
                              icon: const Icon(Icons.more_horiz),
                              onSelected: (index2) {
                                if (index2 == 1) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ApproveRefundDialog(
                                            refundId: refundList[index].id,
                                          ));
                                }
                                if (index2 == 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => DeclineRefundDialog(
                                            refundId: refundList[index].id,
                                          ));
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 1,
                                  child: Text("Approve"),
                                ),
                                const PopupMenuItem(
                                  value: 2,
                                  child: Text(
                                    "Decline",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 3.h,
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
