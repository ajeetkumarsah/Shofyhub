// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TagListModel extends Equatable {
  final String id;
  final String value;
  const TagListModel({
    required this.id,
    required this.value,
  });

  TagListModel copyWith({
    String? id,
    String? value,
  }) {
    return TagListModel(
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

  factory TagListModel.fromMap(Map<String, dynamic> map) {
    return TagListModel(
      id: map['id'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TagListModel.fromJson(String source) => TagListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, value];
}
