import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/core/config.dart';
import 'package:zcart_seller/models/form_data/attributes_by_products_model.dart';

final attributesByProductsFormDataProvider =
    FutureProvider.family<Map<String, AttributesByProductModel>, int>(
        (ref, productId) async {
  final url = "$apiEndpoint/data/$productId/product_attributes";

  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));

  if (response.statusCode == 200) {
    return attributesByProductModelFromJson(jsonEncode(response.data));
  } else {
    throw Exception('Failed to load data!');
  }
});

final itemConditionsFormDataProvider =
    FutureProvider<Map<String, String>>((ref) async {
  const url = "$apiEndpoint/data/item_conditions";

  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));

  if (response.statusCode == 200) {
    final jsonData = jsonEncode(response.data);
    return Map<String, String>.from(jsonDecode(jsonData));
  } else {
    throw Exception('Failed to load data!');
  }
});

// Warehouses
final warehousesFormDataProvider =
    FutureProvider<Map<String, String>>((ref) async {
  const url = "$apiEndpoint/data/warehouses";

  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));

  if (response.statusCode == 200) {
    final jsonData = jsonEncode(response.data);
    return Map<String, String>.from(jsonDecode(jsonData));
  } else {
    throw Exception('Failed to load data!');
  }
});

// tag_list
final tagListFormDataProvider =
    FutureProvider<Map<String, String>>((ref) async {
  const url = "$apiEndpoint/data/tag_lists";

  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));

  if (response.statusCode == 200) {
    final jsonData = jsonEncode(response.data);
    return Map<String, String>.from(jsonDecode(jsonData));
  } else {
    throw Exception('Failed to load data!');
  }
});

final suppliersFormDataProvider =
    FutureProvider<Map<String, String>>((ref) async {
  const url = "$apiEndpoint/data/suppliers";

  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));

  if (response.statusCode == 200) {
    final jsonData = jsonEncode(response.data);
    return Map<String, String>.from(jsonDecode(jsonData));
  } else {
    throw Exception('Failed to load data!');
  }
});

// data/linked_items

final linkedItemsFormDataProvider =
    FutureProvider<Map<String, String>>((ref) async {
  const url = "$apiEndpoint/data/linked_items";

  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));

  if (response.statusCode == 200) {
    final jsonData = jsonEncode(response.data);
    return Map<String, String>.from(jsonDecode(jsonData));
  } else {
    throw Exception('Failed to load data!');
  }
});

// data/packagings

final packagingsFormDataProvider =
    FutureProvider<Map<String, String>>((ref) async {
  const url = "$apiEndpoint/data/packagings";
  final authRef = ref.read(authProvider);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${authRef.user.api_token}'
  };

  final dioClient = Dio();
  final response = await dioClient.get(url, options: Options(headers: headers));

  if (response.statusCode == 200) {
    final jsonData = jsonEncode(response.data);
    return Map<String, String>.from(jsonDecode(jsonData));
  } else {
    throw Exception('Failed to load data!');
  }
});
