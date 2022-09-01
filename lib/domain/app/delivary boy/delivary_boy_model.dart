// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DelivaryBoy extends Equatable {
  final String id;
  final String name;
  const DelivaryBoy({
    required this.id,
    required this.name,
  });

  DelivaryBoy copyWith({
    String? id,
    String? name,
  }) {
    return DelivaryBoy(
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

  factory DelivaryBoy.fromMap(Map<String, dynamic> map) {
    return DelivaryBoy(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DelivaryBoy.fromJson(String source) =>
      DelivaryBoy.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];

  factory DelivaryBoy.init() => const DelivaryBoy(id: '', name: '');
}
