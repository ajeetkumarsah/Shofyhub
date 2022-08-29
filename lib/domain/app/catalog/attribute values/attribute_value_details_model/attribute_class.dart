// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AttributeClass extends Equatable {
  final int id;
  final String name;
  final String attributeType;
  final int entitiesCount;
  final int categoriesCount;
  final int order;
  const AttributeClass({
    required this.id,
    required this.name,
    required this.attributeType,
    required this.entitiesCount,
    required this.categoriesCount,
    required this.order,
  });

  AttributeClass copyWith({
    int? id,
    String? name,
    String? attributeType,
    int? entitiesCount,
    int? categoriesCount,
    int? order,
  }) {
    return AttributeClass(
      id: id ?? this.id,
      name: name ?? this.name,
      attributeType: attributeType ?? this.attributeType,
      entitiesCount: entitiesCount ?? this.entitiesCount,
      categoriesCount: categoriesCount ?? this.categoriesCount,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'attribute_type': attributeType,
      'entities_count': entitiesCount,
      'categories_count': categoriesCount,
      'order': order,
    };
  }

  factory AttributeClass.fromMap(Map<String, dynamic> map) {
    return AttributeClass(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      attributeType: map['attribute_type'] ?? '',
      entitiesCount: map['entities_count']?.toInt() ?? 0,
      categoriesCount: map['categories_count']?.toInt() ?? 0,
      order: map['order']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeClass.fromJson(String source) =>
      AttributeClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

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

  factory AttributeClass.init() => const AttributeClass(
      id: 0,
      name: '',
      attributeType: '',
      entitiesCount: 0,
      categoriesCount: 0,
      order: 0);
}
