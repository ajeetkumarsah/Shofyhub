import 'dart:convert';

import 'package:equatable/equatable.dart';

class ValuesClass extends Equatable {
  final int id;
  final String value;
  final String color;
  final int order;
  const ValuesClass({
    required this.id,
    required this.value,
    required this.color,
    required this.order,
  });

  ValuesClass copyWith({
    int? id,
    String? value,
    String? color,
    int? order,
  }) {
    return ValuesClass(
      id: id ?? this.id,
      value: value ?? this.value,
      color: color ?? this.color,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'color': color,
      'order': order,
    };
  }

  factory ValuesClass.fromMap(Map<String, dynamic> map) {
    return ValuesClass(
      id: map['id']?.toInt() ?? 0,
      value: map['value'] ?? '',
      color: map['color'] ?? '',
      order: map['order']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ValuesClass.fromJson(String source) =>
      ValuesClass.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ValuesClass(id: $id, value: $value, color: $color, order: $order)';
  }

  @override
  List<Object> get props => [id, value, color, order];
  factory ValuesClass.init() => const ValuesClass(
        id: 0,
        value: '',
        color: '',
        order: 0,
      );
}
