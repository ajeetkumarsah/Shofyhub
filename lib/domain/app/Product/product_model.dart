import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String slug;
  final String name;
  final String modelNumber;
  final String gtin;
  final String gtinType;
  final String mpn;
  final String brand;
  final String availableFrom;
  final String image;
  const ProductModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.modelNumber,
    required this.gtin,
    required this.gtinType,
    required this.mpn,
    required this.brand,
    required this.availableFrom,
    required this.image,
  });

  ProductModel copyWith({
    int? id,
    String? slug,
    String? name,
    String? modelNumber,
    String? gtin,
    String? gtinType,
    String? mpn,
    String? brand,
    String? availableFrom,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      modelNumber: modelNumber ?? this.modelNumber,
      gtin: gtin ?? this.gtin,
      gtinType: gtinType ?? this.gtinType,
      mpn: mpn ?? this.mpn,
      brand: brand ?? this.brand,
      availableFrom: availableFrom ?? this.availableFrom,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'model_number': modelNumber,
      'gtin': gtin,
      'gtin_type': gtinType,
      'mpn': mpn,
      'brand': brand,
      'available_from': availableFrom,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      slug: map['slug'] ?? '',
      name: map['name'] ?? '',
      modelNumber: map['model_number'] ?? '',
      gtin: map['gtin'] ?? '',
      gtinType: map['gtin_type'] ?? '',
      mpn: map['mpn'] ?? '',
      brand: map['brand'] ?? '',
      availableFrom: map['available_from'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, slug: $slug, name: $name, modelNumber: $modelNumber, gtin: $gtin, gtinType: $gtinType, mpn: $mpn, brand: $brand, availableFrom: $availableFrom, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      id,
      slug,
      name,
      modelNumber,
      gtin,
      gtinType,
      mpn,
      brand,
      availableFrom,
      image,
    ];
  }
}
