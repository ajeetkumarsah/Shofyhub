import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateTaxModel extends Equatable {
  final String name;
  final int taxrate;
  final String countryId;
  final String stateId;
  final int active;
  const CreateTaxModel({
    required this.name,
    required this.taxrate,
    required this.countryId,
    required this.stateId,
    required this.active,
  });

  CreateTaxModel copyWith({
    String? name,
    int? taxrate,
    String? countryId,
    String? stateId,
    int? active,
  }) {
    return CreateTaxModel(
      name: name ?? this.name,
      taxrate: taxrate ?? this.taxrate,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'taxrate': taxrate,
      'country_id': countryId,
      'state_id': stateId,
      'active': active,
    };
  }

  factory CreateTaxModel.fromMap(Map<String, dynamic> map) {
    return CreateTaxModel(
      name: map['name'] ?? '',
      taxrate: map['taxrate']?.toInt() ?? 0,
      countryId: map['country_id'] ?? '',
      stateId: map['state_id'] ?? '',
      active: map['active']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateTaxModel.fromJson(String source) =>
      CreateTaxModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateTaxModel(name: $name, taxrate: $taxrate, countryId: $countryId, stateId: $stateId, active: $active)';
  }

  @override
  List<Object> get props {
    return [
      name,
      taxrate,
      countryId,
      stateId,
      active,
    ];
  }

  factory CreateTaxModel.init() => const CreateTaxModel(
      name: '', taxrate: 0, countryId: '', stateId: '', active: 1);
}
