import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopUsersModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String memberSince;
  final String avatar;
  final bool active;
  final int roleId;
  final String niceName;
  final String description;
  const ShopUsersModel({
    required this.id,
    required this.name,
    required this.email,
    required this.memberSince,
    required this.avatar,
    required this.active,
    required this.roleId,
    required this.niceName,
    required this.description,
  });

  ShopUsersModel copyWith({
    int? id,
    String? name,
    String? email,
    String? memberSince,
    String? avatar,
    bool? active,
    int? roleId,
    String? niceName,
    String? description,
  }) {
    return ShopUsersModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      memberSince: memberSince ?? this.memberSince,
      avatar: avatar ?? this.avatar,
      active: active ?? this.active,
      roleId: roleId ?? this.roleId,
      niceName: niceName ?? this.niceName,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'member_since': memberSince,
      'avatar': avatar,
      'active': active,
      'role_id': roleId,
      'nice_name': niceName,
      'description': description,
    };
  }

  factory ShopUsersModel.fromMap(Map<String, dynamic> map) {
    return ShopUsersModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      memberSince: map['member_since'] ?? '',
      avatar: map['avatar'] ?? '',
      active: map['active'] ?? false,
      roleId: map['role_id']?.toInt() ?? 0,
      niceName: map['nice_name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopUsersModel.fromJson(String source) =>
      ShopUsersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopUsersModel(id: $id, name: $name, email: $email, memberSince: $memberSince, avatar: $avatar, active: $active, roleId: $roleId, niceName: $niceName, description: $description)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      memberSince,
      avatar,
      active,
      roleId,
      niceName,
      description,
    ];
  }

  factory ShopUsersModel.init() => const ShopUsersModel(
      id: 0,
      name: '',
      email: '',
      memberSince: '',
      avatar: '',
      active: false,
      roleId: 0,
      niceName: '',
      description: '');
}
