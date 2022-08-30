// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/Product/Detail%20Product/manufacturer_model.dart';

class DetailProductModel extends Equatable {
  final int id;
  final String slug;
  final String name;
  final String modelNumber;
  final String gtin;
  final String gtinType;
  final String mpn;
  final String brand;
  final ManufacturerModel manufacturer;
  final String origin;
  final String listingCount;
  final String description;

  final String availableFrom;
  final String image;
  const DetailProductModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.modelNumber,
    required this.gtin,
    required this.gtinType,
    required this.mpn,
    required this.brand,
    required this.manufacturer,
    required this.origin,
    required this.listingCount,
    required this.description,
    required this.availableFrom,
    required this.image,
  });

  DetailProductModel copyWith({
    int? id,
    String? slug,
    String? name,
    String? modelNumber,
    String? gtin,
    String? gtinType,
    String? mpn,
    String? brand,
    ManufacturerModel? manufacturer,
    String? origin,
    String? listingCount,
    String? description,
    String? availableFrom,
    String? image,
  }) {
    return DetailProductModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      modelNumber: modelNumber ?? this.modelNumber,
      gtin: gtin ?? this.gtin,
      gtinType: gtinType ?? this.gtinType,
      mpn: mpn ?? this.mpn,
      brand: brand ?? this.brand,
      manufacturer: manufacturer ?? this.manufacturer,
      origin: origin ?? this.origin,
      listingCount: listingCount ?? this.listingCount,
      description: description ?? this.description,
      availableFrom: availableFrom ?? this.availableFrom,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
      'name': name,
      'modelNumber': modelNumber,
      'gtin': gtin,
      'gtinType': gtinType,
      'mpn': mpn,
      'brand': brand,
      'manufacturer': manufacturer.toMap(),
      'origin': origin,
      'listingCount': listingCount,
      'description': description,
      'availableFrom': availableFrom,
      'image': image,
    };
  }

  factory DetailProductModel.fromMap(Map<String, dynamic> map) {
    return DetailProductModel(
      id: map['id'] as int,
      slug: map['slug'] as String,
      name: map['name'] as String,
      modelNumber: map['modelNumber'] as String,
      gtin: map['gtin'] as String,
      gtinType: map['gtinType'] as String,
      mpn: map['mpn'] as String,
      brand: map['brand'] as String,
      manufacturer: ManufacturerModel.fromMap(
          map['manufacturer'] as Map<String, dynamic>),
      origin: map['origin'] as String,
      listingCount: map['listingCount'] as String,
      description: map['description'] as String,
      availableFrom: map['availableFrom'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailProductModel.fromJson(String source) =>
      DetailProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

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
      manufacturer,
      origin,
      listingCount,
      description,
      availableFrom,
      image,
    ];
  }

  factory DetailProductModel.init() => DetailProductModel(
        id: 0,
        slug: '',
        name: '',
        modelNumber: '',
        gtin: '',
        gtinType: '',
        mpn: '',
        brand: '',
        manufacturer: ManufacturerModel.init(),
        origin: '',
        listingCount: '',
        description: '',
        availableFrom: '',
        image: '',
      );
}
