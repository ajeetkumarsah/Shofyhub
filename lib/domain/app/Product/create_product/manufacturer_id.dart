// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ManufacturerId extends Equatable {
  final String id;
  final String value;
  const ManufacturerId({
    required this.id,
    required this.value,
  });

  ManufacturerId copyWith({
    String? id,
    String? value,
  }) {
    return ManufacturerId(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
    };
  }

  factory ManufacturerId.fromMap(Map<String, dynamic> map) {
    return ManufacturerId(
      id: map['id'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ManufacturerId.fromJson(String source) => ManufacturerId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, value];
}
