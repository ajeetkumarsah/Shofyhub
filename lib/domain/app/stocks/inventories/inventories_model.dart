import 'dart:convert';

import 'package:equatable/equatable.dart';

class InventoriesModel extends Equatable {
  final int id;
  final String sku;
  final String title;
  final String condition;
  final int stockQuantity;
  final String price;
  final bool hasOffer;
  final String offerPrice;
  final bool freeShipping;
  final bool active;
  final String image;
  const InventoriesModel({
    required this.id,
    required this.sku,
    required this.title,
    required this.condition,
    required this.stockQuantity,
    required this.price,
    required this.hasOffer,
    required this.offerPrice,
    required this.freeShipping,
    required this.active,
    required this.image,
  });

  InventoriesModel copyWith({
    int? id,
    String? sku,
    String? title,
    String? condition,
    int? stockQuantity,
    String? price,
    bool? hasOffer,
    String? offerPrice,
    bool? freeShipping,
    bool? active,
    String? image,
  }) {
    return InventoriesModel(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      title: title ?? this.title,
      condition: condition ?? this.condition,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      price: price ?? this.price,
      hasOffer: hasOffer ?? this.hasOffer,
      offerPrice: offerPrice ?? this.offerPrice,
      freeShipping: freeShipping ?? this.freeShipping,
      active: active ?? this.active,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sku': sku,
      'title': title,
      'condition': condition,
      'stock_quantity': stockQuantity,
      'price': price,
      'has_offer': hasOffer,
      'offer_price': offerPrice,
      'free_shipping': freeShipping,
      'active': active,
      'image': image,
    };
  }

  factory InventoriesModel.fromMap(Map<String, dynamic> map) {
    return InventoriesModel(
      id: map['id']?.toInt() ?? 0,
      sku: map['sku'] ?? '',
      title: map['title'] ?? '',
      condition: map['condition'] ?? '',
      stockQuantity: map['stock_quantity']?.toInt() ?? 0,
      price: map['price'] ?? '',
      hasOffer: map['has_offer'] ?? false,
      offerPrice: map['offer_price'] ?? '',
      freeShipping: map['free_shipping'] ?? false,
      active: map['active'] ?? false,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoriesModel.fromJson(String source) =>
      InventoriesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoriesModel(id: $id, sku: $sku, title: $title, condition: $condition, stockQuantity: $stockQuantity, price: $price, hasOffer: $hasOffer, offerPrice: $offerPrice, freeShipping: $freeShipping, active: $active, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      id,
      sku,
      title,
      condition,
      stockQuantity,
      price,
      hasOffer,
      offerPrice,
      freeShipping,
      active,
      image,
    ];
  }

  factory InventoriesModel.init() => const InventoriesModel(
        id: 0,
        sku: '',
        title: '',
        condition: '',
        stockQuantity: 0,
        price: '',
        hasOffer: false,
        offerPrice: '',
        freeShipping: false,
        active: false,
        image: '',
      );
}
