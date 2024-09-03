import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:alpesportif_seller/domain/app/shop/taxes/country_state_model.dart';

class TaxModel extends Equatable {
  final int id;
  final String name;
  final String taxrate;
  final bool active;
  final CountryStateModel country;
  // final CountryStateModel state;
  const TaxModel({
    required this.id,
    required this.name,
    required this.taxrate,
    required this.active,
    required this.country,
    // required this.state,
  });

  TaxModel copyWith({
    int? id,
    String? name,
    String? taxrate,
    bool? active,
    CountryStateModel? country,
    CountryStateModel? state,
  }) {
    return TaxModel(
      id: id ?? this.id,
      name: name ?? this.name,
      taxrate: taxrate ?? this.taxrate,
      active: active ?? this.active,
      country: country ?? this.country,
      // state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'taxrate': taxrate,
      'active': active,
      'country': country.toMap(),
      // 'state': state.toMap(),
    };
  }

  factory TaxModel.fromMap(Map<String, dynamic> map) {
    return TaxModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      taxrate: map['taxrate'] ?? '',
      active: map['active'] ?? false,
      country: CountryStateModel.fromMap(map['country']),
      // state: CountryStateModel.fromMap(map['state']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaxModel.fromJson(String source) =>
      TaxModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaxModel(id: $id, name: $name, taxrate: $taxrate, active: $active, country: $country)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      taxrate,
      active,
      country,
      // state,
    ];
  }

  factory TaxModel.init() => TaxModel(
        id: 0,
        name: '',
        taxrate: '',
        active: true,
        country: CountryStateModel.init(),
        // state: CountryStateModel.init()
      );
}
