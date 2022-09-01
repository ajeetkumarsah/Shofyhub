import 'dart:convert';

import 'package:equatable/equatable.dart';

class ShopUserDetailsModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String memberSince;
  final bool active;
  final String avatar;
  final int roleId;
  final String niceName;
  final String description;
  const ShopUserDetailsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.memberSince,
    required this.active,
    required this.avatar,
    required this.roleId,
    required this.niceName,
    required this.description,
  });

  ShopUserDetailsModel copyWith({
    int? id,
    String? name,
    String? email,
    String? memberSince,
    bool? active,
    String? avatar,
    int? roleId,
    String? niceName,
    String? description,
  }) {
    return ShopUserDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      memberSince: memberSince ?? this.memberSince,
      active: active ?? this.active,
      avatar: avatar ?? this.avatar,
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
      'active': active,
      'avatar': avatar,
      'role_id': roleId,
      'nice_name': niceName,
      'description': description,
    };
  }

  factory ShopUserDetailsModel.fromMap(Map<String, dynamic> map) {
    return ShopUserDetailsModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      memberSince: map['member_since'] ?? '',
      active: map['active'] ?? false,
      avatar: map['avatar'] ?? '',
      roleId: map['role_id']?.toInt() ?? 0,
      niceName: map['nice_name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopUserDetailsModel.fromJson(String source) =>
      ShopUserDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopUserDetailsModel(id: $id, name: $name, email: $email, memberSince: $memberSince, active: $active, avatar: $avatar, roleId: $roleId, niceName: $niceName, description: $description)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      memberSince,
      active,
      avatar,
      roleId,
      niceName,
      description,
    ];
  }

  factory ShopUserDetailsModel.init() => const ShopUserDetailsModel(
        id: 0,
        name: '',
        email: '',
        memberSince: '',
        active: false,
        avatar: '',
        roleId: 0,
        niceName: '',
        description: '',
      );
}
