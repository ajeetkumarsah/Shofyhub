import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/order/order_provider.dart';
import 'package:alpesportif_seller/application/app/order/order_state.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:alpesportif_seller/presentation/order/widget/order_tile.dart';

class UnFullFilledOrderListPage extends HookConsumerWidget {
  const UnFullFilledOrderListPage({
    Key? key,
    this.showAppBar = true,
  }) : super(key: key);

  final bool showAppBar;

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(orderProvider.notifier).getMoreUnFullFilledOrders();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider.notifier).getUnFullFilledOrders();
      });
      return null;
    }, []);
    final buttonPressed = useState(false);
    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() &&
            next.orderList != previous?.orderList &&
            buttonPressed.value) {
          NotificationHelper.success(message: 'successfully_archived'.tr());

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          next.failure.showDialogue(context);
        }
      }
    });
    final orderPaginationModel =
        ref.watch(orderProvider.notifier).unFulfilledOrderPaginationModel;

    final orderList = ref.watch(orderProvider).unFulfillOrderList;
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: orderList.isEmpty
          ? const NoItemFound()
          : ListView.separated(
              controller: scrollController,
              padding: const EdgeInsets.all(15),
              itemCount: orderList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 20,
                color: Color(0xffEFEFEF),
              ),
              itemBuilder: (context, index) {
                if ((index == orderList.length - 1) &&
                    orderList.length < orderPaginationModel.meta.total!) {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final order = orderList[index];
                return OrderTile(
                  order: order,
                  isFullfilled: true,
                );
              },
            ),
    );
  }
}
