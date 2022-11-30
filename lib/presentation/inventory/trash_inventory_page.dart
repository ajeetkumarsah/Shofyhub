import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/inventory/widgets/trash_inventory_list_tile.dart';

import '../../application/app/stocks/inventories/inventories_provider.dart';

class TrashInventoryPage extends HookConsumerWidget {
  const TrashInventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(stockeInventoryProvider.notifier).getTrashInventories();
      });
      return null;
    }, []);
    final inventoryList = ref
        .watch(stockeInventoryProvider.select((value) => value.trashInventory));
    final loading =
        ref.watch(stockeInventoryProvider.select((value) => value.loading));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return ref
                      .read(stockeInventoryProvider.notifier)
                      .getTrashInventories();
                },
                child: inventoryList.isEmpty
                    ? const NoItemFound()
                    : ListView.separated(
                        itemCount: inventoryList.length,
                        itemBuilder: (context, index) => TrashInventoryItemTile(
                            inventory: inventoryList[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15.h),
                      ),
              ),
      ),
    );
  }
}
