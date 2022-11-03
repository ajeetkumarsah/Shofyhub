import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegistrationBody extends Equatable {
  final String shopName;
  final String email;
  final String phone;
  final String planId;
  final String password;
  final String confirmPassword;
  final bool agree;
  const RegistrationBody({
    required this.shopName,
    required this.email,
    required this.phone,
    required this.planId,
    required this.password,
    required this.confirmPassword,
    required this.agree,
  });

  RegistrationBody copyWith({
    String? shopName,
    String? email,
    String? phone,
    String? planId,
    String? password,
    String? confirmPassword,
    bool? agree,
  }) {
    return RegistrationBody(
      shopName: shopName ?? this.shopName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      planId: planId ?? this.planId,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      agree: agree ?? this.agree,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shop_name': shopName,
      'email': email,
      'phone': phone,
      'plan_id': planId,
      'password': password,
      'confirm_password': confirmPassword,
      'agree': agree,
    };
  }

  factory RegistrationBody.fromMap(Map<String, dynamic> map) {
    return RegistrationBody(
      shopName: map['shop_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      planId: map['plan_id'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirm_password'] ?? '',
      agree: map['agree'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationBody.fromJson(String source) =>
      RegistrationBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegistrationBody(shopName: $shopName, email: $email, planId: $planId, password: $password, confirmPassword: $confirmPassword, agree: $agree)';
  }

  @override
  List<Object> get props {
    return [
      shopName,
      email,
      planId,
      password,
      confirmPassword,
      agree,
    ];
  }

  factory RegistrationBody.init() => const RegistrationBody(
      shopName: '',
      email: '',
      phone: '',
      planId: '',
      password: '',
      confirmPassword: '',
      agree: false);
}
