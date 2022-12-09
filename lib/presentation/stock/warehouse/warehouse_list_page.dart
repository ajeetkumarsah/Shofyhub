import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/stock/warehouse/create_warehouse_page.dart';
import 'package:zcart_seller/presentation/stock/warehouse/widgets/warehouse_list_tile.dart';

class WarehouseListPage extends HookConsumerWidget {
  const WarehouseListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(warehouseProvider.notifier).getMoreWarehouseItems();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(warehouseProvider.notifier).getWarehouseItems();
      });
      return null;
    }, []);

    final warehousePaginationModel =
        ref.watch(warehouseProvider.notifier).warehousePaginationModel;

    final loading =
        ref.watch(warehouseProvider.select((value) => value.loading));

    final warehouseList = ref.watch(warehouseProvider).warehouseItemList;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateWarehousePage()));
        },
        label: Text('add_warehouse'.tr()),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : warehouseList.isEmpty
              ? const NoItemFound()
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .read(warehouseProvider.notifier)
                        .getWarehouseItems();
                  },
                  child: warehouseList.isEmpty
                      ? Center(child: Text('no_item_found'.tr()))
                      : ListView.separated(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemCount: warehouseList.length,
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
                            return InkWell(
                              child: WarehouseListTile(
                                warehouseItem: warehouseList[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 3.h,
                          ),
                        ),
                ),
    );
  }
}
