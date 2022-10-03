import 'dart:convert';
import 'package:equatable/equatable.dart';

class CreateCategorySubGroupModel extends Equatable {
  final int categoryGroupId;
  final String name;
  final String slug;
  final String description;
  final String metaTitle;
  final String metaDescription;
  final int active;
  final int order;
  const CreateCategorySubGroupModel({
    required this.categoryGroupId,
    required this.name,
    required this.slug,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.active,
    required this.order,
  });

  CreateCategorySubGroupModel copyWith({
    int? categoryGroupId,
    String? name,
    String? slug,
    String? description,
    String? metaTitle,
    String? metaDescription,
    int? active,
    int? order,
    String? coverImage,
  }) {
    return CreateCategorySubGroupModel(
      categoryGroupId: categoryGroupId ?? this.categoryGroupId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      active: active ?? this.active,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category_group_id': categoryGroupId,
      'name': name,
      'slug': slug,
      'description': description,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'active': active,
      'order': order,
    };
  }

  factory CreateCategorySubGroupModel.fromMap(Map<String, dynamic> map) {
    return CreateCategorySubGroupModel(
      categoryGroupId: map['category_group_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      metaTitle: map['meta_title'] ?? '',
      metaDescription: map['meta_description'] ?? '',
      active: map['active'] as int,
      order: map['order']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateCategorySubGroupModel.fromJson(String source) =>
      CreateCategorySubGroupModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      categoryGroupId,
      name,
      slug,
      description,
      metaTitle,
      metaDescription,
      active,
      order,
    ];
  }
}
