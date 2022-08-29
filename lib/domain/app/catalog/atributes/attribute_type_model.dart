// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AttributeTypeModel extends Equatable {
  final String id;
  final String name;
  const AttributeTypeModel({
    required this.id,
    required this.name,
  });

  AttributeTypeModel copyWith({
    String? id,
    String? name,
  }) {
    return AttributeTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory AttributeTypeModel.fromMap(Map<String, dynamic> map) {
    return AttributeTypeModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeTypeModel.fromJson(String source) =>
      AttributeTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
  factory AttributeTypeModel.init() =>
      const AttributeTypeModel(id: '', name: '');

  static from(map) {}
}
