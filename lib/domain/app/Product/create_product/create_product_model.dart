// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CreateProductModel extends Equatable {
  final int manufacturerId;
  final String brand;
  final String name;
  final String modeNumber;
  final String mpn;
  final String gtin;
  final String gtinType;
  final String description;
  final String minPrice;
  final String maxPrice;
  final String originCountry;
  final String hasVariant;
  final String downloadable;
  final String slug;
  final String saleCount;
  final List<int> categoryList;
  final List<int> tagList;
  final bool active;
  final bool requireShipping;
  const CreateProductModel({
    required this.manufacturerId,
    required this.brand,
    required this.name,
    required this.modeNumber,
    required this.mpn,
    required this.gtin,
    required this.gtinType,
    required this.description,
    required this.minPrice,
    required this.maxPrice,
    required this.originCountry,
    required this.hasVariant,
    required this.downloadable,
    required this.slug,
    required this.saleCount,
    required this.categoryList,
    required this.tagList,
    required this.active,
    required this.requireShipping,
  });

  String get tagsEndPoint => tagList.map((id) => "tag_list[]=$id").join('&');
  String get categoriesEndPoint =>
      tagList.map((id) => "category_list[]=$id").join('&');
  String get endPoint =>
      'product/create?name=$name&active=$active&mpn=$mpn&gtin=$gtin&gtin_type=$gtinType&description=$description&$tagsEndPoint&$categoriesEndPoint&requires_shipping=$requireShipping&manufacturer_id=$manufacturerId&brand=$brand&model_number=$modeNumber&origin_country=$originCountry&slug=$slug';

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      manufacturerId,
      brand,
      name,
      modeNumber,
      mpn,
      gtin,
      gtinType,
      description,
      minPrice,
      maxPrice,
      originCountry,
      hasVariant,
      downloadable,
      slug,
      saleCount,
      categoryList,
      tagList,
      active,
      requireShipping,
    ];
  }

  CreateProductModel copyWith({
    int? manufacturerId,
    String? brand,
    String? name,
    String? modeNumber,
    String? mpn,
    String? gtin,
    String? gtinType,
    String? description,
    String? minPrice,
    String? maxPrice,
    String? originCountry,
    String? hasVariant,
    String? downloadable,
    String? slug,
    String? saleCount,
    List<int>? categoryList,
    List<int>? tagList,
    bool? active,
    bool? requireShipping,
  }) {
    return CreateProductModel(
      manufacturerId: manufacturerId ?? this.manufacturerId,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      modeNumber: modeNumber ?? this.modeNumber,
      mpn: mpn ?? this.mpn,
      gtin: gtin ?? this.gtin,
      gtinType: gtinType ?? this.gtinType,
      description: description ?? this.description,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      originCountry: originCountry ?? this.originCountry,
      hasVariant: hasVariant ?? this.hasVariant,
      downloadable: downloadable ?? this.downloadable,
      slug: slug ?? this.slug,
      saleCount: saleCount ?? this.saleCount,
      categoryList: categoryList ?? this.categoryList,
      tagList: tagList ?? this.tagList,
      active: active ?? this.active,
      requireShipping: requireShipping ?? this.requireShipping,
    );
  }
}
