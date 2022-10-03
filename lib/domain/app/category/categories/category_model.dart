// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final bool featured;
  final int categorySubGroupId;
  final String featureImage;
  final String coverImage;
  final bool active;
  const CategoryModel({
    required this.id,
    required this.name,
    required this.featured,
    required this.categorySubGroupId,
    required this.featureImage,
    required this.coverImage,
    required this.active,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    bool? featured,
    int? categorySubGroupId,
    String? featureImage,
    String? coverImage,
    bool? active,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      featured: featured ?? this.featured,
      categorySubGroupId: categorySubGroupId ?? this.categorySubGroupId,
      featureImage: featureImage ?? this.featureImage,
      coverImage: coverImage ?? this.coverImage,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'featured': featured,
      'category_sub_group_id': categorySubGroupId,
      'feature_image': featureImage,
      'cover_image': coverImage,
      'active': active,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      featured: map['featured'] as bool,
      categorySubGroupId: map['category_sub_group_id']?.toInt() ?? 0,
      featureImage: map['feature_image'] ?? '',
      coverImage: map['cover_image'] ?? '',
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      featured,
      categorySubGroupId,
      featureImage,
      coverImage,
      active,
    ];
  }

  factory CategoryModel.init() => const CategoryModel(
      id: 0,
      name: '',
      featured: false,
      categorySubGroupId: 0,
      featureImage: '',
      coverImage: '',
      active: false);
}
