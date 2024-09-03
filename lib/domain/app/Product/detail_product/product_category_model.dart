import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/form/key_value_data.dart';

class Category extends Equatable {
  final int id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  Category copyWith({int? id, String? name}) {
    return Category(
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

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  KeyValueData toKeyValue() => KeyValueData(key: id.toString(), value: name);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
  factory Category.init() => const Category(id: 1, name: '');

  static from(map) {}
}
