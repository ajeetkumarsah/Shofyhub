import 'dart:convert';

import 'package:equatable/equatable.dart';

class AttributeTypeClass extends Equatable {
  final int id;
  final String type;
  const AttributeTypeClass({
    required this.id,
    required this.type,
  });

  AttributeTypeClass copyWith({
    int? id,
    String? type,
  }) {
    return AttributeTypeClass(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
    };
  }

  factory AttributeTypeClass.fromMap(Map<String, dynamic> map) {
    return AttributeTypeClass(
      id: map['id']?.toInt() ?? 0,
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeTypeClass.fromJson(String source) =>
      AttributeTypeClass.fromMap(json.decode(source));

  @override
  String toString() => 'AttributeType(id: $id, type: $type)';

  @override
  List<Object> get props => [id, type];

  factory AttributeTypeClass.init() => const AttributeTypeClass(
        id: 0,
        type: '',
      );

  map(Function(dynamic e) param0) {}
}
