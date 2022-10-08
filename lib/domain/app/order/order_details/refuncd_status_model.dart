// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RefundStatus extends Equatable {
  final int id;
  final String title;
  const RefundStatus({
    required this.id,
    required this.title,
  });

  RefundStatus copyWith({
    int? id,
    String? title,
  }) {
    return RefundStatus(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': title,
    };
  }

  factory RefundStatus.fromMap(Map<String, dynamic> map) {
    return RefundStatus(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RefundStatus.fromJson(String source) =>
      RefundStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title];

  factory RefundStatus.init() => const RefundStatus(id: 1, title: 'New');
}
