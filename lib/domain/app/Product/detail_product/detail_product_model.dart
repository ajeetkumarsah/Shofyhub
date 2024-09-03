import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/Product/detail_product/product_category_model.dart';
import 'package:alpesportif_seller/domain/app/Product/detail_product/product_image_model.dart';

import 'manufacturer_model.dart';

class DetailProductModel extends Equatable {
  final int id;
  final String slug;
  final String name;
  final String modelNumber;
  final bool status;
  final String gtin;
  final String gtinType;
  final String mpn;
  final String brand;
  final ManufacturerProductModel manufacturer;
  final bool requirementShipping;
  final List<Category> categories;
  final String origin;
  final String listingCount;
  final String description;
  final String availableFrom;
  final List<ProductImageModel> images;
  const DetailProductModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.modelNumber,
    required this.status,
    required this.gtin,
    required this.gtinType,
    required this.mpn,
    required this.brand,
    required this.manufacturer,
    required this.requirementShipping,
    required this.categories,
    required this.origin,
    required this.listingCount,
    required this.description,
    required this.availableFrom,
    required this.images,
  });

  DetailProductModel copyWith({
    int? id,
    String? slug,
    String? name,
    String? modelNumber,
    bool? status,
    String? gtin,
    String? gtinType,
    String? mpn,
    String? brand,
    ManufacturerProductModel? manufacturer,
    bool? requirementShipping,
    List<Category>? categories,
    String? origin,
    String? listingCount,
    String? description,
    String? availableFrom,
    List<ProductImageModel>? images,
  }) {
    return DetailProductModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      modelNumber: modelNumber ?? this.modelNumber,
      status: status ?? this.status,
      gtin: gtin ?? this.gtin,
      gtinType: gtinType ?? this.gtinType,
      mpn: mpn ?? this.mpn,
      brand: brand ?? this.brand,
      manufacturer: manufacturer ?? this.manufacturer,
      requirementShipping: requirementShipping ?? this.requirementShipping,
      categories: categories ?? this.categories,
      origin: origin ?? this.origin,
      listingCount: listingCount ?? this.listingCount,
      description: description ?? this.description,
      availableFrom: availableFrom ?? this.availableFrom,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'model_number': modelNumber,
      'status': status,
      'gtin': gtin,
      'gtin_type': gtinType,
      'mpn': mpn,
      'brand': brand,
      'manufacturer': manufacturer.toMap(),
      'requirement_shipping': requirementShipping,
      'categories': categories.map((x) => x.toMap()).toList(),
      'origin': origin,
      'listing_count': listingCount,
      'description': description,
      'available_from': availableFrom,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory DetailProductModel.fromMap(Map<String, dynamic> map) {
    return DetailProductModel(
      id: map['id']?.toInt() ?? 0,
      slug: map['slug'] ?? '',
      name: map['name'] ?? '',
      modelNumber: map['model_number'] ?? '',
      status: map['status'] ?? false,
      gtin: map['gtin'] ?? '',
      gtinType: map['gtin_type'] ?? '',
      mpn: map['mpn'] ?? '',
      brand: map['brand'] ?? '',
      manufacturer: ManufacturerProductModel.fromMap(map['manufacturer']),
      requirementShipping: map['requirement_shipping'],
      categories: List<Category>.from(
          map['categories']?.map((x) => Category.fromMap(x)) ?? const []),
      origin: map['origin'] ?? '',
      listingCount: map['listing_count'] ?? '',
      description: map['description'] ?? '',
      availableFrom: map['available_from'] ?? '',
      images: List<ProductImageModel>.from(
          map['images']?.map((x) => ProductImageModel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailProductModel.fromJson(String source) =>
      DetailProductModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      slug,
      name,
      modelNumber,
      status,
      gtin,
      gtinType,
      mpn,
      brand,
      manufacturer,
      requirementShipping,
      categories,
      origin,
      listingCount,
      description,
      availableFrom,
      images,
    ];
  }

  factory DetailProductModel.init() => DetailProductModel(
        id: 0,
        slug: '',
        name: '',
        modelNumber: '',
        status: false,
        gtin: '',
        gtinType: '',
        mpn: '',
        brand: '',
        manufacturer: ManufacturerProductModel.init(),
        requirementShipping: false,
        categories: const [],
        origin: '',
        listingCount: '',
        description: '',
        availableFrom: '',
        images: const [],
      );

  @override
  String toString() {
    return 'DetailProductModel(id: $id, slug: $slug, name: $name, modelNumber: $modelNumber, status: $status gtin: $gtin, gtinType: $gtinType, mpn: $mpn, brand: $brand, manufacturer: $manufacturer, requirementShipping: $requirementShipping, categories: $categories, origin: $origin, listingCount: $listingCount, description: $description, availableFrom: $availableFrom, images: $images)';
  }
}
