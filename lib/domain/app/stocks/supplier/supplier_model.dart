import 'dart:convert';

import 'package:equatable/equatable.dart';

class SupplierModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? contactPerson;
  final String? image;
  final bool? active;
  const SupplierModel({
    this.id,
    this.name,
    this.email,
    this.contactPerson,
    this.image,
    this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact_person': contactPerson,
      'image': image,
      'active': active,
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      contactPerson: map['contact_person'] ?? '',
      image: map['image'] ?? '',
      active: map['active'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierModel.fromJson(String source) =>
      SupplierModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        contactPerson,
        image,
        active,
      ];
}
