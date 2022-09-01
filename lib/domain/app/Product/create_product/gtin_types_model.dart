// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GtinTypes extends Equatable {
  final String name;
  final String value;
  const GtinTypes({
    required this.name,
    required this.value,
  });

  GtinTypes copyWith({
    String? name,
    String? value,
  }) {
    return GtinTypes(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory GtinTypes.fromMap(Map<String, dynamic> map) {
    return GtinTypes(
      name: map['name'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GtinTypes.fromJson(String source) => GtinTypes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, value];
}
