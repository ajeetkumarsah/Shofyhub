import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_provider.dart';
import 'package:zcart_seller/presentation/stock/warehouse/widgets/trash_warehouse_list_tile.dart';

class TrashWarehousePage extends HookConsumerWidget {
  const TrashWarehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(warehouseProvider.notifier).getMoreTrashWarehouses();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(warehouseProvider.notifier).getTrashWarehouses();
      });
      return null;
    }, []);
    final loading =
        ref.watch(warehouseProvider.select((value) => value.loading));

    final warehousePaginationModel =
        ref.watch(warehouseProvider.notifier).warehousePaginationModel;

    final warehouseList = ref.watch(warehouseProvider).trashWarehouses;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return ref
                            .read(warehouseProvider.notifier)
                            .getTrashWarehouses();
                      },
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: warehouseList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if ((index == warehouseList.length - 1) &&
                              warehouseList.length <
                                  warehousePaginationModel.meta.total!) {
                            return const SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return TrashWarehouseListTile(
                            warehouseItem: warehouseList[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 3.h),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
