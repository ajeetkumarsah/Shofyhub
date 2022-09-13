import 'dart:convert';

import 'package:equatable/equatable.dart';

class ManufacturerProductModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  const ManufacturerProductModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  ManufacturerProductModel copyWith({
    int? id,
    String? name,
    String? slug,
  }) {
    return ManufacturerProductModel(
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

  factory ManufacturerProductModel.fromMap(Map<String, dynamic> map) {
    return ManufacturerProductModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ManufacturerProductModel.fromJson(String source) =>
      ManufacturerProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'ManufacturerModel(id: $id, name: $name, slug: $slug)';

  @override
  List<Object> get props => [id, name, slug];
  factory ManufacturerProductModel.init() =>
      const ManufacturerProductModel(id: 0, name: '', slug: '');
}
