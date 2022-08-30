import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/inventory_details_page.dart';
import 'package:zcart_seller/presentation/inventory/widgets/inventory_item_tile.dart';
import 'package:zcart_seller/presentation/inventory/widgets/quick_update_inventory_dialog.dart';
import 'package:zcart_seller/presentation/widget_for_all/color.dart';

class InventoryPage extends HookConsumerWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final inventoryList =
        ref.watch(inventoryProvider.select((value) => value.allInventories));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Inventory'),
        elevation: 0,
      ),
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
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView.separated(
                itemCount: inventoryList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => InventoryDetailsPage(
                                  id: inventoryList[index].id,
                                )));
                  },
                  child: InventoryItemTile(
                      quickUpdate: () {
                        showDialog(
                            context: context,
                            builder: (context) => QuickUpdateInventoryDialog(
                                inventoryInfo: inventoryList[index]));
                      },
                      sku: inventoryList[index].sku,
                      title: inventoryList[index].title,
                      price: inventoryList[index].price,
                      quantity: inventoryList[index].stockQuantity,
                      condition: inventoryList[index].condition,
                      image: inventoryList[index].image),
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
