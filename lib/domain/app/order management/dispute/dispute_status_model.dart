// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DisputeStatus extends Equatable {
  final int id;
  final String title;
  const DisputeStatus({
    required this.id,
    required this.title,
  });

  DisputeStatus copyWith({
    int? id,
    String? title,
  }) {
    return DisputeStatus(
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

  factory DisputeStatus.fromMap(Map<String, dynamic> map) {
    return DisputeStatus(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisputeStatus.fromJson(String source) =>
      DisputeStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title];

  factory DisputeStatus.init() => const DisputeStatus(id: 1, title: 'New');
}
