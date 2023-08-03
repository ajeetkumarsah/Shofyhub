import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/core/config.dart';
import 'package:zcart_seller/models/inventory/inventory_details_model.dart';
import 'package:zcart_seller/models/inventory/inventory_model.dart';
import 'package:zcart_seller/models/product/search_product_model.dart';

final inventoryPageProvider = StateProvider<int>((ref) {
  return 1;
});

// Trash inventory page provider
final trashInventoryPageProvider = StateProvider<int>((ref) {
  return 1;
});

final inventoriesFutureProvider = FutureProvider.autoDispose
    .family<InventoryModel, String>((ref, filter) async {
  const url = "$apiEndpoint/inventories";

  final int page = filter == "active"
      ? ref.watch(inventoryPageProvider)
      : ref.watch(trashInventoryPageProvider);

  final params = {
    'filter': filter,
    'page': page.toString(),
  };

  final authRef = ref.read(authProvider);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url,
      queryParameters: params, options: Options(headers: headers));

  if (response.statusCode == 200) {
    return InventoryModel.fromJson(response.data);
  } else {
    throw Exception('Failed to load data!');
  }
});

// inventory details provider
final inventoryDetailsFutureProvider = FutureProvider.autoDispose
    .family<InventoryDetailsModel, int>((ref, id) async {
  final url = "$apiEndpoint/inventory/$id";

  final authRef = ref.read(authProvider);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };
  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));
  if (response.statusCode == 200) {
    return InventoryDetailsModel.fromJson(response.data);
  } else {
    throw Exception('Failed to load data!');
  }
});

class InventoryProvider {
  static Future<void> addInventory({
    required String apiKey,
    required FormData data,
  }) async {
    const url = "$apiEndpoint/inventory/create";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final dioClient = Dio();
    final response = await dioClient
        .post(url, data: data, options: Options(headers: headers))
        .onError((error, stackTrace) async {
      return Future.error(error.toString());
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to add inventory!');
    }
  }

  static Future<void> addInventoryWithVariants({
    required String apiKey,
    required FormData data,
  }) async {
    const url = "$apiEndpoint/inventory/createWithVariant";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final dioClient = Dio();
    final response = await dioClient
        .post(url, data: data, options: Options(headers: headers))
        .onError((error, stackTrace) async {
      return Future.error(error.toString());
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to add inventory!');
    }
  }

  //Update
  static Future<void> updateInventory({
    required int id,
    required String apiKey,
    required Map<String, dynamic> data,
  }) async {
    final url = "$apiEndpoint/inventory/$id/update";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final dioClient = Dio();
    final response = await dioClient
        .put(
      url,
      queryParameters: data,
      options: Options(headers: headers),
    )
        .onError((error, stackTrace) async {
      return Future.error(error.toString());
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to update inventory!');
    }
  }

  // Quick update
  static Future<void> inventoryQuickUpdate({
    required int id,
    required String apiKey,
    required int active,
    required String title,
    required String salePrice,
    required int stockQuantity,

    // TODO: Expiry date for pharmacy
  }) async {
    final url = "$apiEndpoint/inventory/$id/quick_update";
    final params = {
      'active': active,
      'title': title,
      'sale_price': salePrice,
      'stock_quantity': stockQuantity,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final dioClient = Dio();
    final response = await dioClient.put(
      url,
      queryParameters: params,
      options: Options(headers: headers),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load data!');
    }
  }

  // Trash inventory
  static Future<void> trashItem({
    required int id,
    required String apiKey,
  }) async {
    final url = "$apiEndpoint/inventory/$id/trash";

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final dioClient = Dio();
    final response = await dioClient.delete(
      url,
      options: Options(headers: headers),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to trash data!');
    }
  }

  //restore inventory
  static Future<void> restoreItem({
    required int id,
    required String apiKey,
  }) async {
    final url = "$apiEndpoint/inventory/$id/restore";

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final dioClient = Dio();
    final response = await dioClient.put(
      url,
      options: Options(headers: headers),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to restore data!');
    }
  }

  //delete inventory
  static Future<void> deleteItem({
    required int id,
    required String apiKey,
  }) async {
    final url = "$apiEndpoint/inventory/$id/delete";

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    final dioClient = Dio();
    final response = await dioClient.delete(
      url,
      options: Options(headers: headers),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete data!');
    }
  }
}

// Add Inventory
final searchProductToInventoryProvider =
    FutureProvider.family<List<SearchProductModel>, String>((ref, query) async {
  const url = "$apiEndpoint/search/product";

  final Map<String, String> params = {'q': query};

  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };
  final dioClient = Dio();
  final response = await dioClient.get(url,
      queryParameters: params, options: Options(headers: headers));

  if (response.statusCode == 200) {
    final List<dynamic> data = response.data['data'];
    return data.map((e) => SearchProductModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data!');
  }
});
