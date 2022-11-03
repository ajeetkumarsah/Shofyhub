import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/dashboard/dashboard_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/order/widget/order_tile.dart';

class LatesOrderListPage extends HookConsumerWidget {
  const LatesOrderListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(dashboardProvider.notifier).getLatestOrders();
      });
      return null;
    }, []);
    final buttonPressed = useState(false);
    ref.listen<OrderState>(orderProvider(OrderFilter.archived),
        (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() &&
            next.orderList != previous?.orderList &&
            buttonPressed.value) {
          NotificationHelper.info(message: 'successfully_unarchived'.tr());

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          next.failure.showDialogue(context);
        }
      }
    });

    final orderList =
        ref.watch(dashboardProvider.select((value) => value.latestOrders));
    final loading =
        ref.watch(dashboardProvider.select((value) => value.loading));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest orders'),
        backgroundColor: Constants.appbarColor,
      ),
      backgroundColor: const Color(0xffEFEFEF),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 15)
                  .r,
              itemCount: orderList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 20,
                color: Color(0xffEFEFEF),
              ),
              itemBuilder: (context, index) {
                final order = orderList[index];
                return OrderTile(
                  order: order,
                );
              },
            ),
    );
  }
}
