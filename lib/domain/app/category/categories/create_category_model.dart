import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateCategoryModel extends Equatable {
  final int categorySubGroupId;
  final String name;
  final String slug;
  final String description;
  final String metaTitle;
  final String metaDescription;
  final String attributeIds;
  final bool active;
  final String order;
  const CreateCategoryModel({
    required this.categorySubGroupId,
    required this.name,
    required this.slug,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.attributeIds,
    required this.active,
    required this.order,
  });

  CreateCategoryModel copyWith({
    int? categorySubGroupId,
    String? name,
    String? slug,
    String? description,
    String? metaTitle,
    String? metaDescription,
    String? attributeIds,
    bool? active,
    String? order,
  }) {
    return CreateCategoryModel(
      categorySubGroupId: categorySubGroupId ?? this.categorySubGroupId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      attributeIds: attributeIds ?? this.attributeIds,
      active: active ?? this.active,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_sub_group_id': categorySubGroupId,
      'name': name,
      'slug': slug,
      'description': description,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'attribute_ids': attributeIds,
      'active': active,
      'order': order,
    };
  }

  factory CreateCategoryModel.fromMap(Map<String, dynamic> map) {
    return CreateCategoryModel(
      categorySubGroupId: map['category_sub_group_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      metaTitle: map['meta_title'] ?? '',
      metaDescription: map['meta_description'] ?? '',
      attributeIds: map['attribute_ids'] ?? '',
      active: map['active'] ?? false,
      order: map['order'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateCategoryModel.fromJson(String source) =>
      CreateCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateCategoryModel(categorySubGroupId: $categorySubGroupId, name: $name, slug: $slug, description: $description, metaTitle: $metaTitle, metaDescription: $metaDescription, attributeIds: $attributeIds, active: $active, order: $order)';
  }

  @override
  List<Object> get props {
    return [
      categorySubGroupId,
      name,
      slug,
      description,
      metaTitle,
      metaDescription,
      attributeIds,
      active,
      order,
    ];
  }
}
