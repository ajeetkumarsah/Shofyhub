// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final int id;
  final int order;
  final String type;
  final String code;
  final String name;
  const PaymentMethod({
    required this.id,
    required this.order,
    required this.type,
    required this.code,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order': order,
      'type': type,
      'code': code,
      'name': name,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as int,
      order: map['order'] as int,
      type: map['type'] as String,
      code: map['code'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      order,
      type,
      code,
      name,
    ];
  }

  PaymentMethod copyWith({
    int? id,
    int? order,
    String? type,
    String? code,
    String? name,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      order: order ?? this.order,
      type: type ?? this.type,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  factory PaymentMethod.init() =>
      const PaymentMethod(id: 0, order: 0, type: '', code: '', name: '');
}
