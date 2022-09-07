import 'dart:convert';

import 'package:equatable/equatable.dart';

class ManufacturerModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  const ManufacturerModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  ManufacturerModel copyWith({
    int? id,
    String? name,
    String? slug,
  }) {
    return ManufacturerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory ManufacturerModel.fromMap(Map<String, dynamic> map) {
    return ManufacturerModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ManufacturerModel.fromJson(String source) =>
      ManufacturerModel.fromMap(json.decode(source));

  @override
  String toString() => 'ManufacturerModel(id: $id, name: $name, slug: $slug)';

  @override
  List<Object> get props => [id, name, slug];
  factory ManufacturerModel.init() =>
      const ManufacturerModel(id: 0, name: '', slug: '');
}
