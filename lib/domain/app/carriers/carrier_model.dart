// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CarrierModel extends Equatable {
  final int id;
  final String name;
  final int tax_id;
  final String email;
  final String phone;
  final String tracking_url;
  final int active;
  const CarrierModel({
    required this.id,
    required this.name,
    required this.tax_id,
    required this.email,
    required this.phone,
    required this.tracking_url,
    required this.active,
  });

  CarrierModel copyWith({
    int? id,
    String? name,
    int? tax_id,
    String? email,
    String? phone,
    String? tracking_url,
    int? active,
  }) {
    return CarrierModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tax_id: tax_id ?? this.tax_id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      tracking_url: tracking_url ?? this.tracking_url,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tax_id': tax_id,
      'email': email,
      'phone': phone,
      'tracking_url': tracking_url,
      'active': active,
    };
  }

  factory CarrierModel.fromMap(Map<String, dynamic> map) {
    return CarrierModel(
      id: map['id'] as int,
      name: map['name'] as String,
      tax_id: map['tax_id'] as int,
      email: map['email'] as String,
      phone: map['phone'] as String,
      tracking_url: map['tracking_url'] as String,
      active: map['active'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarrierModel.fromJson(String source) =>
      CarrierModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      tax_id,
      email,
      phone,
      tracking_url,
      active,
    ];
  }

  factory CarrierModel.init() => const CarrierModel(
      id: 0,
      name: '',
      tax_id: 0,
      email: '',
      phone: '',
      tracking_url: '',
      active: 0);
}
