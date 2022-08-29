import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryAttribuitesModel extends Equatable {
  final String name;
  final String id;
  const CategoryAttribuitesModel({
    required this.name,
    required this.id,
  });

  CategoryAttribuitesModel copyWith({
    String? name,
    String? id,
  }) {
    return CategoryAttribuitesModel(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory CategoryAttribuitesModel.fromMap(Map<String, dynamic> map) {
    return CategoryAttribuitesModel(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryAttribuitesModel.fromJson(String source) =>
      CategoryAttribuitesModel.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryAttribuitesModel(name: $name, id: $id)';

  @override
  List<Object> get props => [name, id];
}
