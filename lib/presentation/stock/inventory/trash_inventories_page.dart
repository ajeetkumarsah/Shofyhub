import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/trash_inventory_list_tile.dart';
import 'package:zcart_seller/providers/stocks/inventories_provider.dart';

class TrashInventoriesPage extends ConsumerStatefulWidget {
  const TrashInventoriesPage({super.key});

  @override
  ConsumerState<TrashInventoriesPage> createState() =>
      _TrashInventoriesPageState();
}

class _TrashInventoriesPageState extends ConsumerState<TrashInventoriesPage> {
  int? _page;

  @override
  Widget build(BuildContext context) {
    final query = {'page': _page, 'filter': 'trash'};
    final activeInventoriesRef =
        ref.watch(inventoriesFutureProvider(jsonEncode(query)));

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
                    if (currentPage > 1)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _page = currentPage - 1;
                          });
                        },
                        icon: const Icon(Icons.chevron_left),
                      ),
                    Text('$currentPage of $totalPage'),
                    if (currentPage < totalPage)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _page = currentPage + 1;
                          });
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
