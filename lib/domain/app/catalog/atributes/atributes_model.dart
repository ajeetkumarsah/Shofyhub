import 'dart:convert';

import 'package:equatable/equatable.dart';

class AtributesModel extends Equatable {
  final int id;
  final String name;
  final String attributeType;
  final int entitiesCount;
  final int categoriesCount;
  final int order;
  const AtributesModel({
    required this.id,
    required this.name,
    required this.attributeType,
    required this.entitiesCount,
    required this.categoriesCount,
    required this.order,
  });

  AtributesModel copyWith({
    int? id,
    String? name,
    String? attributeType,
    int? entitiesCount,
    int? categoriesCount,
    int? order,
  }) {
    return AtributesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      attributeType: attributeType ?? this.attributeType,
      entitiesCount: entitiesCount ?? this.entitiesCount,
      categoriesCount: categoriesCount ?? this.categoriesCount,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'attribute_type': attributeType,
      'entities_count': entitiesCount,
      'categories_count': categoriesCount,
      'order': order,
    };
  }

  factory AtributesModel.fromMap(Map<String, dynamic> map) {
    return AtributesModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      attributeType: map['attribute_type'] ?? '',
      entitiesCount: map['entities_count']?.toInt() ?? 0,
      categoriesCount: map['categories_count']?.toInt() ?? 0,
      order: map['order']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AtributesModel.fromJson(String source) =>
      AtributesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AtributesModel(id: $id, name: $name, attributeType: $attributeType, entitiesCount: $entitiesCount, categoriesCount: $categoriesCount, order: $order)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      attributeType,
      entitiesCount,
      categoriesCount,
      order,
    ];
  }

  factory AtributesModel.init() => const AtributesModel(
        id: 0,
        name: '',
        attributeType: '',
        entitiesCount: 0,
        categoriesCount: 0,
        order: 0,
      );
}
