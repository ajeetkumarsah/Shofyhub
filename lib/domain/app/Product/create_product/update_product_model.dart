// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdateProductModel extends Equatable {
  final int id;
  final String slug;
  final int manufacturerId;
  final String brand;
  final String name;
  final String modeNumber;
  final String mpn;
  final String gtin;
  final String gtinType;
  final String description;
  final String originCountry;
  final int active;
  final bool requireShipping;
  final List<int> categoryList;
  const UpdateProductModel({
    required this.id,
    required this.slug,
    required this.manufacturerId,
    required this.brand,
    required this.name,
    required this.modeNumber,
    required this.mpn,
    required this.gtin,
    required this.gtinType,
    required this.description,
    required this.originCountry,
    required this.active,
    required this.requireShipping,
    required this.categoryList,
  });

  String get categoriesEndPoint =>
      categoryList.map((id) => "category_list[]=$id").join('&');
  String get endPoint =>
      'product/$id/update?name=$name&slug=$slug&active=$active&mpn=$mpn&gtin=$gtin&gtin_type=$gtinType&description=$description&requires_shipping=$requireShipping&manufacturer_id=$manufacturerId&brand=$brand&model_number=$modeNumber&$categoriesEndPoint';

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      slug,
      manufacturerId,
      brand,
      name,
      modeNumber,
      mpn,
      gtin,
      gtinType,
      description,
      originCountry,
      active,
      requireShipping,
      categoryList,
    ];
  }

  UpdateProductModel copyWith({
    int? id,
    String? slug,
    int? manufacturerId,
    String? brand,
    String? name,
    String? modeNumber,
    String? mpn,
    String? gtin,
    String? gtinType,
    String? description,
    String? originCountry,
    int? active,
    bool? requireShipping,
    List<int>? categoryList,
  }) {
    return UpdateProductModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      manufacturerId: manufacturerId ?? this.manufacturerId,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      modeNumber: modeNumber ?? this.modeNumber,
      mpn: mpn ?? this.mpn,
      gtin: gtin ?? this.gtin,
      gtinType: gtinType ?? this.gtinType,
      description: description ?? this.description,
      originCountry: originCountry ?? this.originCountry,
      active: active ?? this.active,
      requireShipping: requireShipping ?? this.requireShipping,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  @override
  String toString() {
    return 'UpdateProductModel(id: $id, slug: $slug, manufacturerId: $manufacturerId, brand: $brand, name: $name, modeNumber: $modeNumber, mpn: $mpn, gtin: $gtin, gtinType: $gtinType, description: $description, originCountry: $originCountry, active: $active, requireShipping: $requireShipping, categoryList: $categoryList)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'manufacturer_id': manufacturerId,
      'brand': brand,
      'name': name,
      'mode_number': modeNumber,
      'mpn': mpn,
      'gtin': gtin,
      'gtin_type': gtinType,
      'description': description,
      'origin_country': originCountry,
      'active': active,
      'require_shipping': requireShipping,
      'category_list': categoryList,
    };
  }

  factory UpdateProductModel.fromMap(Map<String, dynamic> map) {
    return UpdateProductModel(
      id: map['id']?.toInt() ?? 0,
      slug: map['slug'] ?? '',
      manufacturerId: map['manufacturer_id']?.toInt() ?? 0,
      brand: map['brand'] ?? '',
      name: map['name'] ?? '',
      modeNumber: map['mode_number'] ?? '',
      mpn: map['mpn'] ?? '',
      gtin: map['gtin'] ?? '',
      gtinType: map['gtin_type'] ?? '',
      description: map['description'] ?? '',
      originCountry: map['origin_country'] ?? '',
      active: map['active']?.toInt() ?? 0,
      requireShipping: map['require_shipping'] ?? false,
      categoryList: List<int>.from(map['category_list']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProductModel.fromJson(String source) =>
      UpdateProductModel.fromMap(json.decode(source));
}
