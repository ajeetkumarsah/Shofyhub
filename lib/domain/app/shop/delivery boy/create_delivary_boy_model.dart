import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateDelivaryBoyModel extends Equatable {
  final int shopId;
  final String firstName;
  final String lastName;
  final String niceName;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;
  final String sex;
  final String dob;
  final int status;

  const CreateDelivaryBoyModel({
    required this.shopId,
    required this.firstName,
    required this.lastName,
    required this.niceName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.sex,
    required this.dob,
    required this.status,
  });

  CreateDelivaryBoyModel copyWith({
    int? shopId,
    String? firstName,
    String? lastName,
    String? niceName,
    String? phoneNumber,
    String? email,
    String? password,
    String? confirmPassword,
    String? sex,
    String? dob,
    int? status,
  }) {
    return CreateDelivaryBoyModel(
      shopId: shopId ?? this.shopId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      niceName: niceName ?? this.niceName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      sex: sex ?? this.sex,
      dob: dob ?? this.dob,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shop_id': shopId,
      'first_name': firstName,
      'last_name': lastName,
      'nice_name': niceName,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'sex': sex,
      'dob': dob,
      'status': status,
    };
  }

  factory CreateDelivaryBoyModel.fromMap(Map<String, dynamic> map) {
    return CreateDelivaryBoyModel(
      shopId: map['shop_id']?.toInt() ?? 0,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      niceName: map['nice_name'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirm_password'] ?? '',
      sex: map['sex'] ?? '',
      dob: map['dob'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateDelivaryBoyModel.fromJson(String source) =>
      CreateDelivaryBoyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateDelivaryBoyModel(shopId: $shopId, firstName: $firstName, lastName: $lastName, niceName: $niceName, phoneNumber: $phoneNumber, email: $email, password: $password, confirmPassword: $confirmPassword, sex: $sex, dob: $dob, status: $status)';
  }

  @override
  List<Object> get props {
    return [
      shopId,
      firstName,
      lastName,
      niceName,
      phoneNumber,
      email,
      password,
      confirmPassword,
      sex,
      dob,
      status,
    ];
  }

  factory CreateDelivaryBoyModel.init() => const CreateDelivaryBoyModel(
        password: '',
        confirmPassword: '',
        shopId: 0,
        firstName: '',
        lastName: '',
        niceName: '',
        phoneNumber: '',
        email: '',
        sex: '',
        dob: '',
        status: 0,
      );
}
