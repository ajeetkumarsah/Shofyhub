import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryGroupModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;

  final String icon;
  final String iconImage;
  final String coverImage;
  const CategoryGroupModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.icon,
    required this.iconImage,
    required this.coverImage,
  });

  CategoryGroupModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? icon,
    String? iconImage,
    String? coverImage,
  }) {
    return CategoryGroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      iconImage: iconImage ?? this.iconImage,
      coverImage: coverImage ?? this.coverImage,
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
    };
  }

  factory CategoryGroupModel.fromMap(Map<String, dynamic> map) {
    return CategoryGroupModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
      iconImage: map['icon_image'] ?? '',
      coverImage: map['cover_image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryGroupModel.fromJson(String source) =>
      CategoryGroupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryGroupModel(id: $id, name: $name, slug: $slug, description: $description, icon: $icon, iconImage: $iconImage, coverImage: $coverImage)';
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
    ];
  }

  factory CategoryGroupModel.init() => const CategoryGroupModel(
      id: 0,
      name: '',
      slug: '',
      description: '',
      icon: '',
      iconImage: '',
      coverImage: '');
}
