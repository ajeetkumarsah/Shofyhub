import 'dart:convert';

import 'package:equatable/equatable.dart';

class ManufacturerModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String availableFrom;
  final String image;
  const ManufacturerModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.availableFrom,
    required this.image,
  });

  ManufacturerModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? availableFrom,
    String? image,
  }) {
    return ManufacturerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      availableFrom: availableFrom ?? this.availableFrom,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'available_from': availableFrom,
      'image': image,
    };
  }

  factory ManufacturerModel.fromMap(Map<String, dynamic> map) {
    return ManufacturerModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      availableFrom: map['available_from'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ManufacturerModel.fromJson(String source) =>
      ManufacturerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManufacturerModel(id: $id, name: $name, slug: $slug, availableFrom: $availableFrom, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      availableFrom,
      image,
    ];
  }

  factory ManufacturerModel.init() => const ManufacturerModel(
      id: 0, name: '', slug: '', availableFrom: '', image: '');
}
