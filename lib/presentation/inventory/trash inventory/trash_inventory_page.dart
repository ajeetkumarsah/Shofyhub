import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/inventory/trash%20inventory/widgets/delete_inventory_dialog.dart';
import 'package:zcart_seller/presentation/inventory/trash%20inventory/widgets/restore_inventory.dart';
import 'package:zcart_seller/presentation/inventory/trash%20inventory/widgets/trash_inventory_list_tile.dart';

import '../../../application/app/stocks/inventories/inventories_provider.dart';

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
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 60.h,
      //   backgroundColor: Constants.appbarColor,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(22.r),
      //     ),
      //   ),
      //   title: const Text('Inventory'),
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Container(
            //   height: 45.h,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade300,
            //     borderRadius: BorderRadius.circular(15.r),
            //   ),
            //   child: const TextField(
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.search),
            //       border: OutlineInputBorder(borderSide: BorderSide.none),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 15.h),
            Expanded(
              child: ListView.separated(
                itemCount: inventoryList.length,
                itemBuilder: (context, index) => TrashInventoryItemTile(
                    deleteInventory: () {
                      showDialog(
                          context: context,
                          builder: (context) => DeleteInventory(
                              inventoryId: inventoryList[index].id));
                    },
                    restore: () {
                      showDialog(
                          context: context,
                          builder: (context) => RestoreInventory(
                              inventoryId: inventoryList[index].id));
                    },
                    sku: inventoryList[index].sku,
                    title: inventoryList[index].title,
                    price: inventoryList[index].price,
                    quantity: inventoryList[index].stockQuantity,
                    condition: inventoryList[index].condition,
                    image: inventoryList[index].image),
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
