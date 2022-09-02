import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryStateModel extends Equatable {
  final int id;
  final String name;
  final String isoCode;
  const CountryStateModel({
    required this.id,
    required this.name,
    required this.isoCode,
  });

  CountryStateModel copyWith({
    int? id,
    String? name,
    String? isoCode,
  }) {
    return CountryStateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isoCode: isoCode ?? this.isoCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iso_code': isoCode,
    };
  }

  factory CountryStateModel.fromMap(Map<String, dynamic> map) {
    return CountryStateModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      isoCode: map['iso_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryStateModel.fromJson(String source) =>
      CountryStateModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CountryStateModel(id: $id, name: $name, isoCode: $isoCode)';

  @override
  List<Object> get props => [id, name, isoCode];

  factory CountryStateModel.init() =>
      const CountryStateModel(id: 0, name: '', isoCode: '');
}
