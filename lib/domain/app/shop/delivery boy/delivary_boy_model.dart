import 'dart:convert';

import 'package:equatable/equatable.dart';

class DelivaryBoyModel extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String niceName;
  final String phoneNumber;
  final String email;
  final String sex;
  final String dob;
  final String status;
  final int active;
  final String memberSince;
  final String avatar;
  const DelivaryBoyModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.niceName,
    required this.phoneNumber,
    required this.email,
    required this.sex,
    required this.dob,
    required this.status,
    required this.active,
    required this.memberSince,
    required this.avatar,
  });

  DelivaryBoyModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? niceName,
    String? phoneNumber,
    String? email,
    String? sex,
    String? dob,
    String? status,
    int? active,
    String? memberSince,
    String? avatar,
  }) {
    return DelivaryBoyModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      niceName: niceName ?? this.niceName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      sex: sex ?? this.sex,
      dob: dob ?? this.dob,
      status: status ?? this.status,
      active: active ?? this.active,
      memberSince: memberSince ?? this.memberSince,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'nice_name': niceName,
      'phone_number': phoneNumber,
      'email': email,
      'sex': sex,
      'dob': dob,
      'status': status,
      'active': active,
      'member_since': memberSince,
      'avatar': avatar,
    };
  }

  factory DelivaryBoyModel.fromMap(Map<String, dynamic> map) {
    return DelivaryBoyModel(
      id: map['id']?.toInt() ?? 0,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      niceName: map['nice_name'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      email: map['email'] ?? '',
      sex: map['sex'] ?? '',
      dob: map['dob'] ?? '',
      status: map['status'] ?? '',
      active: map['active']?.toInt() ?? 0,
      memberSince: map['member_since'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DelivaryBoyModel.fromJson(String source) =>
      DelivaryBoyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DelivaryBoyModel(id: $id, firstName: $firstName, lastName: $lastName, niceName: $niceName, phoneNumber: $phoneNumber, email: $email, sex: $sex, dob: $dob, status: $status, active: $active, memberSince: $memberSince, avatar: $avatar)';
  }

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      niceName,
      phoneNumber,
      email,
      sex,
      dob,
      status,
      active,
      memberSince,
      avatar,
    ];
  }

  factory DelivaryBoyModel.init() => const DelivaryBoyModel(
      id: 0,
      firstName: '',
      lastName: '',
      niceName: '',
      phoneNumber: '',
      email: '',
      sex: '',
      dob: '',
      status: '',
      active: 0,
      memberSince: '',
      avatar: '0');
}
