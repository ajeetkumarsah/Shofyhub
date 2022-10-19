// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class InchargeModel extends Equatable {
  final int id;
  final String name;
  final int role_id;
  final String email;
  final bool active;
  final String avatar;
  const InchargeModel({
    required this.id,
    required this.role_id,
    required this.name,
    required this.active,
    required this.email,
    required this.avatar,
  });

  InchargeModel copyWith({
    int? id,
    String? name,
    int? role_id,
    String? email,
    int? shop_id,
    bool? active,
    String? avatar,
  }) {
    return InchargeModel(
      id: id ?? this.id,
      role_id: role_id ?? this.role_id,
      name: name ?? this.name,
      active: active ?? this.active,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role_id': role_id,
      'name': name,
      'active': active,
      'email': email,
      'avatar': avatar,
    };
  }

  factory InchargeModel.fromMap(Map<String, dynamic> map) {
    return InchargeModel(
      id: map['id']?.toInt() ?? 0,
      role_id: map['role_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      active: map['active'] ?? false,
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InchargeModel.fromJson(String source) =>
      InchargeModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      role_id,
      name,
      active,
      email,
      avatar,
    ];
  }

  factory InchargeModel.init() => const InchargeModel(
        id: 0,
        role_id: 0,
        name: '',
        active: false,
        email: '',
        avatar: '',
      );

  @override
  String toString() {
    return 'InchargeModel(id: $id,role_id: $role_id, name: $name,active: $active, email: $email, avatar: $avatar)';
  }
}
