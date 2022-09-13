import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/refunds/refund_provider.dart';

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: refundList.length,
              itemBuilder: (context, index) => ListTile(
                tileColor: Colors.white,
                title: Text(
                  "Order Id: ${refundList[index].orderId}",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                subtitle: Text(
                  'Amount: ${refundList[index].amount}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
