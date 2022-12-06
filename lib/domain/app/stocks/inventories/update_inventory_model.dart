import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdateInventoryModel extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String brand;
  final String condition;
  final String conditionNote;
  final String description;
  // final DateTime expiryDate;
  final String keyFeatures;
  final int minOrderQuantity;
  // final double offerPrice;
  // final String offerStart;
  // final String offerEnd;
  final String sku;
  final int quantity;
  final int supplierId;
  final double salePrice;
  final double shippingWeight;
  final int active;
  final int freeShipping;
  const UpdateInventoryModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.brand,
    required this.condition,
    required this.conditionNote,
    required this.description,
    // required this.expiryDate,
    required this.keyFeatures,
    required this.minOrderQuantity,
    // required this.offerPrice,
    // required this.offerStart,
    // required this.offerEnd,
    required this.sku,
    required this.quantity,
    required this.supplierId,
    required this.salePrice,
    required this.shippingWeight,
    required this.active,
    required this.freeShipping,
  });

  UpdateInventoryModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? brand,
    String? condition,
    String? conditionNote,
    String? description,
    // DateTime? expiryDate,
    String? keyFeatures,
    int? minOrderQuantity,
    // double? offerPrice,
    // String? offerStart,
    // String? offerEnd,
    String? sku,
    int? quantity,
    int? supplierId,
    double? salePrice,
    double? shippingWeight,
    int? active,
    int? freeShipping,
  }) {
    return UpdateInventoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      brand: brand ?? this.brand,
      condition: condition ?? this.condition,
      conditionNote: conditionNote ?? this.conditionNote,
      description: description ?? this.description,
      // expiryDate: expiryDate ?? this.expiryDate,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      minOrderQuantity: minOrderQuantity ?? this.minOrderQuantity,
      // offerPrice: offerPrice ?? this.offerPrice,
      // offerStart: offerStart ?? this.offerStart,
      // offerEnd: offerEnd ?? this.offerEnd,
      sku: sku ?? this.sku,
      quantity: quantity ?? this.quantity,
      supplierId: supplierId ?? this.supplierId,
      salePrice: salePrice ?? this.salePrice,
      shippingWeight: shippingWeight ?? this.shippingWeight,
      active: active ?? this.active,
      freeShipping: freeShipping ?? this.freeShipping,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'brand': brand,
      'condition': condition,
      'condition_note': conditionNote,
      'description': description,
      // 'expiray_date': expiryDate,
      'key_features': keyFeatures,
      'min_order_quantity': minOrderQuantity,
      // 'offer_price': offerPrice,
      // 'offer_start': offerStart,
      // 'offer_end': offerEnd,
      'sku': sku,
      'quantity': quantity,
      'supplier_id': supplierId,
      'sale_price': salePrice,
      'shipping_weight': shippingWeight,
      'active': active,
      'free_shipping': freeShipping,
    };
  }

  factory UpdateInventoryModel.fromMap(Map<String, dynamic> map) {
    return UpdateInventoryModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      brand: map['brand'] ?? '',
      condition: map['condition'] ?? '',
      conditionNote: map['title'] ?? '',
      description: map['description'] ?? '',
      // expiryDate: map['expiry_date'] ?? '',
      keyFeatures: map['key_features'] ?? '',
      minOrderQuantity: map['min_order_quantity'] ?? '',
      // offerPrice: map['offer_price'].toDouble() ?? '',
      // offerStart: map['offer_start'] ?? '',
      // offerEnd: map['offer_end'] ?? '',
      sku: map['sku'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      supplierId: map['supplier_id']?.toInt() ?? 0,
      salePrice: map['sale_price'] ?? 0.0,
      shippingWeight: map['shipping_weight'] ?? 0.0,
      active: map['active']?.toInt() ?? 0,
      freeShipping: map['free_shipping']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateInventoryModel.fromJson(String source) =>
      UpdateInventoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateInventoryModel(title: $title, quantity: $quantity, salePrice: $salePrice, active: $active)';
  }

  String get endPoint =>
      'inventory/$id/update?$keyFeatures&active=$active&brand=$brand&condition=$condition&condition_note=$conditionNote&description=$description&free_shipping=$freeShipping&min_order_quantity=$minOrderQuantity&sku=$sku&slug=$slug&stock_quantity=$quantity&sale_price=$salePrice&shipping_weight=$shippingWeight&supplier_id=$supplierId&title=$title';

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      slug,
      brand,
      condition,
      conditionNote,
      description,
      // expiryDate,
      keyFeatures,
      minOrderQuantity,
      // offerPrice,
      // offerStart,
      // offerEnd,
      sku,
      quantity,
      supplierId,
      salePrice,
      shippingWeight,
      active,
      freeShipping,
    ];
  }
}
