// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ParentGroupModel extends Equatable {
  final int id;
  final String name;
  final String deletedAt; // it is a datetime type
  const ParentGroupModel({
    required this.id,
    required this.name,
    required this.deletedAt,
  });

  ParentGroupModel copyWith({
    int? id,
    String? name,
    String? attributeType,
    String? deletedAt,
  }) {
    return ParentGroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'deleted_at': deletedAt,
    };
  }

  factory ParentGroupModel.fromMap(Map<String, dynamic> map) {
    return ParentGroupModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      deletedAt: map['deleted_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ParentGroupModel.fromJson(String source) =>
      ParentGroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, deletedAt];

  factory ParentGroupModel.int() =>
      const ParentGroupModel(id: 0, name: '', deletedAt: '');
}
