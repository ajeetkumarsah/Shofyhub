// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AttributeValuesModel extends Equatable {
  final int id;
  final String value;
  final String color;
  final int order;
  const AttributeValuesModel({
    required this.id,
    required this.value,
    required this.color,
    required this.order,
  });

  AttributeValuesModel copyWith({
    int? id,
    String? value,
    String? color,
    int? order,
  }) {
    return AttributeValuesModel(
      id: id ?? this.id,
      value: value ?? this.value,
      color: color ?? this.color,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'color': color,
      'order': order,
    };
  }

  factory AttributeValuesModel.fromMap(Map<String, dynamic> map) {
    return AttributeValuesModel(
      id: map['id']?.toInt() ?? 0,
      value: map['value'] ?? '',
      color: map['color'] ?? '',
      order: map['order']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeValuesModel.fromJson(String source) =>
      AttributeValuesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, value, color, order];

  factory AttributeValuesModel.init() =>
      const AttributeValuesModel(id: 0, value: '', color: '', order: 0);
}
