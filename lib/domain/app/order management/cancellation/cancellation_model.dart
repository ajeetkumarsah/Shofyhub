import 'dart:convert';

import 'package:equatable/equatable.dart';

class CancellationModel extends Equatable {
  final int id;
  final String name;
  final dynamic taxId;
  final String email;
  final String phone;
  final String trackingUrl;
  final bool active;

  const CancellationModel({
    required this.id,
    required this.name,
    required this.taxId,
    required this.email,
    required this.phone,
    required this.trackingUrl,
    required this.active,
  });

  CancellationModel copyWith({
    int? id,
    String? name,
    dynamic taxId,
    String? email,
    String? phone,
    String? trackingUrl,
    bool? active,
  }) {
    return CancellationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      taxId: taxId ?? this.taxId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      trackingUrl: trackingUrl ?? this.trackingUrl,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'taxId': taxId,
      'email': email,
      'phone': phone,
      'tracking_url': trackingUrl,
      'active': active,
    };
  }

  factory CancellationModel.fromMap(Map<String, dynamic> map) {
    return CancellationModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      taxId: map['taxId'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      trackingUrl: map['tracking_url'] ?? '',
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CancellationModel.fromJson(String source) =>
      CancellationModel.fromMap(json.decode(source));

  factory CancellationModel.init() => const CancellationModel(
        id: 0,
        name: '',
        taxId: 0,
        email: '',
        phone: '',
        trackingUrl: '',
        active: false,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        taxId,
        email,
        phone,
        trackingUrl,
        active,
      ];
}
