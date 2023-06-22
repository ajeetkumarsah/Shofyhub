import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/stock/inventory/search_product_to_add_inventory.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/inventory_item_tile.dart';
import 'package:zcart_seller/providers/stocks/inventories_provider.dart';

class ActiveInventoriesPage extends ConsumerWidget {
  const ActiveInventoriesPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final activeInventoriesRef = ref.watch(inventoriesFutureProvider("active"));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SearchProductToAddInventory();
              },
            ),
          );
        },
        label: const Text("Add Inventory"),
        icon: const Icon(Icons.add),
      ),
      body: activeInventoriesRef.when(data: (data) {
        if ((data.data == null || data.data!.isEmpty)) {
          return const Center(child: Text('No data found'));
        } else {
          int totalPage = data.meta?.lastPage ?? 0;
          int currentPage = data.meta?.currentPage ?? 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.data!.length,
                  itemBuilder: (context, index) {
                    final item = data.data![index];

                    return InventoryItemTile(inventory: item);
                  },
                ),
              ),
              const Divider(height: 0),
              if (totalPage > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 24),
                    if (currentPage > 1)
                      IconButton(
                        onPressed: () {
                          ref.read(inventoryPageProvider.notifier).state =
                              currentPage - 1;
                        },
                        icon: const Icon(Icons.chevron_left),
                      ),
                    Text('$currentPage of $totalPage'),
                    if (currentPage < totalPage)
                      IconButton(
                        onPressed: () {
                          ref.read(inventoryPageProvider.notifier).state =
                              currentPage + 1;
                        },
                        icon: const Icon(Icons.chevron_right),
                      ),
                  ],
                ),
            ],
          );
        }
      }, error: (error, stackTrace) {
        print(stackTrace);
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
