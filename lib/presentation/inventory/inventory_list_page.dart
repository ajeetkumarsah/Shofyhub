import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details_page.dart';
import 'package:zcart_seller/presentation/inventory/widgets/inventory_item_tile.dart';

class InventoryListPage extends HookConsumerWidget {
  const InventoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref
                .read(stockeInventoryProvider.notifier)
                .getMoreInventories(inventoryFilter: 'null');
          }
        },
      );
      // Future.delayed(const Duration(milliseconds: 100), () async {
      //   ref
      //       .read(stockeInventoryProvider.notifier)
      //       .getAllInventories(inventoryFilter: 'active');
      // });
      return null;
    }, []);

    final totalInventoryList =
        ref.watch(stockeInventoryProvider).allInventories;

    final loading =
        ref.watch(stockeInventoryProvider.select((value) => value.loading));

    var inventoryList = totalInventoryList;

    final inventoryPaginationModel =
        ref.watch(stockeInventoryProvider.notifier).inventoryPaginationModel;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // Container(
                  //   height: 45.h,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade300,
                  //     borderRadius: BorderRadius.circular(15.r),
                  //   ),
                  //   child: Center(
                  //     child: TextField(
                  //       onChanged: (value) {
                  //         inventoryList = totalInventoryList
                  //             .where((element) => element.title
                  //                 .toLowerCase()
                  //                 .contains(value.toLowerCase()))
                  //             .toList();
                  //       },
                  //       controller: searchController,
                  //       decoration: const InputDecoration(
                  //         prefixIcon: Icon(Icons.search),
                  //         border:
                  //             OutlineInputBorder(borderSide: BorderSide.none),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10.h),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return ref
                            .read(stockeInventoryProvider.notifier)
                            .getAllInventories(inventoryFilter: 'null');
                      },
                      child: inventoryList.isEmpty
                          ? const NoItemFound()
                          : ListView.separated(
                              controller: scrollController,
                              itemCount: inventoryList.length,
                              itemBuilder: (context, index) {
                                if ((index == inventoryList.length - 1) &&
                                    inventoryList.length <
                                        inventoryPaginationModel.meta.total!) {
                                  return const SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                InventoryDetailsPage(
                                                  id: inventoryList[index].id,
                                                )));
                                  },
                                  child: InventoryItemTile(
                                      inventory: inventoryList[index]),
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
