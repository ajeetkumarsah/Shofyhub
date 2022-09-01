import 'dart:convert';
import 'package:equatable/equatable.dart';

class CreateShopUserModel extends Equatable {
  final int shopId;
  final int roleId;
  final String name;
  final String niceName;
  final String email;
  final String password;
  final String dob;
  final String sex;
  final String description;
  const CreateShopUserModel({
    required this.shopId,
    required this.roleId,
    required this.name,
    required this.niceName,
    required this.email,
    required this.password,
    required this.dob,
    required this.sex,
    required this.description,
  });

  CreateShopUserModel copyWith({
    int? shopId,
    int? roleId,
    String? name,
    String? niceName,
    String? email,
    String? password,
    String? dob,
    String? sex,
    String? description,
  }) {
    return CreateShopUserModel(
      shopId: shopId ?? this.shopId,
      roleId: roleId ?? this.roleId,
      name: name ?? this.name,
      niceName: niceName ?? this.niceName,
      email: email ?? this.email,
      password: password ?? this.password,
      dob: dob ?? this.dob,
      sex: sex ?? this.sex,
      description: description ?? this.description,
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
      'dob': dob,
      'sex': sex,
      'description': description,
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
      dob: map['dob'] ?? '',
      sex: map['sex'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateShopUserModel.fromJson(String source) =>
      CreateShopUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateUserModel(shopId: $shopId, roleId: $roleId, name: $name, niceName: $niceName, email: $email, password: $password, dob: $dob, sex: $sex, description: $description)';
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
      dob,
      sex,
      description,
    ];
  }

  factory CreateShopUserModel.init() => const CreateShopUserModel(
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
