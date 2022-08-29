import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoriesClass extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int categorySubGroupId;
  final String featureImage;
  const CategoriesClass({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.categorySubGroupId,
    required this.featureImage,
  });

  CategoriesClass copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? categorySubGroupId,
    String? featureImage,
  }) {
    return CategoriesClass(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      categorySubGroupId: categorySubGroupId ?? this.categorySubGroupId,
      featureImage: featureImage ?? this.featureImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'category_sub_group_id': categorySubGroupId,
      'feature_image': featureImage,
    };
  }

  factory CategoriesClass.fromMap(Map<String, dynamic> map) {
    return CategoriesClass(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      categorySubGroupId: map['category_sub_group_id']?.toInt() ?? 0,
      featureImage: map['feature_image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesClass.fromJson(String source) =>
      CategoriesClass.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoriesClass(id: $id, name: $name, slug: $slug, description: $description, categorySubGroupId: $categorySubGroupId, featureImage: $featureImage)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      description,
      categorySubGroupId,
      featureImage,
    ];
  }

  factory CategoriesClass.init() => const CategoriesClass(
        id: 0,
        name: '',
        slug: '',
        description: '',
        categorySubGroupId: 0,
        featureImage: '',
      );
}
