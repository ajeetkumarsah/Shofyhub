import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/inventory_details_page.dart';
import 'package:zcart_seller/presentation/inventory/widgets/trash_inventory.dart';
import 'package:zcart_seller/presentation/inventory/widgets/inventory_item_tile.dart';
import 'package:zcart_seller/presentation/inventory/widgets/quick_update_inventory_dialog.dart';

class InventoryPage extends HookConsumerWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final totalInventoryList = ref
        .watch(stockeInventoryProvider.select((value) => value.allInventories));
    final searchController = useTextEditingController();
    final inventoryList = useState(totalInventoryList);

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
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (_) => const TrashInventoryPage()));
      //       },
      //       icon: const Icon(Icons.delete_outline),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: TextField(
                onChanged: (value) {
                  inventoryList.value = totalInventoryList
                      .where((element) => element.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                },
                controller: searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView.separated(
                itemCount: inventoryList.value.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => InventoryDetailsPage(
                                  id: inventoryList.value[index].id,
                                )));
                  },
                  child: InventoryItemTile(
                      deleteInventory: () {
                        showDialog(
                            context: context,
                            builder: (context) => TrashInventory(
                                inventoryId: inventoryList.value[index].id));
                      },
                      quickUpdate: () {
                        showDialog(
                            context: context,
                            builder: (context) => QuickUpdateInventoryDialog(
                                inventoryInfo: inventoryList.value[index]));
                      },
                      sku: inventoryList.value[index].sku,
                      title: inventoryList.value[index].title,
                      price: inventoryList.value[index].price,
                      quantity: inventoryList.value[index].stockQuantity,
                      condition: inventoryList.value[index].condition,
                      image: inventoryList.value[index].image),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
