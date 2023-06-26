import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/trash_inventory_list_tile.dart';
import 'package:zcart_seller/providers/stocks/inventories_provider.dart';

class TrashInventoriesPage extends ConsumerWidget {
  const TrashInventoriesPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final activeInventoriesRef = ref.watch(inventoriesFutureProvider("trash"));

    return Scaffold(
      body: activeInventoriesRef.when(data: (data) {
        if ((data.data == null || data.data!.isEmpty)) {
          return const Center(child: Text('No data found'));
        } else {
          int totalPage = data.meta?.lastPage ?? 0;
          int currentPage = data.meta?.currentPage ?? 0;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.data!.length,
                  itemBuilder: (context, index) {
                    final item = data.data![index];

                    return TrashInventoryItemTile(inventory: item);
                  },
                ),
              ),
              const Divider(height: 0),
              if (totalPage > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: currentPage > 1
                          ? () {
                              ref
                                  .read(trashInventoryPageProvider.notifier)
                                  .state = currentPage - 1;
                            }
                          : null,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Text('$currentPage of $totalPage'),
                    IconButton(
                      onPressed: currentPage < totalPage
                          ? () {
                              ref
                                  .read(trashInventoryPageProvider.notifier)
                                  .state = currentPage + 1;
                            }
                          : null,
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
