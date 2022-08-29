// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdateCategoryModel extends Equatable {
  final int category_sub_group_id;
  final String name;
  final String slug;
  final String description;
  final String featured;
  final String meta_title;
  final String meta_description;
  const UpdateCategoryModel({
    required this.category_sub_group_id,
    required this.name,
    required this.slug,
    required this.description,
    required this.featured,
    required this.meta_title,
    required this.meta_description,
  });

  UpdateCategoryModel copyWith({
    int? category_sub_group_id,
    String? name,
    String? slug,
    String? description,
    String? featured,
    String? meta_title,
    String? meta_description,
  }) {
    return UpdateCategoryModel(
      category_sub_group_id:
          category_sub_group_id ?? this.category_sub_group_id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      featured: featured ?? this.featured,
      meta_title: meta_title ?? this.meta_title,
      meta_description: meta_description ?? this.meta_description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_sub_group_id': category_sub_group_id,
      'name': name,
      'slug': slug,
      'description': description,
      'featured': featured,
      'meta_title': meta_title,
      'meta_description': meta_description,
    };
  }

  factory UpdateCategoryModel.fromMap(Map<String, dynamic> map) {
    return UpdateCategoryModel(
      category_sub_group_id: map['category_sub_group_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      featured: map['featured'] ?? '',
      meta_title: map['meta_title'] ?? '',
      meta_description: map['meta_description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateCategoryModel.fromJson(String source) =>
      UpdateCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateCategoryModel(category_sub_group_id: $category_sub_group_id, name: $name, slug: $slug, description: $description, featured: $featured, meta_title: $meta_title, meta_description: $meta_description)';
  }

  @override
  List<Object> get props {
    return [
      category_sub_group_id,
      name,
      slug,
      description,
      featured,
      meta_title,
      meta_description,
    ];
  }
}
