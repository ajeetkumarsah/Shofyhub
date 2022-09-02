import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateShopUserModel extends Equatable {
  final int shopId;
  final int roleId;
  final String name;
  final String niceName;
  final String email;
  final String password;
  final String confirmPassword;
  final String dob;
  final String sex;
  final String description;
  final int active;
  const CreateShopUserModel({
    required this.shopId,
    required this.roleId,
    required this.name,
    required this.niceName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.dob,
    required this.sex,
    required this.description,
    required this.active,
  });

  CreateShopUserModel copyWith({
    int? shopId,
    int? roleId,
    String? name,
    String? niceName,
    String? email,
    String? password,
    String? confirmPassword,
    String? dob,
    String? sex,
    String? description,
    int? active,
  }) {
    return CreateShopUserModel(
      shopId: shopId ?? this.shopId,
      roleId: roleId ?? this.roleId,
      name: name ?? this.name,
      niceName: niceName ?? this.niceName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      dob: dob ?? this.dob,
      sex: sex ?? this.sex,
      description: description ?? this.description,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shop_id': shopId,
      'role_id': roleId,
      'name': name,
      'nice_name': niceName,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'dob': dob,
      'sex': sex,
      'description': description,
      'active': active,
    };
  }

  factory CreateShopUserModel.fromMap(Map<String, dynamic> map) {
    return CreateShopUserModel(
      shopId: map['shop_id']?.toInt() ?? 0,
      roleId: map['role_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      niceName: map['nice_name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirm_password'] ?? '',
      dob: map['dob'] ?? '',
      sex: map['sex'] ?? '',
      description: map['description'] ?? '',
      active: map['active']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateShopUserModel.fromJson(String source) =>
      CreateShopUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateShopUserModel(shopId: $shopId, roleId: $roleId, name: $name, niceName: $niceName, email: $email, password: $password, confirmPassword: $confirmPassword, dob: $dob, sex: $sex, description: $description, active: $active)';
  }

  @override
  List<Object> get props {
    return [
      shopId,
      roleId,
      name,
      niceName,
      email,
      password,
      confirmPassword,
      dob,
      sex,
      description,
      active,
    ];
  }

  factory CreateShopUserModel.init() => const CreateShopUserModel(
        active: 1,
        confirmPassword: '',
        shopId: 0,
        roleId: 0,
        name: '',
        niceName: '',
        email: '',
        password: '',
        dob: '',
        sex: '',
        description: '',
      );

  static from(map) {}
}
