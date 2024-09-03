import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/presentation/stock/inventory/add_inventory/add_inventory_page.dart';
import 'package:alpesportif_seller/presentation/stock/inventory/add_inventory/create_variants_page.dart';
import 'package:alpesportif_seller/providers/stocks/inventories_provider.dart';

class SearchProductToAddInventory extends ConsumerStatefulWidget {
  const SearchProductToAddInventory({super.key});

  @override
  ConsumerState<SearchProductToAddInventory> createState() =>
      _SearchProductToAddInventoryState();
}

class _SearchProductToAddInventoryState
    extends ConsumerState<SearchProductToAddInventory> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? searchQuery;
    if (_searchController.text.isNotEmpty &&
        _searchController.text.length > 2) {
      searchQuery = _searchController.text;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Search Product')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Product Name, GTIN or Model Number',
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: searchQuery != null
          //       ? const Center(child: Text('Search result'))
          //       : const Center(child: Text('No data found')),
          // ),
          if (searchQuery != null)
            Expanded(
              child: Builder(
                builder: (context) {
                  final searchProductRef =
                      ref.watch(searchProductToInventoryProvider(searchQuery!));

                  return searchProductRef.when(
                    data: (data) {
                      return data.isEmpty
                          ? const Center(child: Text('No data found'))
                          : ListView.separated(
                              itemCount: data.length,
                              separatorBuilder: (context, index) {
                                return const Divider(height: 0);
                              },
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(item.name ?? ''),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${item.gtinType ?? ''} : ${item.gtin ?? ''}",
                                      ),
                                      // Model
                                      Text(
                                        "Model: ${item.modelNumber ?? ''}",
                                      ),
                                      // Brand
                                      Text(
                                        "Brand: ${item.brand ?? ''}",
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return AddInventoryPage(
                                                      product: item,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child:
                                                const Text("Add to Inventory"),
                                          ),
                                          const SizedBox(width: 8),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 4,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return CreateVariantsPage(
                                                      product: item,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Add to Inventory\nwith Variant",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      item.image ?? '',
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                    error: (error, stackTrace) {
                      return const Center(child: Text('No data found'));
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            )
          else
            const Expanded(
              child: Center(child: Text('No data found')),
            ),
        ],
      ),
    );
  }
}
