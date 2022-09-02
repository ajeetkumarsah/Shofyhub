// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/category/category%20sub%20group/details%20model/parent_group_model.dart';

class CategorySubGroupDetailsModel extends Equatable {
  final int id;
  final int categoryGroupId;
  final String name;
  final String slug;
  final String description;
  final String coverImage;
  final bool active;
  const CategorySubGroupDetailsModel({
    required this.id,
    required this.categoryGroupId,
    required this.name,
    required this.slug,
    required this.description,
    required this.coverImage,
    required this.active,
  });

  CategorySubGroupDetailsModel copyWith({
    int? id,
    int? categoryGroupId,
    String? name,
    String? slug,
    String? description,
    String? coverImage,
    ParentGroupModel? parentGroup,
    bool? active,
  }) {
    return CategorySubGroupDetailsModel(
      id: id ?? this.id,
      categoryGroupId: categoryGroupId ?? this.categoryGroupId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_group_id': categoryGroupId,
      'name': name,
      'slug': slug,
      'description': description,
      'cover_image': coverImage,
      'active': active,
    };
  }

  factory CategorySubGroupDetailsModel.fromMap(Map<String, dynamic> map) {
    return CategorySubGroupDetailsModel(
      id: map['id']?.toInt() ?? 0,
      categoryGroupId: map['category_group_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      coverImage: map['cover_image'] ?? '',
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySubGroupDetailsModel.fromJson(String source) =>
      CategorySubGroupDetailsModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      categoryGroupId,
      name,
      slug,
      description,
      coverImage,
      active,
    ];
  }

  factory CategorySubGroupDetailsModel.init() =>
      const CategorySubGroupDetailsModel(
          id: 0,
          categoryGroupId: 0,
          name: '',
          slug: '',
          description: '',
          coverImage: '',
          active: false);

  @override
  String toString() {
    return 'CategorySubGroupDetailsModel(id: $id, categoryGroupId: $categoryGroupId, name: $name, slug: $slug, description: $description, coverImage: $coverImage, active: $active)';
  }
}
