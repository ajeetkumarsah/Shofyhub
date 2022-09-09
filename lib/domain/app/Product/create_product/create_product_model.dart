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

  final String originCountry;

  final String slug;

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
    required this.originCountry,
    required this.slug,
    required this.categoryList,
    required this.tagList,
    required this.active,
    required this.requireShipping,
  });

  String get tagsEndPoint => tagList.map((id) => "tag_list[]=$id").join('&');
  String get categoriesEndPoint =>
      categoryList.map((id) => "category_list[]=$id").join('&');
  String get endPoint =>
      'product/create?name=$name&active=$active&mpn=$mpn&gtin=$gtin&gtin_type=$gtinType&description=$description&$tagsEndPoint&requires_shipping=$requireShipping&manufacturer_id=$manufacturerId&brand=$brand&model_number=$modeNumber&origin_country=$originCountry&slug=$slug&$categoriesEndPoint';

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
      originCountry,
      slug,
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
    String? originCountry,
    String? slug,
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
      originCountry: originCountry ?? this.originCountry,
      slug: slug ?? this.slug,
      categoryList: categoryList ?? this.categoryList,
      tagList: tagList ?? this.tagList,
      active: active ?? this.active,
      requireShipping: requireShipping ?? this.requireShipping,
    );
  }
}
