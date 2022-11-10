// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int id;
  final String name;
  final String email;

  final String phone_number;
  final bool active;
  final String avatar;
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone_number,
    required this.active,
    required this.avatar,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? email,
    String? phone_number,
    bool? active,
    String? avatar,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone_number: phone_number ?? this.phone_number,
      active: active ?? this.active,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phone_number,
      'active': active,
      'avatar': avatar,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'].toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone_number: map['phone_number'] ?? '',
      active: map['active'] ?? false,
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phone_number,
      active,
      avatar,
    ];
  }

  factory Customer.init() => const Customer(
      id: 0, name: '', email: '', phone_number: '', active: false, avatar: '');
}
