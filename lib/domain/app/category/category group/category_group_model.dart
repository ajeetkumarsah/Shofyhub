import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryGroupModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int subGroup;

  final String icon;
  final String iconImage;
  final String coverImage;
  final bool active;
  const CategoryGroupModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.subGroup,
    required this.icon,
    required this.iconImage,
    required this.coverImage,
    required this.active,
  });

  CategoryGroupModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? subGroup,
    String? icon,
    String? iconImage,
    String? coverImage,
    bool? active,
  }) {
    return CategoryGroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      subGroup: subGroup ?? this.subGroup,
      icon: icon ?? this.icon,
      iconImage: iconImage ?? this.iconImage,
      coverImage: coverImage ?? this.coverImage,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'sub_groups_count': subGroup,
      'icon': icon,
      'icon_image': iconImage,
      'cover_image': coverImage,
      'active': active,
    };
  }

  factory CategoryGroupModel.fromMap(Map<String, dynamic> map) {
    return CategoryGroupModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      subGroup: map['sub_groups_count'] ?? '',
      icon: map['icon'] ?? '',
      iconImage: map['icon_image'] ?? '',
      coverImage: map['cover_image'] ?? '',
      active: map['active'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryGroupModel.fromJson(String source) =>
      CategoryGroupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryGroupModel(id: $id, name: $name, slug: $slug, description: $description, icon: $icon, iconImage: $iconImage, coverImage: $coverImage, subGroup: $subGroup, active: $active)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      description,
      subGroup,
      icon,
      iconImage,
      coverImage,
      active,
    ];
  }

  factory CategoryGroupModel.init() => const CategoryGroupModel(
        id: 0,
        name: '',
        slug: '',
        description: '',
        subGroup: 0,
        icon: '',
        iconImage: '',
        coverImage: '',
        active: false,
      );
}
