// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentMethodModel extends Equatable {
  final int id;
  final String title;
  const PaymentMethodModel({
    required this.id,
    required this.title,
  });

  PaymentMethodModel copyWith({
    int? id,
    String? title,
  }) {
    return PaymentMethodModel(
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

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) =>
      PaymentMethodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title];

  factory PaymentMethodModel.init() =>
      const PaymentMethodModel(id: 1, title: 'New');
}
