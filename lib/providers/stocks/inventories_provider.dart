import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/core/config.dart';
import 'package:zcart_seller/models/inventory/inventory_details_model.dart';
import 'package:zcart_seller/models/inventory/inventory_model.dart';

final inventoriesFutureProvider =
    FutureProvider.family<InventoryModel, String>((ref, queryJson) async {
  const url = "$apiEndpoint/inventories";
  final Map<String, dynamic> query = jsonDecode(queryJson);

  final String? filter = query['filter'] ?? "active";
  final int? page = query['page'];

  final params = {
    if (filter != null) 'filter': filter,
    if (page != null) 'page': page.toString(),
  };

  final authRef = ref.read(authProvider);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url,
      queryParameters: params, options: Options(headers: headers));

  print(response.data);

  if (response.statusCode == 200) {
    return InventoryModel.fromJson(response.data);
  } else {
    throw Exception('Failed to load data!');
  }
});

// inventory details provider
final inventoryDetailsFutureProvider =
    FutureProvider.family<InventoryDetailsModel, int>((ref, id) async {
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
