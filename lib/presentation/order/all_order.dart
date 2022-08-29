import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/order/order_provider.dart';
import 'package:zcart_vendor/presentation/order/manage_order_page.dart';
import 'package:zcart_vendor/presentation/order/widget/order_conteiner.dart';

class AllOrder extends HookConsumerWidget {
  const AllOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider(null).notifier).getOrders();
      });
      return null;
    }, []);
    final orderList = ref.watch(orderProvider(null)).orderList;
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 60.h,
      //   backgroundColor: MyColor.appbarColor,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(22.r),
      //     ),
      //   ),
      //   title: const Text('All Orders'),
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => const ArcivedOrder()));
      //       },
      //       icon: const Icon(Icons.archive_outlined),
      //     )
      //   ],
      // ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15.0),
        itemCount: orderList.length,
        itemBuilder: (context, index) => OrderContainer(
          buttonName: 'Manage Order',
          orderNumber: orderList[index].orderNumber,
          orderAmount: orderList[index].grandTotal,
          // name: 'Riaz',
          date: orderList[index].orderDate,
          items: orderList[index].itemCount,
          onpress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ManageOrderPage(
                          id: orderList[index].id,
                        )));
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 15.h,
        ),
      ),
    );
  }
}
