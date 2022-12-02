import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/order/order_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/widget_for_all/zcart_appbar.dart';

import 'widget/archived_order_tile.dart';

class ArchivedOrderListPage extends HookConsumerWidget {
  const ArchivedOrderListPage({
    Key? key,
    this.showAppBar = true,
  }) : super(key: key);

  final bool showAppBar;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider.notifier).getArchivedOrders();
      });
      return null;
    }, []);
    final buttonPressed = useState(false);
    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() &&
            next.orderList != previous?.orderList &&
            buttonPressed.value) {
          NotificationHelper.success(message: 'successfully_unarchived'.tr());

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          next.failure.showDialogue(context);
        }
      }
    });

    final orderList = ref.watch(orderProvider).archivedOrderList;
    return Scaffold(
      appBar: showAppBar ? const ZcartAppBar(title: 'Archived orders') : null,
      backgroundColor: const Color(0xffEFEFEF),
      body: orderList.isEmpty
          ? const NoItemFound()
          : ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: orderList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 20,
                color: Color(0xffEFEFEF),
              ),
              itemBuilder: (context, index) {
                final order = orderList[index];
                return ArchivedOrderTile(
                  order: order,
                  unArchive: () {
                    ref
                        .read(orderProvider.notifier)
                        .unarchiveOrder(orderList[index].id);
                    buttonPressed.value = true;
                  },
                );
              },
            ),
    );
  }
}
