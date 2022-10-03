import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:zcart_seller/domain/app/form/key_value_data.dart';

class CategoryDetailsModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool featured;
  final int categorySubGroupId;
  final String featureImage;
  final String coverImage;
  final IList<KeyValueData> attributes;
  final bool active;

  const CategoryDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.featured,
    required this.categorySubGroupId,
    required this.featureImage,
    required this.coverImage,
    required this.attributes,
    required this.active,
  });

  CategoryDetailsModel copyWith({
    int? id,
    String? name,
    String? description,
    bool? featured,
    int? categorySubGroupId,
    String? featureImage,
    String? coverImage,
    IList<KeyValueData>? attributes,
    bool? active,
  }) {
    return CategoryDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      featured: featured ?? this.featured,
      categorySubGroupId: categorySubGroupId ?? this.categorySubGroupId,
      featureImage: featureImage ?? this.featureImage,
      coverImage: coverImage ?? this.coverImage,
      attributes: attributes ?? this.attributes,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'featured': featured,
      'category_sub_group_id': categorySubGroupId,
      'feature_image': featureImage,
      'cover_image': coverImage,
      'active': active,
    };
  }

  factory CategoryDetailsModel.fromMap(Map<String, dynamic> map) {
    return CategoryDetailsModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      featured: map['featured'] ?? false,
      categorySubGroupId: map['category_sub_group_id']?.toInt() ?? 0,
      featureImage: map['feature_image'] ?? '',
      coverImage: map['cover_image'] ?? '',
      attributes: map['attributes'] != null && map['attributes'].isNotEmpty
          ? KeyValueData.listFromMap(map['attributes'] ?? {})
          : const IListConst([]),
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryDetailsModel.fromJson(String source) =>
      CategoryDetailsModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      featured,
      categorySubGroupId,
      featureImage,
      coverImage,
      attributes,
      active,
    ];
  }

  factory CategoryDetailsModel.init() => const CategoryDetailsModel(
        id: 0,
        name: '',
        featured: false,
        categorySubGroupId: 0,
        featureImage: '',
        coverImage: '',
        description: '',
        attributes: IListConst([]),
        active: false,
      );

  @override
  String toString() {
    return 'CategoryDetailsModel(id: $id, name: $name, description: $description, featured: $featured, categorySubGroupId: $categorySubGroupId, featureImage: $featureImage, coverImage: $coverImage, attributes: $attributes, active: $active)';
  }
}
