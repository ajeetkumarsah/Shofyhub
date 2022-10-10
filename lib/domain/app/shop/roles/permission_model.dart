import 'dart:convert';

import 'package:equatable/equatable.dart';

class PermissionModel extends Equatable {
  final int id;
  final String name;
  final String slug;

  const PermissionModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  PermissionModel copyWith({
    int? id,
    String? name,
    String? slug,
  }) {
    return PermissionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  factory PermissionModel.fromMap(Map<String, dynamic> map) {
    return PermissionModel(
      id: map["id"]?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  factory PermissionModel.fromJson(String source) =>
      PermissionModel.fromMap(json.decode(source));

  factory PermissionModel.init() => const PermissionModel(
        id: 0,
        name: '',
        slug: '',
      );

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
      ];
}
