import 'dart:convert';

import 'package:equatable/equatable.dart';

class WarehouseModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final dynamic incharge;
  final List<String> businessDays;
  final bool active;
  final String image;
  const WarehouseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.incharge,
    required this.businessDays,
    required this.active,
    required this.image,
  });

  WarehouseModel copyWith({
    int? id,
    String? name,
    String? email,
    dynamic incharge,
    List<String>? businessDays,
    bool? active,
    String? image,
  }) {
    return WarehouseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      incharge: incharge ?? this.incharge,
      businessDays: businessDays ?? this.businessDays,
      active: active ?? this.active,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'incharge': incharge,
      'business_days': businessDays,
      'active': active,
      'image': image,
    };
  }

  factory WarehouseModel.fromMap(Map<String, dynamic> map) {
    return WarehouseModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      incharge: map['incharge'] ?? '',
      businessDays: List<String>.from(map['business_days'] ?? const []),
      active: map['active'] ?? false,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehouseModel.fromJson(String source) =>
      WarehouseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WarehouseModel(id: $id, name: $name, email: $email, incharge: $incharge, businessDays: $businessDays, active: $active, image: $image)';
  }

  factory WarehouseModel.init() => const WarehouseModel(
        id: 0,
        name: '',
        email: '',
        incharge: '',
        businessDays: [],
        active: false,
        image: '',
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      incharge,
      businessDays,
      active,
      image,
    ];
  }
}
