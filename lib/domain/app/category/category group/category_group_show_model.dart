// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryGroupDetailsModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String icon;
  final String iconImage;
  final String coverImage;
  final String metaTitle;
  final String metaDescription;
  final int order;
  final bool active;
  const CategoryGroupDetailsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.icon,
    required this.iconImage,
    required this.coverImage,
    required this.metaTitle,
    required this.metaDescription,
    required this.order,
    required this.active,
  });

  factory CategoryGroupDetailsModel.init() => const CategoryGroupDetailsModel(
        id: 0,
        name: '',
        slug: '',
        description: '',
        icon: '',
        iconImage: '',
        coverImage: '',
        metaTitle: '',
        metaDescription: '',
        order: 0,
        active: false,
      );

  CategoryGroupDetailsModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? icon,
    String? iconImage,
    String? coverImage,
    String? metaTitle,
    String? metaDescription,
    int? order,
    bool? active,
  }) {
    return CategoryGroupDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      iconImage: iconImage ?? this.iconImage,
      coverImage: coverImage ?? this.coverImage,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      order: order ?? this.order,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'icon': icon,
      'icon_image': iconImage,
      'cover_image': coverImage,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'order': order,
      'active': active,
    };
  }

  factory CategoryGroupDetailsModel.fromMap(Map<String, dynamic> map) {
    return CategoryGroupDetailsModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
      iconImage: map['icon_image'] ?? '',
      coverImage: map['cover_image'] ?? '',
      metaTitle: map['meta_title'] ?? '',
      metaDescription: map['meta_description'] ?? '',
      order: map['order']?.toInt() ?? 0,
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryGroupDetailsModel.fromJson(String source) =>
      CategoryGroupDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryGroupDetailsModel(id: $id, name: $name, slug: $slug, description: $description, icon: $icon, iconImage: $iconImage, coverImage: $coverImage, metaTitle: $metaTitle, metaDescription: $metaDescription, order: $order, active: $active)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      description,
      icon,
      iconImage,
      coverImage,
      metaTitle,
      metaDescription,
      order,
      active,
    ];
  }
}
