// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategorySubGroupModel extends Equatable {
  final int id;
  final int categoryGroupId;
  final String name;
  final String coverImage;
  final int categoriesCount;
  final bool active;
  const CategorySubGroupModel({
    required this.id,
    required this.categoryGroupId,
    required this.name,
    required this.coverImage,
    required this.categoriesCount,
    required this.active,
  });

  CategorySubGroupModel copyWith({
    int? id,
    int? categoryGroupId,
    String? name,
    String? coverImage,
    int? categoriesCount,
    bool? active,
  }) {
    return CategorySubGroupModel(
      id: id ?? this.id,
      categoryGroupId: categoryGroupId ?? this.categoryGroupId,
      name: name ?? this.name,
      coverImage: coverImage ?? this.coverImage,
      categoriesCount: categoriesCount ?? this.categoriesCount,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category_group_id': categoryGroupId,
      'name': name,
      'cover_image': coverImage,
      'categories_count': categoriesCount,
      'active': active,
    };
  }

  factory CategorySubGroupModel.fromMap(Map<String, dynamic> map) {
    return CategorySubGroupModel(
      id: map['id']?.toInt() ?? 0,
      categoryGroupId: map['category_group_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      coverImage: map['cover_image'] ?? '',
      categoriesCount: map['categories_count']?.toInt() ?? 0,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySubGroupModel.fromJson(String source) =>
      CategorySubGroupModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      categoryGroupId,
      name,
      coverImage,
      categoriesCount,
      active,
    ];
  }

  factory CategorySubGroupModel.init() => const CategorySubGroupModel(
      id: 0,
      categoryGroupId: 0,
      name: '',
      coverImage: '',
      categoriesCount: 0,
      active: false);
}
