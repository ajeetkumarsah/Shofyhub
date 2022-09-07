// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final int shop_id;
  final int role_id;
  final String name;
  final String nice_name;
  final String dob;
  final String sex;
  final String description;
  final bool active;
  final String email;
  final String member_since;
  final String avatar;
  final String api_token;
  const UserModel({
    required this.id,
    required this.shop_id,
    required this.role_id,
    required this.name,
    required this.nice_name,
    required this.dob,
    required this.sex,
    required this.description,
    required this.active,
    required this.email,
    required this.member_since,
    required this.avatar,
    required this.api_token,
  });

  UserModel copyWith({
    int? id,
    int? shop_id,
    int? role_id,
    String? name,
    String? nice_name,
    String? dob,
    String? sex,
    String? description,
    bool? active,
    String? email,
    String? member_since,
    String? avatar,
    String? api_token,
  }) {
    return UserModel(
      id: id ?? this.id,
      shop_id: shop_id ?? this.shop_id,
      role_id: role_id ?? this.role_id,
      name: name ?? this.name,
      nice_name: nice_name ?? this.nice_name,
      dob: dob ?? this.dob,
      sex: sex ?? this.sex,
      description: description ?? this.description,
      active: active ?? this.active,
      email: email ?? this.email,
      member_since: member_since ?? this.member_since,
      avatar: avatar ?? this.avatar,
      api_token: api_token ?? this.api_token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shop_id': shop_id,
      'role_id': role_id,
      'name': name,
      'nice_name': nice_name,
      'dob': dob,
      'sex': sex,
      'description': description,
      'active': active,
      'email': email,
      'member_since': member_since,
      'avatar': avatar,
      'api_token': api_token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      shop_id: map['shop_id']?.toInt() ?? 0,
      role_id: map['role_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      nice_name: map['nice_name'] ?? '',
      dob: map['dob'] ?? '',
      sex: map['sex'] ?? '',
      description: map['description'] ?? '',
      active: map['active'] ?? false,
      email: map['email'] ?? '',
      member_since: map['member_since'] ?? '',
      avatar: map['avatar'] ?? '',
      api_token: map['api_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      shop_id,
      role_id,
      name,
      nice_name,
      dob,
      sex,
      description,
      active,
      email,
      member_since,
      avatar,
      api_token,
    ];
  }

  factory UserModel.init() => const UserModel(
      id: 0,
      shop_id: 0,
      role_id: 0,
      name: '',
      nice_name: '',
      dob: '',
      sex: '',
      description: '',
      active: false,
      email: '',
      member_since: '',
      avatar: '',
      api_token: '');

  @override
  String toString() {
    return 'UserModel(id: $id, shop_id: $shop_id, role_id: $role_id, name: $name, nice_name: $nice_name, dob: $dob, sex: $sex, description: $description, active: $active, email: $email, member_since: $member_since, avatar: $avatar, api_token: $api_token)';
  }
}
